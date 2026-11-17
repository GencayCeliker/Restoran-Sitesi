using Restorant_Sitesi.Models;
using System;
using System.Globalization;
using System.Web.Mvc;

namespace Restorant_Sitesi.Controllers
{
    /// <summary>
    /// Müşteri tarafındaki rezervasyon işlemleri: rezervasyon sayfası ve rezervasyon talebinin kaydı.
    /// (Daha önce IndexController içinde Rezerve / RezarvasyonYap olarak yer alıyordu.)
    /// </summary>
    public class RezervasyonController : Controller
    {
        private readonly WRestourantDBEntities db = new WRestourantDBEntities();

        // GET: /Rezervasyon
        public ActionResult Index()
        {
            return View();
        }

        // POST: /Rezervasyon/Yap
        [HttpPost]
        public ActionResult Yap(REZARVASYONLAR p, string Tarih, string Saat)
        {
            if (!string.IsNullOrEmpty(Tarih))
            {
                string[] formatlar = { "dd/MM/yyyy", "dd.MM.yyyy", "yyyy-MM-dd" };
                if (DateTime.TryParseExact(Tarih, formatlar, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime tempTarih))
                {
                    p.Tarih = tempTarih;
                }
            }

            if (!string.IsNullOrEmpty(Saat) && TimeSpan.TryParse(Saat, out TimeSpan tempSaat))
            {
                p.Saat = tempSaat;
            }

            p.DurumID = 1; // Beklemede
            db.REZARVASYONLAR.Add(p);
            db.SaveChanges();

            TempData["Mesaj"] = "Rezervasyon talebiniz alındı, onaylanınca size dönüş yapılacaktır.";
            return RedirectToAction("Index", "Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
