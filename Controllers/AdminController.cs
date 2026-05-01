using Restorant_Sitesi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web.Helpers;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
namespace Restorant_Sitesi.Controllers
{
    [Authorize]
    public class AdminController : Controller 
    {
        WRestourantDBEntities db = new WRestourantDBEntities();
        public AdminController()
        {

        }
      
        public ActionResult Index()
        {
            var gecmisRezervasyonlar = db.REZARVASYONLAR
                                    .Where(x => x.DurumID == 2 && x.Tarih < DateTime.Today)
                                    .ToList();

            if (gecmisRezervasyonlar.Count > 0)
            {
                foreach (var rez in gecmisRezervasyonlar)
                {
                    if (rez.MasaID != null)
                    {
                        var masa = db.MASALAR.Find(rez.MasaID);
                        if (masa != null)
                        {
                            masa.Durum = false;
                        }
                    }
                    rez.DurumID = 4;
                }
                db.SaveChanges();
            }
            ViewBag.ToplamRezervasyon = db.REZARVASYONLAR.Count();
            ViewBag.ToplamUrun = db.URUNLER.Count();
            ViewBag.ToplamZiyaretci = 120;
            ViewBag.BekleyenYorum = db.YORUMLAR.Where(x => x.Durum == false).Count();

            var sonRezervasyonlar = db.REZARVASYONLAR.OrderByDescending(x => x.RezervasyonID).Take(10).ToList();
            var sonYorumlar = db.YORUMLAR.OrderByDescending(x => x.YorumID).Take(10).ToList();
            var sonBlogYorumlar = db.DUYURUBLOGYORUMLARI.OrderByDescending(x => x.YorumID).Take(10).ToList();
            return View(Tuple.Create(sonRezervasyonlar, sonYorumlar, sonBlogYorumlar));
        }
        public ActionResult RezervasyonGelmedi(int id,string returnUrl)
        {
            var rez = db.REZARVASYONLAR.Find(id);
            if (rez != null)
            {

                if (rez.MasaID != null)
                {
                    var masa = db.MASALAR.Find(rez.MasaID);
                    if (masa != null)
                    {
                        masa.Durum = false;
                    }

                }
                rez.DurumID = 5;
                db.SaveChanges();
                try
                {
                    string mailIcerik = $"Sayın {rez.MusteriAdSoyad},<br/><br/>" +
                                        $"{rez.Tarih.Value.ToString("dd.MM.yyyy HH:mm")} tarihindeki rezervasyonunuza katılım sağlamadığınız görülmüştür.<br/>" +
                                        $"Masayı sizin için beklettik ancak süre dolduğu için iptal edilmiştir.<br/>" +
                                        $"Bir sonraki rezervasyonunuzda görüşmek dileğiyle.<br/><br/>" +
                                        $"- Moly RS Ekibi";

                    MailGonder(rez.Mail, "Rezervasyon Durumu: Gelmediniz", mailIcerik);
                }
                catch (Exception) { }
            }
            if (!string.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index");
        }
        public ActionResult BildirimKutusu()
        {

            var bekleyenRez = db.REZARVASYONLAR
                                .Where(x => x.DurumID == 1 && x.Tarih >= DateTime.Today)
                                .OrderByDescending(x => x.RezervasyonID)
                                .Take(5)
                                .ToList();


            var bekleyenYorum = db.YORUMLAR
                                  .Where(x => x.Durum == false)
                                  .OrderByDescending(x => x.YorumID)
                                  .Take(5)
                                  .ToList();


            var bekleyenBlogYorum = db.DUYURUBLOGYORUMLARI
                                      .Where(x => x.Durum == false)
                                      .OrderByDescending(x => x.YorumID)
                                      .Take(5)
                                      .ToList();

            ViewBag.BildirimSayisi = bekleyenRez.Count + bekleyenYorum.Count + bekleyenBlogYorum.Count;


            return PartialView(Tuple.Create(bekleyenRez, bekleyenYorum, bekleyenBlogYorum));
        }
        [HttpGet]
        public JsonResult GetUygunMasalar(int kisiSayisi)
        {
            var masalar = db.MASALAR
                            .Where(x => x.Durum == false && x.Kapasite >= kisiSayisi)
                            .Select(x => new
                            {
                                x.MasaID,
                                x.MasaNo,
                                x.Kapasite
                            }).ToList();

            return Json(masalar, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]

        public ActionResult RezervasyonOnayla(int rezervasyonId, int masaId, string returnUrl, DateTime? yeniTarih, string yeniSaat)
        {
            var rez = db.REZARVASYONLAR.Find(rezervasyonId);
            var yeniMasa = db.MASALAR.Find(masaId);

            if (rez != null && yeniMasa != null)
            {
                // 1. Eski Bilgileri Yedekle
                string eskiTarih = rez.Tarih?.ToString("dd.MM.yyyy") ?? "-";
                string eskiSaat = rez.Saat?.ToString() ?? "-";
                string eskiMasaNo = rez.MASALAR != null ? rez.MASALAR.MasaNo.ToString() : "Atanmamış";

                // 2. Değişiklik kontrol değişkenleri
                bool tarihDegisti = false;
                bool saatDegisti = false;
                bool masaDegisti = false;

                // 3. TARİH KONTROLÜ
                if (yeniTarih != null && rez.Tarih != yeniTarih)
                {
                    rez.Tarih = yeniTarih;
                    tarihDegisti = true;
                }

                // 4. SAAT KONTROLÜ
                if (!string.IsNullOrEmpty(yeniSaat))
                {
                    TimeSpan girilenSaat = TimeSpan.Parse(yeniSaat);

                    if (rez.Saat != girilenSaat)
                    {
                        rez.Saat = girilenSaat;
                        saatDegisti = true;
                    }
                }

                // 5. MASA KONTROLÜ (KRİTİK DÜZELTME)
                bool masaIlkAtama = rez.MasaID == null || rez.MasaID == 0;

                if (rez.MasaID != masaId)
                {
                    // Eğer daha önce masa atanmışsa bu bir revizedir
                    if (!masaIlkAtama)
                    {
                        var eskiMasa = db.MASALAR.Find(rez.MasaID);
                        if (eskiMasa != null)
                            eskiMasa.Durum = false;

                        masaDegisti = true;
                    }

                    // Yeni masayı ata
                    rez.MasaID = masaId;
                    yeniMasa.Durum = true;
                }

                // 6. REVİZE KARARI (SADECE GERÇEK DEĞİŞİKLİKLER)
                bool revizeEdildi = tarihDegisti || saatDegisti || masaDegisti;

                // 7. DURUM GÜNCELLE
                rez.DurumID = 2; // Onaylandı

                db.SaveChanges();

                string mailKonu = "";
                string mailIcerik = "";

                if (revizeEdildi)
                {
                    mailKonu = "Rezervasyon Bilgileriniz Revize Edildi";
                    mailIcerik = $@"
        <div style='font-family: Arial, sans-serif; color: #333;'>
            <h3>Sayın {rez.MusteriAdSoyad},</h3>
            <p>Talebiniz doğrultusunda rezervasyon bilgileriniz revize edilmiştir.</p>
            <hr style='border: 1px solid #eee;'/>
            <p><b>ESKİ BİLGİLER:</b><br/>
            Tarih: {eskiTarih} | Saat: {eskiSaat} | Masa: {eskiMasaNo}</p>

            <p style='color: #28a745;'><b>YENİ BİLGİLER:</b><br/>
            Tarih: {rez.Tarih?.ToString("dd.MM.yyyy")} | Saat: {rez.Saat} | Masa: {yeniMasa.MasaNo}</p>
            <hr style='border: 1px solid #eee;'/>
            <p>Bizi tercih ettiğiniz için teşekkür ederiz.<br/>
            - Moly RS Ekibi</p>
        </div>";
                }
                else
                {
                    mailKonu = "Rezervasyon Onayı";

                    // Saat formatını hh:mm yaparak (18:00 gibi) daha sade gösteriyoruz
                    string gorunurSaat = rez.Saat?.ToString(@"hh\:mm") ?? "-";

                    mailIcerik = $@"
        <div style='font-family: Arial, sans-serif; color: #333; line-height: 1.6;'>
            Sayın {rez.MusteriAdSoyad},<br/><br/>
            {rez.Tarih?.ToString("dd.MM.yyyy")} tarihindeki saat <b>{gorunurSaat}</b> rezervasyonunuz onaylanmıştır.<br/><br/>
            Masa Numaranız: <b>{yeniMasa.MasaNo}</b><br/><br/>
            Sizi ağırlamaktan mutluluk duyarız.<br/>
            - Moly RS Ekibi
        </div>";
                }
                // 9. MAIL GÖNDER
                MailGonder(rez.Mail, mailKonu, mailIcerik);
            }

            // 10. REDIRECT
            if (!string.IsNullOrEmpty(returnUrl))
                return Redirect(returnUrl);

            return RedirectToAction("Rezervasyonlar");
        }
        public ActionResult RezervasyonIptal(int id, string returnUrl)
        {
            var rez = db.REZARVASYONLAR.Find(id);
            if (rez != null)
            {

                if (rez.MasaID != null)
                {
                    var masa = db.MASALAR.Find(rez.MasaID);
                    if (masa != null)
                    {
                        masa.Durum = false;
                    }
                    rez.MasaID = null;
                }

                rez.DurumID = 3;
                db.SaveChanges();

                try
                {
                    string mailIcerik = $"Sayın {rez.MusteriAdSoyad},<br/><br/>" +
                                        $"{rez.Tarih.Value.ToString("dd.MM.yyyy")} tarihindeki rezervasyonunuz ne yazık ki iptal edilmiştir.<br/>" +
                                        $"Yeni bir rezervasyon oluşturmak isterseniz sitemizi ziyaret edebilirsiniz.<br/><br/>" +
                                        $"- Moly RS Ekibi";

                    MailGonder(rez.Mail, "Rezervasyon İptali Bilgilendirme", mailIcerik);
                }
                catch (Exception)
                {

                }
            }

            if (!string.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index");
        }
        public ActionResult RezervasyonBeklemeyeAl(int id, string returnUrl)
        {
            var rez = db.REZARVASYONLAR.Find(id);
            if (rez != null)
            {
                if (rez.MasaID != null)
                {
                    var masa = db.MASALAR.Find(rez.MasaID);
                    if (masa != null)
                    {
                        masa.Durum = false;
                    }
                    rez.MasaID = null;
                }
                rez.DurumID = 1;
                db.SaveChanges();
                try
                {
                    string mailIcerik = $"Sayın {rez.MusteriAdSoyad},<br/><br/>" +
                                        $"{rez.Tarih.Value.ToString("dd.MM.yyyy")} tarihindeki rezervasyonunuzla ilgili bir değişiklik yapılmıştır.<br/>" +
                                        $"Rezervasyonunuz şu anda tekrar <b>değerlendirme aşamasına</b> (Beklemede) alınmıştır.<br/>" +
                                        $"En kısa sürede size tekrar bilgi verilecektir.<br/><br/>" +
                                        $"- Moly RS Ekibi";

                    MailGonder(rez.Mail, "Rezervasyon Durum Güncellemesi", mailIcerik);
                }
                catch (Exception)
                {

                }
            }
            if (!string.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);
            }

            return RedirectToAction("Index");
        }
        public ActionResult RezervasyonTamamla(int id, string returnUrl)
        {
            var rez = db.REZARVASYONLAR.Find(id);
            if (rez != null)
            {

                if (rez.MasaID != null)
                {
                    var masa = db.MASALAR.Find(rez.MasaID);
                    if (masa != null)
                    {
                        masa.Durum = false;
                    }
                }
                rez.DurumID = 4;
                db.SaveChanges();
            }
            if (!string.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Rezervasyonlar(string aramaMetni, DateTime? aramaTarihi)
        {

            var liste = db.REZARVASYONLAR.ToList();

           
            if (!string.IsNullOrEmpty(aramaMetni))
            {
                liste = liste.Where(x => x.MusteriAdSoyad.ToLower().Contains(aramaMetni.ToLower())).ToList();
            }

           
            if (aramaTarihi != null)
            {
                liste = liste.Where(x => x.Tarih == aramaTarihi).ToList();
            }

           
            return View(liste.OrderByDescending(x => x.RezervasyonID).ToList());
        }
        public ActionResult YorumOnayla(int id)
        {
            var yorum = db.YORUMLAR.Find(id);
            if (yorum != null)
            {
                yorum.Durum = true;
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }
        public ActionResult YorumSil(int id)
        {
            var yorum = db.YORUMLAR.Find(id);
            if (yorum != null)
            {
                db.YORUMLAR.Remove(yorum);
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }
        public ActionResult YorumKaldir(int id)
        {
            var yorum = db.YORUMLAR.Find(id);
            if (yorum != null)
            {
                yorum.Durum = false;
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        public void MailGonder(string aliciMail, string konu, string icerik)
        {
            string gonderenMail = ConfigurationManager.AppSettings["EmailAdresi"];
            string sifre = ConfigurationManager.AppSettings["UygulamaSifresi"];

            try
            {
                // HATA TESPİTİ 1: Dosyadan veri okunabiliyor mu?
                if (string.IsNullOrWhiteSpace(gonderenMail) || string.IsNullOrWhiteSpace(sifre))
                {
                    // Eğer buraya girerse config dosyan okunmuyor demektir.
                    throw new Exception("Config dosyasından mail veya şifre okunamadı! Anahtar isimlerini kontrol et.");
                }

                SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential(gonderenMail, sifre);

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(gonderenMail, "MolyRS");
                mail.To.Add(aliciMail);
                mail.Subject = konu;
                mail.IsBodyHtml = true;
                mail.Body = icerik;

                client.Send(mail);
            }
            catch (Exception ex)
            {
                // HATA TESPİTİ 2: Neden gitmediğini ekrana yazdırıyoruz.
                // TempData kullanarak hatayı sayfaya fırlatalım
                TempData["MailHatasi"] = "Mail Hatası: " + ex.Message;
                // Ya da debug ekranına yazdır:
                System.Diagnostics.Debug.WriteLine("MAIL HATASI: " + ex.Message);

                // Geliştirme aşamasında hatayı doğrudan görmen için:
                throw new Exception("Mail Gönderim Hatası: " + ex.Message);
            }
        }

        public ActionResult SliderYonetimi()
        {
            var liste = db.ANASAYFA.OrderByDescending(x => x.AnasayfaID).ToList();
            return View(liste);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SliderKaydet(ANASAYFA veri, HttpPostedFileBase ResimDosyasi, string EskiResimYolu)
        {
            if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
            {
                if (ResimDosyasi.ContentType == "image/jpeg" || ResimDosyasi.ContentType == "image/jpg" || ResimDosyasi.ContentType == "image/png")
                {
                    if (!string.IsNullOrEmpty(EskiResimYolu))
                    {
                        var silinecekYol = Server.MapPath(EskiResimYolu);
                        if (System.IO.File.Exists(silinecekYol))
                        {
                            System.IO.File.Delete(silinecekYol);
                        }
                    }
                    var uzanti = Path.GetExtension(ResimDosyasi.FileName);
                    var yeniAd = Guid.NewGuid().ToString() + uzanti;
                    var yol = Path.Combine(Server.MapPath("~/images/"), yeniAd);
                    WebImage img = new WebImage(ResimDosyasi.InputStream);
                    if (img.Width > 1200) img.Resize(1200, 1200, preserveAspectRatio: true, preventEnlarge: true);
                    img.Save(yol);

                    veri.Resim = "/images/" + yeniAd;
                }
            }
            else
            {
                veri.Resim = EskiResimYolu;
            }
            if (veri.AnasayfaID == 0)
            {
                db.ANASAYFA.Add(veri);
                TempData["Basarili"] = "Yeni slider başarıyla eklendi!";
            }
            else
            {
                db.Entry(veri).State = System.Data.Entity.EntityState.Modified;
                TempData["Bilgi"] = "Slider başarıyla güncellendi!";
            }

            db.SaveChanges();
            return RedirectToAction("SliderYonetimi");
        }

        public ActionResult SliderSil(int id)
        {
            var veri = db.ANASAYFA.Find(id);
            if (veri != null)
            {
                // Silerken de sunucudaki fiziksel resmi bul ve yok et!
                if (!string.IsNullOrEmpty(veri.Resim))
                {
                    var silinecekYol = Server.MapPath(veri.Resim);
                    if (System.IO.File.Exists(silinecekYol))
                    {
                        System.IO.File.Delete(silinecekYol);
                    }
                }

                db.ANASAYFA.Remove(veri);
                db.SaveChanges();
                TempData["Hata"] = "Slider sistemden kalıcı olarak silindi!";
            }
            return RedirectToAction("SliderYonetimi");
        }
        [HttpPost]
        public JsonResult SliderGuncelle(int id)
        {
            var veri = db.ANASAYFA.Find(id);
            if (veri != null)
            {
                return Json(new
                {
                    baslik = veri.Baslik,
                    icerik = veri.Icerik,
                    aciklama = veri.Aciklama,
                    resim = veri.Resim,
                    durum = veri.Durum
                });
            }
            return Json(null);
        }
        public ActionResult BlogVeDuyuru()
        {
            var bloglar = db.DUYURULABLOGLAR.OrderByDescending(x => x.DuyuruID).ToList();
            var yorumlar = db.DUYURUBLOGYORUMLARI.OrderByDescending(x => x.YorumID).ToList();
            var model = Tuple.Create(bloglar, yorumlar);
            return View(model);
        }

        // --- DÜZENLEME İÇİN VERİ GETİR (AJAX) ---
        [HttpPost]
        public JsonResult BlogGetir(int id)
        {
            var veri = db.DUYURULABLOGLAR.Find(id);
            return Json(new
            {
                id = veri.DuyuruID,
                baslik = veri.Baslik,
                yazar = veri.Yazar,
                icerik = veri.Icerik,
                resim = veri.Resim,
                durum = veri.Durum
            });
        }

        // --- KAYDET / GÜNCELLE ---
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult BlogKaydet(DUYURULABLOGLAR b, HttpPostedFileBase resimDosyasi)
        {
            var guncellenecek = db.DUYURULABLOGLAR.Find(b.DuyuruID);
            bool yeniKayit = false;

            if (guncellenecek == null)
            {
                guncellenecek = new DUYURULABLOGLAR();
                guncellenecek.Tarih = DateTime.Now;
                yeniKayit = true;
            }

            // RESİM YÜKLEME VE ESKİ DOSYAYI SİLME
            if (resimDosyasi != null && resimDosyasi.ContentLength > 0)
            {
                // Eski resim varsa sunucudan fiziksel olarak sil
                if (!string.IsNullOrEmpty(guncellenecek.Resim))
                {
                    string eskiYol = Server.MapPath(guncellenecek.Resim);
                    if (System.IO.File.Exists(eskiYol)) System.IO.File.Delete(eskiYol);
                }

                // Yeni resmi GUID ile isimlendir
                string dosyaAdi = Guid.NewGuid().ToString().Substring(0, 8) + "-" + Path.GetFileName(resimDosyasi.FileName);
                string yol = "/images/" + dosyaAdi;
                resimDosyasi.SaveAs(Server.MapPath(yol));
                guncellenecek.Resim = yol;
            }

            guncellenecek.Baslik = b.Baslik;
            guncellenecek.Yazar = b.Yazar;
            guncellenecek.Icerik = b.Icerik;
            guncellenecek.Durum = b.Durum;

            if (yeniKayit) db.DUYURULABLOGLAR.Add(guncellenecek);

            db.SaveChanges();

            // Layout'taki Toastr sistemiyle uyumlu bildirim
            TempData["Basarili"] = yeniKayit ? "Blog başarıyla eklendi." : "Blog başarıyla güncellendi.";
            return RedirectToAction("BlogVeDuyuru");
        }

        // --- BLOG SİL ---
        public ActionResult BlogSil(int id)
        {
            var silinecek = db.DUYURULABLOGLAR.Find(id);
            if (silinecek != null)
            {
                // Bağlı resmi sunucudan temizle
                if (!string.IsNullOrEmpty(silinecek.Resim))
                {
                    string yol = Server.MapPath(silinecek.Resim);
                    if (System.IO.File.Exists(yol)) System.IO.File.Delete(yol);
                }

                db.DUYURULABLOGLAR.Remove(silinecek);
                db.SaveChanges();
                TempData["Basarili"] = "Blog ve bağlı resmi kalıcı olarak silindi.";
            }
            return RedirectToAction("BlogVeDuyuru");
        }

        // --- YORUM İŞLEMLERİ ---
        public ActionResult BlogYorumOnayla(int id)
        {
            var yorum = db.DUYURUBLOGYORUMLARI.Find(id);
            if (yorum != null)
            {
                yorum.Durum = true;
                db.SaveChanges();
                TempData["Basarili"] = "Yorum onaylandı ve yayına alındı.";
            }
            return RedirectToAction("BlogVeDuyuru");
        }

        public ActionResult BlogYorumKaldir(int id)
        {
            var yorum = db.DUYURUBLOGYORUMLARI.Find(id);
            if (yorum != null)
            {
                yorum.Durum = false;
                db.SaveChanges();
                TempData["Bilgi"] = "Yorum yayından kaldırıldı.";
            }
            return RedirectToAction("BlogVeDuyuru");
        }

        public ActionResult BlogYorumSil(int id)
        {
            var yorum = db.DUYURUBLOGYORUMLARI.Find(id);
            if (yorum != null)
            {
                db.DUYURUBLOGYORUMLARI.Remove(yorum);
                db.SaveChanges();
                TempData["Basarili"] = "Yorum başarıyla silindi.";
            }
            return RedirectToAction("BlogVeDuyuru");
        }

        public ActionResult HakkimizdaYonetim()
        {
            var liste = db.HAKKIMDA.ToList();
            return View(liste);
        }


        [HttpPost]
        public JsonResult HakkimizdaGetir(int id)
        {
            var veri = db.HAKKIMDA.Find(id);
            return Json(new
            {
                id = veri.HakkimdaID,
                baslik = veri.Baslik,
                icerik = veri.Icerik,
                resim = veri.Resim
            });
        }


        [HttpPost]
        [ValidateInput(false)]
        public ActionResult HakkimizdaKaydet(HAKKIMDA model, HttpPostedFileBase ResimDosyasi, string EskiResimYolu)
        {
            var guncellenecek = db.HAKKIMDA.Find(model.HakkimdaID);
            bool yeniKayit = false;
            if (guncellenecek == null)
            {
                guncellenecek = new HAKKIMDA();
                yeniKayit = true;
            }
            if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
            {
                if (!string.IsNullOrEmpty(EskiResimYolu))
                {
                    string eskiYol = Server.MapPath(EskiResimYolu);
                    if (System.IO.File.Exists(eskiYol)) System.IO.File.Delete(eskiYol);
                }

                string dosyaAdi = Guid.NewGuid().ToString().Substring(0, 8) + "-" + Path.GetFileName(ResimDosyasi.FileName);
                string yol = "/images/" + dosyaAdi;
                ResimDosyasi.SaveAs(Server.MapPath(yol));

                guncellenecek.Resim = yol;
            }
            guncellenecek.Baslik = model.Baslik;
            guncellenecek.Icerik = model.Icerik;
            if (yeniKayit)
            {
                db.HAKKIMDA.Add(guncellenecek);
            }

            db.SaveChanges();
            TempData["Basarili"] = yeniKayit ? "Yeni kayıt başarıyla eklendi!" : "İçerik başarıyla güncellendi!";

            return RedirectToAction("HakkimizdaYonetim");
        }
        public ActionResult HakkimizdaSil(int id)
        {
            var silinecek = db.HAKKIMDA.Find(id);
            if (silinecek != null)
            {
                if (!string.IsNullOrEmpty(silinecek.Resim))
                {
                    string silinecekYol = Server.MapPath(silinecek.Resim);
                    if (System.IO.File.Exists(silinecekYol)) System.IO.File.Delete(silinecekYol);
                }
                db.HAKKIMDA.Remove(silinecek);
                db.SaveChanges();
                TempData["Hata"] = "Kayıt sistemden kalıcı olarak silindi!";
            }
            return RedirectToAction("HakkimizdaYonetim");
        }
        public ActionResult KategoriListesi()
        {
            var kategoriler = db.KATEGORILER.OrderByDescending(x => x.KategoriID).ToList();
            return View(kategoriler);
        }

        [HttpGet]
        public ActionResult KategoriEkle() => View();

        [HttpPost]
        public ActionResult KategoriEkle(KATEGORILER k)
        {
            db.KATEGORILER.Add(k);
            db.SaveChanges();
            TempData["Basarili"] = "Kategori başarıyla eklendi!";
            return RedirectToAction("KategoriListesi");
        }

        [HttpGet]
        public ActionResult KategoriGuncelle(int id)
        {
            var kat = db.KATEGORILER.Find(id);
            if (kat == null) return HttpNotFound();

            return View(kat);
        }

        // --- DEĞİŞİKLİKLERİ KAYDEDER (POST) ---
        [HttpPost]
        public ActionResult KategoriGuncelle(KATEGORILER k)
        {
            var guncellenecek = db.KATEGORILER.Find(k.KategoriID);

            if (guncellenecek != null)
            {
                guncellenecek.KategoriAd = k.KategoriAd;
                // Eğer başka kolonlar varsa (Durum, İkon vb.) buraya ekleyebilirsin.

                db.SaveChanges();
                TempData["Basarili"] = "Kategori bilgileri başarıyla güncellendi.";
            }
            else
            {
                TempData["Hata"] = "Kategori bulunamadı!";
            }

            return RedirectToAction("KategoriListesi");
        }

        public ActionResult KategoriSil(int id)
        {
            var kat = db.KATEGORILER.Find(id);
            db.KATEGORILER.Remove(kat);
            db.SaveChanges();
            TempData["Basarili"] = "Kategori başarıyla silindi.";
            return RedirectToAction("KategoriListesi");
        }

        // --- ÜRÜN (MENÜ) İŞLEMLERİ ---
        public ActionResult UrunListesi()
        {
            var urunler = db.URUNLER.Include("KATEGORILER").OrderByDescending(x => x.UrunID).ToList();

            return View(urunler);
        }

        [HttpGet]
        public ActionResult UrunEkle()
        {
            // Dropdown listesi için kategorileri çekiyoruz
            List<SelectListItem> degerler = (from i in db.KATEGORILER.ToList()
                                             select new SelectListItem
                                             {
                                                 Text = i.KategoriAd,
                                                 Value = i.KategoriID.ToString()
                                             }).ToList();
            ViewBag.dgr = degerler;
            return View();
        }

        [HttpPost]
public ActionResult UrunEkle(URUNLER u, HttpPostedFileBase ResimDosyasi)
{
    if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
    {
        // 1. Klasör yolunu belirle
        string klasörYolu = Server.MapPath("~/ResimlerMenu/");

        // 2. Klasör fiziksel olarak yoksa OLUŞTUR (Hatanın kökten çözümü burası)
        if (!System.IO.Directory.Exists(klasörYolu))
        {
            System.IO.Directory.CreateDirectory(klasörYolu);
        }

        // 3. Dosya adını ve tam yolu belirle
        string dosyaAdi = Path.GetFileName(ResimDosyasi.FileName);
        string tamYol = Path.Combine(klasörYolu, dosyaAdi);

        // 4. Kaydet
        ResimDosyasi.SaveAs(tamYol);
        
        // Veritabanına kaydedilecek yol
        u.Resim = "/ResimlerMenu/" + dosyaAdi;
    }

    u.Durum = true;
    db.URUNLER.Add(u);
    db.SaveChanges();
    TempData["Basarili"] = "Ürün başarıyla eklendi!";
    return RedirectToAction("UrunListesi");
}

        public ActionResult UrunSil(int id)
        {
            var urun = db.URUNLER.Find(id);
            if (urun != null)
            {
                // Sunucudaki resmi silme işlemi
                if (!string.IsNullOrEmpty(urun.Resim))
                {
                    string tamYol = Server.MapPath(urun.Resim);
                    if (System.IO.File.Exists(tamYol))
                    {
                        System.IO.File.Delete(tamYol);
                    }
                }

                db.URUNLER.Remove(urun);
                db.SaveChanges();
                TempData["Basarili"] = "Ürün başarıyla silindi.";
            }
            return RedirectToAction("UrunListesi");
        }

        [HttpGet]
        public ActionResult UrunGuncelle(int id)
        {
            var urun = db.URUNLER.Find(id);
            if (urun == null) return HttpNotFound();

            // Kategorileri dropdown için çekiyoruz
            List<SelectListItem> kategoriler = (from i in db.KATEGORILER.ToList()
                                                select new SelectListItem
                                                {
                                                    Text = i.KategoriAd,
                                                    Value = i.KategoriID.ToString()
                                                }).ToList();
            ViewBag.dgr = kategoriler;

            return View(urun);
        }

        [HttpPost]
        public ActionResult UrunGuncelle(URUNLER p, HttpPostedFileBase ResimDosyasi)
        {
            var urun = db.URUNLER.Find(p.UrunID);

            if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
            {
                // Eski resmi sunucudan sil
                if (!string.IsNullOrEmpty(urun.Resim))
                {
                    string eskiYol = Server.MapPath(urun.Resim);
                    if (System.IO.File.Exists(eskiYol))
                    {
                        System.IO.File.Delete(eskiYol);
                    }
                }

                // Yeni resmi kaydet
                string dosyaAdi = Path.GetFileName(ResimDosyasi.FileName);
                string yeniYol = "/ResimlerMenu/" + dosyaAdi;
                ResimDosyasi.SaveAs(Server.MapPath("~" + yeniYol));
                urun.Resim = yeniYol;
            }

            // Bilgileri güncelle
            urun.UrunAd = p.UrunAd;
            urun.Fiyat = p.Fiyat;
            urun.Icindekiler = p.Icindekiler;
            urun.KategoriID = p.KategoriID;
            urun.Durum = p.Durum;

            db.SaveChanges();
            TempData["Basarili"] = "Ürün başarıyla güncellendi.";
            return RedirectToAction("UrunListesi");
        }

        // 1. İÇERİKLERİ LİSTELEME
        public ActionResult IcerikYonetimi()
        {
          
            var icerikler = db.ICERIKLER.OrderByDescending(x => x.IcerikID).ToList();
            return View(icerikler);
        }

       
        public ActionResult IcerikEkle()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]

        public ActionResult IcerikEkle(ICERIKLER model, HttpPostedFileBase RESIM, HttpPostedFileBase KAPAK)
        {
           
            if (RESIM != null && RESIM.ContentLength > 0)
            {
                string filename = Guid.NewGuid().ToString() + Path.GetExtension(RESIM.FileName);
                RESIM.SaveAs(Path.Combine(Server.MapPath("~/Dosyalar/"), filename));
                model.Dosya = filename;
            }

            // 2. KAPAK FOTOĞRAFI YÜKLEME (Senin Yeni Eklentin 🚀)
            if (KAPAK != null && KAPAK.ContentLength > 0)
            {
                string filename = "kapak_" + Guid.NewGuid().ToString() + Path.GetExtension(KAPAK.FileName);
                KAPAK.SaveAs(Path.Combine(Server.MapPath("~/Dosyalar/"), filename));
                model.KFotograf = filename; // DB'deki yeni kolona kayıt
            }

            model.Durum = true;
            db.ICERIKLER.Add(model);
            db.SaveChanges();
            TempData["Basarili"] = "İçerik ve Dosya Başarıyla Eklendi.";
            return RedirectToAction("IcerikYonetimi");
          
        }

        //public ActionResult IcerikEkle(ICERIKLER model, HttpPostedFileBase RESIM)
        //{
        //    if (RESIM != null && RESIM.ContentLength > 0)
        //    {
        //        // 1. Hocanın öğrettiği Guid ile benzersiz isim oluşturma yapısı
        //        string extension = Path.GetExtension(RESIM.FileName);
        //        string filename = Guid.NewGuid().ToString() + extension;

        //        // 2. Dosyayı 'Dosyalar' klasörüne kaydetme
        //        var path = Path.Combine(Server.MapPath("~/Dosyalar/"), filename);
        //        RESIM.SaveAs(path);

        //        // 3. Veritabanına sadece dosya adını yazıyoruz (Hocanın yöntemi)
        //        model.Dosya = filename;
        //    }

        //    model.Durum = true;
        //    db.ICERIKLER.Add(model);
        //    db.SaveChanges();

        //    TempData["Basarili"] = "İçerik ve Dosya Başarıyla Eklendi.";
        //    return RedirectToAction("IcerikYonetimi");
        //}
        public ActionResult IcerikDuzenle(int id)
        {
            var bul = db.ICERIKLER.Find(id);
            if (bul == null) return HttpNotFound();
            return View(bul);
        }

        [HttpPost]
        [ValidateInput(false)]

        public ActionResult IcerikGuncelle(ICERIKLER model, HttpPostedFileBase RESIM, HttpPostedFileBase KAPAK)
        {
            var guncel = db.ICERIKLER.Find(model.IcerikID);

            // Döküman Güncelleme
            if (RESIM != null)
            {
                if (!string.IsNullOrEmpty(guncel.Dosya)) System.IO.File.Delete(Request.MapPath("~/Dosyalar/") + guncel.Dosya);
                string filename = Guid.NewGuid().ToString() + Path.GetExtension(RESIM.FileName);
                RESIM.SaveAs(Path.Combine(Server.MapPath("~/Dosyalar/"), filename));
                guncel.Dosya = filename;
            }

            // Kapak Fotoğrafı Güncelleme
            if (KAPAK != null)
            {
                if (!string.IsNullOrEmpty(guncel.KFotograf)) System.IO.File.Delete(Request.MapPath("~/Dosyalar/") + guncel.KFotograf);
                string filename = "kapak_" + Guid.NewGuid().ToString() + Path.GetExtension(KAPAK.FileName);
                KAPAK.SaveAs(Path.Combine(Server.MapPath("~/Dosyalar/"), filename));
                guncel.KFotograf = filename;
            }

            guncel.Baslik = model.Baslik;
            guncel.Tarih = model.Tarih;
            guncel.IcerikMetni = model.IcerikMetni;
            db.SaveChanges();
            TempData["Basarili"] = "Güncelleme Başarılı.";
            return RedirectToAction("IcerikYonetimi");
        }



        //public ActionResult IcerikGuncelle(ICERIKLER model, HttpPostedFileBase RESIM)
        //{
        //    var guncel = db.ICERIKLER.Find(model.IcerikID);

        //    if (RESIM != null && RESIM.ContentLength > 0)
        //    {
        //        // Eski dosyayı klasörden silme (Hocanın öğrettiği temizlik işlemi)
        //        if (!string.IsNullOrEmpty(guncel.Dosya))
        //        {
        //            string eskiYol = Request.MapPath("~/Dosyalar/") + guncel.Dosya;
        //            if (System.IO.File.Exists(eskiYol)) System.IO.File.Delete(eskiYol);
        //        }

        //        // Yeni dosyayı kaydetme
        //        string extension = Path.GetExtension(RESIM.FileName);
        //        string filename = Guid.NewGuid().ToString() + extension;
        //        var path = Path.Combine(Server.MapPath("~/Dosyalar/"), filename);

        //        RESIM.SaveAs(path);
        //        guncel.Dosya = filename;
        //    }

        //    guncel.Baslik = model.Baslik;
        //    guncel.Tarih = model.Tarih;
        //    guncel.IcerikMetni = model.IcerikMetni;
        //    guncel.Durum = model.Durum;

        //    db.SaveChanges();
        //    TempData["Basarili"] = "Güncelleme Başarılı.";
        //    return RedirectToAction("IcerikYonetimi");
        //}

        // 4. İÇERİK SİLME
        public ActionResult IcerikSil(int id)
        {
            var silinecek = db.ICERIKLER.Find(id);

            // Resim dosyasını temizle
            if (!string.IsNullOrEmpty(silinecek.Dosya))
            {
                string yol = Request.MapPath("~/" + silinecek.Dosya);
                if (System.IO.File.Exists(yol)) System.IO.File.Delete(yol);
            }

            db.ICERIKLER.Remove(silinecek);
            db.SaveChanges();
            TempData["Basarili"] = "İçerik tamamen silindi.";
            return RedirectToAction("IcerikYonetimi");
        }
        public ActionResult Masalar()
        {
            var masalar = db.MASALAR.ToList();
            ViewBag.AktifRezervasyonlar = db.REZARVASYONLAR.Where(x => x.DurumID == 2).ToList();
            return View(masalar);
        }
        public ActionResult MasaEkle()
        {
            return View();
        }

        
        [HttpPost]
        public ActionResult MasaEkle(MASALAR yeniMasa)
        {
            if (yeniMasa.MasaNo <= 0 || yeniMasa.Kapasite <= 0)
            {
                TempData["Hata"] = "Masa Numarası ve Kapasite 0'dan büyük olmalıdır.";
                return View();
            }

            // 2. KONTROL: Aynı isimde/numarada başka bir masa var mı? (Veritabanı tutarlılığı)
            var varMi = db.MASALAR.FirstOrDefault(x => x.MasaNo == yeniMasa.MasaNo);
            if (varMi != null)
            {
                TempData["Hata"] = "Bu masa numarası zaten kayıtlı!";
                return View();
            }

            try
            {
                // 3. ATAMA: SQL tablandaki [Durum] sütununu varsayılan olarak 'false' (Boş) yapıyoruz
                yeniMasa.Durum = false;

                db.MASALAR.Add(yeniMasa);
                db.SaveChanges();
                TempData["Basarili"] = "Masa Başarıyla Eklendi";
                return RedirectToAction("Masalar");
            }
            catch (Exception ex)
            {
                ViewBag.Hata = "Bir hata oluştu: " + ex.Message;
                return View();
            }
        }

       
        public ActionResult MasaGuncelle(int id)
        {
            var masa = db.MASALAR.Find(id);
            return View(masa);
        }

     
        [HttpPost]
        public ActionResult MasaGuncelle(MASALAR guncelMasa)
        {
            var eskiMasa = db.MASALAR.Find(guncelMasa.MasaID);
            eskiMasa.MasaNo = guncelMasa.MasaNo;
            eskiMasa.Kapasite = guncelMasa.Kapasite;
            db.SaveChanges();
            return RedirectToAction("Masalar");
        }

      
        public ActionResult MasaSil(int id)
        {
            var masa = db.MASALAR.Find(id);
            // Eğer masa doluysa silinmesini engellemek için bir kontrol eklenebilir
            if (masa.Durum == false)
            {
                db.MASALAR.Remove(masa);
                db.SaveChanges();
                TempData["Basarili"] = "Masa tamamen silindi.";
            }
           
            return RedirectToAction("Masalar");
        }


    }
}
