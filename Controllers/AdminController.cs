using Restorant_Sitesi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
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
            var liste = db.ANASAYFA.ToList();
            return View(liste);
        }

        [HttpPost]
        public ActionResult SliderKaydet(ANASAYFA veri, HttpPostedFileBase ResimDosyasi, string EskiResimYolu)
        {
            if (ResimDosyasi != null && ResimDosyasi.ContentLength > 0)
            {
                string dosyaAdi = Path.GetFileName(ResimDosyasi.FileName);
                string yol = Path.Combine(Server.MapPath("~/images/"), dosyaAdi);
                ResimDosyasi.SaveAs(yol);
                veri.Resim = "/images/" + dosyaAdi;
            }
            else
            {
                veri.Resim = EskiResimYolu;
            }
            if (veri.AnasayfaID == 0)
                db.ANASAYFA.Add(veri);
            else
                db.Entry(veri).State = System.Data.Entity.EntityState.Modified; 
            db.SaveChanges();
            return RedirectToAction("SliderYonetimi");
        }
        public ActionResult SliderSil(int id)
        {
            var veri = db.ANASAYFA.Find(id);
            if (veri != null)
            {
                db.ANASAYFA.Remove(veri);
                db.SaveChanges();
            }
            return RedirectToAction("SliderYonetimi");
        }
    }
}
