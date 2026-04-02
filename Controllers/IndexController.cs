using Restorant_Sitesi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization; 

namespace Restorant_Sitesi.Controllers
{
    public class IndexController : Controller
    {
        WRestourantDBEntities db = new WRestourantDBEntities();


        public ActionResult Index()
        {
            GuvenlikKoduUret();
            AnasayfaSınıf model = new AnasayfaSınıf();

            model.SliderBannerlari = db.ANASAYFA.Where(x => x.Durum == true).ToList();
            model.Kategoriler = db.KATEGORILER.ToList();

            model.OneCikanUrunler = db.URUNLER.Where(x => x.Durum == true).Take(6).ToList();


            model.urunler = db.URUNLER.Where(x => x.Durum == true).ToList();

            model.Seflerimiz = db.SEFLER.Where(x => x.Durum == true).ToList();

            model.SonBlogYazilari = db.DUYURULABLOGLAR.OrderByDescending(x => x.Tarih).ToList();
            model.MusteriYorumlari = db.YORUMLAR.Where(x => x.Durum == true).ToList();
            model.Hakkımda = db.HAKKIMDA.ToList();

            model.IletisimBilgileri = db.USTILETISIM.FirstOrDefault();

            return View(model);
        }
        private void GuvenlikKoduUret()
        {
            string[] kelimeler = { "MOLY", "RS", "RESTORANT", "YEMEK", "YENİ", "GUVEN", "LEZZET" };
            Random rnd = new Random();
            string secilenKelime = kelimeler[rnd.Next(kelimeler.Length)];

            Session["DogrulamaKodu"] = secilenKelime;
            ViewBag.GosterilenKod = secilenKelime;
        }

