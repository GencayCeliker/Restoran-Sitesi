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
namespace Restorant_Sitesi.Controllers
{
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
        public ActionResult RezervasyonGelmedi(int id)
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
        public ActionResult RezervasyonOnayla(int rezervasyonId, int masaId)
        {
            var rezervasyon = db.REZARVASYONLAR.Find(rezervasyonId);
            var masa = db.MASALAR.Find(masaId);

            if (rezervasyon != null && masa != null)
            {
                rezervasyon.MasaID = masaId;
                rezervasyon.DurumID = 2;
                masa.Durum = true;
                db.SaveChanges();
                string mailIcerik = $"Sayın {rezervasyon.MusteriAdSoyad},<br/>" +
                                    $"{rezervasyon.Tarih.Value.ToString("dd.MM.yyyy")} tarihindeki rezervasyonunuz onaylanmıştır.<br/>" +
                                    $"Masa Numaranız: <b>{masa.MasaNo}</b><br/>" +
                                    $"Sizi ağırlamaktan mutluluk duyarız.<br/>- Moly RS Ekibi";

                MailGonder(rezervasyon.Mail, "Rezervasyon Onayı", mailIcerik);
                TempData["Mesaj"] = "İşlem Başarılı";
            }

            return RedirectToAction("Index");
        }
        public ActionResult RezervasyonIptal(int id)
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
            return RedirectToAction("Index");
        }
        public ActionResult RezervasyonBeklemeyeAl(int id)
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
            return RedirectToAction("Index");
        }
        public ActionResult RezervasyonTamamla(int id)
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
            return RedirectToAction("Index");
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
                if (string.IsNullOrWhiteSpace(gonderenMail) || string.IsNullOrWhiteSpace(sifre))
                {
                    return;
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
            var kategoriler = db.KATEGORILER.ToList();
            return View(kategoriler);
        }

        [HttpGet]
        public ActionResult KategoriEkle() => View();

        [HttpPost]
        public ActionResult KategoriEkle(KATEGORILER k)
        {
            db.KATEGORILER.Add(k);
            db.SaveChanges();
            return RedirectToAction("KategoriListesi");
        }

        public ActionResult KategoriSil(int id)
        {
            var kat = db.KATEGORILER.Find(id);
            db.KATEGORILER.Remove(kat);
            db.SaveChanges();
            return RedirectToAction("KategoriListesi");
        }

        // --- ÜRÜN (MENÜ) İŞLEMLERİ ---
        public ActionResult UrunListesi()
        {
            var urunler = db.URUNLER.Include("KATEGORILER").ToList();
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
            // Resim Yükleme İşlemi
            if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
            {
                string dosyaAdi = Path.GetFileName(ResimDosyasi.FileName);
                string yol = "~/ResimlerMenu/" + dosyaAdi;
                ResimDosyasi.SaveAs(Server.MapPath(yol));
                u.Resim = "/ResimlerMenu/" + dosyaAdi;
            }

            u.Durum = true;
            db.URUNLER.Add(u);
            db.SaveChanges();
            return RedirectToAction("UrunListesi");
        }

    }
}
