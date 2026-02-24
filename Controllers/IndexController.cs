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
            
            string[] kelimeler = { "MOLY", "RS", "RESTORANT", "YEMEK", "HİJYEN", "GUVEN", "LEZZET" };
            Random rnd = new Random();
            string secilenKelime = kelimeler[rnd.Next(kelimeler.Length)];

            Session["DogrulamaKodu"] = secilenKelime;
            ViewBag.GosterilenKod = secilenKelime;

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


    }
}