        [HttpPost]
        public ActionResult RezarvasyonYap(REZARVASYONLAR p, string Tarih, string Saat)
        {
            if (!string.IsNullOrEmpty(Tarih))
            {
                DateTime tempTarih;
                string[] formatlar = { "dd/MM/yyyy", "dd.MM.yyyy", "yyyy-MM-dd" };
                if (DateTime.TryParseExact(Tarih, formatlar, CultureInfo.InvariantCulture, DateTimeStyles.None, out tempTarih))
                {
                    p.Tarih = tempTarih;
                }
            }

            if (!string.IsNullOrEmpty(Saat))
            {
                TimeSpan tempSaat;
                if (TimeSpan.TryParse(Saat, out tempSaat))
                {
                    p.Saat = tempSaat;
                }
            }

            p.DurumID = 1;
            db.REZARVASYONLAR.Add(p);
            db.SaveChanges();

            TempData["Mesaj"] = "Rezervasyon talebiniz alındı, onaylanınca size dönüş yapılacaktır.";
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult YorumYap(string AdSoyad, string Mail, string YorumIcerik, string KullaniciKodu)
        {

            string dogruKod = Session["DogrulamaKodu"] as string;


            if (string.IsNullOrEmpty(KullaniciKodu) || string.IsNullOrEmpty(dogruKod) || KullaniciKodu.ToUpper() != dogruKod)
            {
                TempData["Hata"] = "Güvenlik kodu hatalı! Lütfen tekrar deneyiniz.";
                return RedirectToAction("Index");
            }


            if (!string.IsNullOrEmpty(AdSoyad) && !string.IsNullOrEmpty(YorumIcerik))
            {
                YORUMLAR y = new YORUMLAR();
                y.MusteriAdSoyad = AdSoyad;
                y.Mail = Mail;

                y.YorumMetni = YorumIcerik;
                y.Tarih = DateTime.Now;
                y.Durum = false;

                db.YORUMLAR.Add(y);
                db.SaveChanges();

                TempData["Mesaj"] = "Yorumunuz gönderildi. Yönetici onayından sonra yayınlanacaktır.";
            }

            return RedirectToAction("Index");
        }
        public PartialViewResult UstIletisimPartial()
        {
            WRestourantDBEntities db = new WRestourantDBEntities();
            var veriler = db.USTILETISIM.FirstOrDefault(x => x.UstID == 1);

            return PartialView(veriler);
        }
        public ActionResult DUYURULABLOGLARDETAY(int id)
        {
            var deger = db.DUYURULABLOGLAR.Find(id);

            if (deger == null)
                return HttpNotFound();

            deger.Goruntulenme = (deger.Goruntulenme ?? 0) + 1;
            db.SaveChanges();


            var guncelVeri = db.DUYURULABLOGLAR.Find(id);

            ViewBag.BlogYorumlari = db.DUYURUBLOGYORUMLARI
                .Where(x => x.DuyuruID == id && x.Durum == true)
                .ToList();

            GuvenlikKoduUret();

            ViewBag.PopulerYazilar = db.DUYURULABLOGLAR
                .Where(x => x.DuyuruID != id && x.Durum == true)
                .OrderBy(x => Guid.NewGuid())
                .Take(3)
                .ToList();

            return View(guncelVeri); 
        }
        [HttpPost]
        public ActionResult YorumKaydet(DUYURUBLOGYORUMLARI y, string GirilenDogrulamaKodu)
        {
            // 1. GÜVENLİK KONTROLÜ
            if (Session["DogrulamaKodu"] == null || GirilenDogrulamaKodu != Session["DogrulamaKodu"].ToString())
            {
                TempData["Hata"] = "Güvenlik kodunu yanlış girdiniz, lütfen tekrar deneyin.";
                return RedirectToAction("DUYURULABLOGLARDETAY", new { id = y.DuyuruID });
            }

            // 2. KOD DOĞRUYSA KAYDETME İŞLEMİ
            DUYURUBLOGYORUMLARI yeni = new DUYURUBLOGYORUMLARI();
            yeni.MusteriAdSoyad = y.MusteriAdSoyad;
            yeni.Mail = y.Mail;
            yeni.YorumMetni = y.YorumMetni;
            yeni.DuyuruID = y.DuyuruID;
            yeni.Yildiz = y.Yildiz;
            yeni.Durum = false;
            yeni.Tarih = DateTime.Now;

            db.DUYURUBLOGYORUMLARI.Add(yeni);
            db.SaveChanges();

            TempData["Mesaj"] = "Yorumunuz başarıyla gönderildi.Yönetici onayından sonra yayınlanacaktır.";
            return RedirectToAction("DUYURULABLOGLARDETAY", new { id = y.DuyuruID });
        }
        [HttpPost]
        public JsonResult BegeniArttir(int id)
        {
            string cookieName = "blog_like_" + id;


            if (Request.Cookies[cookieName] != null)
            {
                return Json(new { success = false, message = "Zaten beğendiniz." });
            }

            var blog = db.DUYURULABLOGLAR.Find(id);

            if (blog == null)
                return Json(new { success = false });

            blog.Begeni = (blog.Begeni ?? 0) + 1;
            db.SaveChanges();

            HttpCookie cookie = new HttpCookie(cookieName);
            cookie.Expires = DateTime.Now.AddDays(1);
            Response.Cookies.Add(cookie);

            return Json(new { success = true, begeni = blog.Begeni });
        }
        public ActionResult Bloglar()
        {

            var tumBloglar = db.DUYURULABLOGLAR
                               .Where(x => x.Durum == true)
                               .OrderByDescending(x => x.Tarih)
                               .ToList();

            return View(tumBloglar);
        }

        public ActionResult Hakkimizda()
        {
            var hakkimizda = db.HAKKIMDA.Where(x => x.HakkimdaID != 1).ToList();
            ViewBag.hyrm = db.DUYURUBLOGYORUMLARI.Where(x => x.Durum == true).OrderByDescending(x => x.YorumID).Take(5).ToList();
            return View(hakkimizda);
        }

        public ActionResult Menulerimiz()
        {
            var menuler = db.URUNLER.Where(x => x.Durum == true).ToList();
            return View(menuler);
        }
        public ActionResult IcerikListele()
        {
            var icerik = db.ICERIKLER.Where(x => x.Durum == true).ToList();
            return PartialView(icerik);
        }

        public ActionResult IcerikGoster(int id)
        {
            var icerikbbul = db.ICERIKLER.Find(id);
            return PartialView(icerikbbul);
        }
    }
}