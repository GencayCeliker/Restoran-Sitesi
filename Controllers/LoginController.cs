using Restorant_Sitesi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Restorant_Sitesi.Controllers
{
    public class LoginController : Controller
    {
       WRestourantDBEntities db = new WRestourantDBEntities ();
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index(string Mail, string Sifre)
        {
    
            var kullanici = db.UYELER.FirstOrDefault(x => x.Mail == Mail && x.Sifre == Sifre && x.Durum == true);

            if (kullanici != null)
            {
                Session["KullaniciID"] = kullanici.UyeID;
                Session["AdSoyad"] = kullanici.AdSoyad;
                Session["Yetki"] = kullanici.Yetki; // "Admin" veya "Uye" gelecek

                // YETKİ KONTROLÜ VE YÖNLENDİRME
                if (kullanici.Yetki == "Admin")
                {
                    // Eğer Admin ise Yönetim Paneline yolla
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    // Eğer normal Üye ise Restoran Ana Sayfasına yolla
                    return RedirectToAction("Index", "Index");
                }
            }
            else
            {
                // Kişi bulunamadıysa veya şifre yanlışsa aynı sayfada hata ver
                ViewBag.Hata = "E-posta veya şifre hatalı!";
                return View();
            }
        }

        // ÇIKIŞ YAPMA METODU (Bunu da hazır ekleyelim)
        public ActionResult CikisYap()
        {
            Session.Clear(); // Tüm oturum bilgilerini sil
            return RedirectToAction("Index", "Index"); // Ana sayfaya postala
        }
        [HttpPost]
        public ActionResult KayitOl(UYELER uye, bool SozlesmeOnay = false)
        {
            // KVKK / Sözleşme onayı yapılmamışsa geri gönder
            if (!SozlesmeOnay)
            {
                ViewBag.Hata = "Kayıt olmak için sözleşmeyi kabul etmelisiniz!";
                return View("Index");
            }

            // Bu mail adresi daha önce kullanılmış mı kontrolü
            var mailVarMi = db.UYELER.FirstOrDefault(x => x.Mail == uye.Mail);
            if (mailVarMi != null)
            {
                ViewBag.Hata = "Bu e-posta adresi zaten kullanılıyor!";
                return View("Index");
            }

            // Her şey yolundaysa yeni üyeyi kaydet
            uye.Yetki = "Uye"; // Dışarıdan kayıt olan herkes standart üyedir
            uye.Durum = true;
            uye.SozlesmeOnay = true;
            uye.KayitTarihi = DateTime.Now;

            db.UYELER.Add(uye);
            db.SaveChanges();

            ViewBag.Basari = "Kayıt işlemi başarılı! Şimdi giriş yapabilirsiniz.";
            return View("Index");
        }

    }
}