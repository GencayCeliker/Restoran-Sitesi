using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Restorant_Sitesi.Models
{
    public class AnasayfaSınıf
    {
        // --- LİSTELEMELER (Veritabanından Çoklu Gelen Veriler) ---

        public List<ANASAYFA> SliderBannerlari { get; set; }       // Sayfanın en üstünde dönen büyük resimler ve yazılar
        public List<KATEGORILER> Kategoriler { get; set; }         // Menüdeki başlıklar (Kahvaltı, Öğle Yemeği, Tatlılar vb.)
        public List<URUNLER> OneCikanUrunler { get; set; }         // Vitrinde gösterilecek sınırlandırılmış (örneğin 6 adet) ürün
        public List<SEFLER> Seflerimiz { get; set; }               // Restoranda çalışan usta şeflerin listesi
        public List<DUYURULABLOGLAR> SonBlogYazilari { get; set; } // Veritabanından (DUYURULABLOGLAR tablosu) gelen blog/haber yazıları
        public List<YORUMLAR> MusteriYorumlari { get; set; }       // Müşterilerin yaptığı yorumlar (YORUMLAR tablosu)
        public List<HAKKIMDA> Hakkımda { get; set; }               // Hakkımızda kısmında yazacak olan tanıtım metinleri
        public List<URUNLER> urunler { get; set; }                 // Menü sekmesinde gösterilecek olan TÜM aktif yemek/içecekler


        // --- TEKLİ VERİLER (Sadece tek bir satır/işlem tutanlar) ---

        public USTILETISIM IletisimBilgileri { get; set; }         // Sayfanın en alt ve en üstündeki sabit adres, telefon, e-posta bilgisi
        public REZARVASYONLAR YeniRezervasyon { get; set; }        // Müşterinin formu doldurup bize göndereceği yeni rezervasyon kaydı
    }
}