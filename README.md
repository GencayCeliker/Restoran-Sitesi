# 🍽️ Moly Restaurant – Restoran Web Sitesi ve Yönetim Paneli

![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![ASP.NET MVC 5](https://img.shields.io/badge/ASP.NET%20MVC-5.3-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.7.2-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Entity Framework](https://img.shields.io/badge/Entity%20Framework-6.5-6C1D5F?style=for-the-badge)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)

**ASP.NET MVC 5** ile geliştirilmiş, müşteri tarafı (restoran sitesi) ve yönetici tarafı (admin paneli) bir arada olan restoran web uygulamasıdır. Menü, rezervasyon, blog/duyuru, yorum ve içerik yönetimi veritabanından dinamik olarak yönetilir.

> Eğitim ve portföy amaçlı geliştirilmiştir; proje aktif olarak geliştirilmeye devam etmektedir.

---

## ✨ Özellikler

### 🌐 Müşteri tarafı (`IndexController`)

| Sayfa | Açıklama |
| --- | --- |
| **Ana Sayfa** | Slider, öne çıkan ürünler, şefler, müşteri yorumları ve rezervasyon formu |
| **Menülerimiz** | Kategorilere ayrılmış ürün listesi (fiyat, görsel, açıklama) |
| **Rezervasyon** | Tarih, saat ve kişi sayısı ile rezervasyon talebi; talep *Beklemede* durumuyla kaydedilir |
| **Bloglar / Duyurular** | Blog listesi, detay sayfası, beğeni (AJAX) ve 1–5 yıldızlı yorum |
| **İçerikler** | Yönetici tarafından eklenen içerikler; kapak görseli ve PDF dosyası görüntüleme/indirme |
| **Hakkımızda** | Veritabanından gelen tanıtım içeriği |
| **İletişim** | Türkiye haritasından il seçerek o ildeki şubeleri listeleme ve güvenlik kodlu mesaj formu |
| **Kayıt Ol / Giriş Yap** | Üyelik ve oturum açma (yetkiye göre panele veya siteye yönlendirme) |

**Yorum güvenliği:** Ana sayfa ve blog yorumlarında rastgele üretilen bir **güvenlik kodu** (captcha) istenir. Yorumlar **yönetici onayından sonra** yayınlanır.

### 🛠️ Yönetim paneli (`AdminController`)

* **Gösterge paneli:** Toplam rezervasyon/ürün, bekleyen yorumlar, son rezervasyonlar ve yorumlar. Tarihi geçmiş onaylı rezervasyonlar otomatik *Tamamlandı* yapılır ve masa boşaltılır.
* **Rezervasyon yönetimi:** Onayla (kişi sayısına uygun boş masa seçerek), iptal, beklemeye al, tamamla, gelmedi. Arama ve tarihe göre filtreleme.
* **📧 E-posta bildirimi:** Rezervasyon onaylandığında, iptal edildiğinde, beklemeye alındığında veya *gelmedi* işaretlendiğinde müşteriye Gmail SMTP üzerinden otomatik e-posta gider.
* **Menü:** Kategori ve ürün ekle / güncelle / sil (görsel yükleme ile)
* **Masalar ve Şefler:** CRUD işlemleri
* **Slider, Hakkımızda, Blog & Duyuru:** Summernote zengin metin editörü ile içerik yönetimi, AJAX ile düzenleme
* **İçerik yönetimi:** Kapak fotoğrafı ve PDF dosyası yükleme (`Dosyalar/` klasörüne kaydedilir)
* **Bildirim kutusu:** Ana sayfa ve blog yorumlarını onaylama, kaldırma, silme

### 🔐 Kimlik doğrulama ve yetkilendirme

* Forms Authentication + Session ile oturum yönetimi
* Giriş, **Ad Soyad + Şifre** ile yapılır
* `/Admin` altındaki tüm sayfalar yalnızca **`Yetki = Admin`** olan kullanıcılara açıktır. Giriş yapmamış ya da *Uye* yetkili kullanıcılar giriş sayfasına yönlendirilir.
* Giriş formunda Anti-Forgery Token kullanılır

---

## 🛠️ Kullanılan Teknolojiler

| Katman | Teknoloji |
| --- | --- |
| Backend | C#, ASP.NET MVC 5.3, .NET Framework 4.7.2 |
| Veri erişimi | Entity Framework 6.5 – Database First (`Models/Model1.edmx`) |
| Veritabanı | Microsoft SQL Server – `WRestourantDB` (19 tablo) |
| Frontend | Razor, HTML5, CSS3, Bootstrap 5.3, jQuery 3.7, AJAX |
| Kütüphaneler | Summernote (WYSIWYG), toastr (bildirimler), Font Awesome, System.Net.Mail (SMTP) |

### 🗄️ Veritabanı tabloları

`ANASAYFA` (slider) · `URUNLER` · `KATEGORILER` · `MASALAR` · `REZARVASYONLAR` · `REZARVASYONDURUM` · `SEFLER` · `YORUMLAR` · `DUYURULABLOGLAR` · `DUYURUBLOGYORUMLARI` · `ICERIKLER` · `HAKKIMDA` · `NAVBAR` · `USTILETISIM` · `SITE_AYARLARI` · `SUBELER` · `MESAJLAR` · `UYELER` · `SIFRE_SIFIRLAMA`

---

## 🗂️ Proje Yapısı

```
Restoran-Sitesi/
├── Restorant-Sitesi.slnx         ← Visual Studio çözüm dosyası
├── Restorant-Sitesi.csproj
├── Controllers/
│   ├── IndexController.cs        ← Müşteri sayfaları, rezervasyon, yorum, giriş/kayıt
│   └── AdminController.cs        ← Yönetim paneli, rezervasyon onayı, e-posta
├── Models/                       ← Entity Framework modeli (Model1.edmx) ve tablo sınıfları
├── Views/
│   ├── Index/                    ← Müşteri tarafı sayfaları
│   ├── Admin/                    ← Yönetim paneli sayfaları
│   └── Shared/                   ← RestourantLayout (site) ve AdminLayout (panel)
├── Veri Tabanı/DB.sql            ← Veritabanı kurulum script'i
├── Dosyalar/                     ← Yüklenen PDF ve kapak görselleri
├── images/, ResimlerMenu/        ← Site ve ürün görselleri
├── tasteit-master/               ← Site teması (Colorlib – Tasteit)
├── AdminTemplate/                ← Panel teması (Codervent – Dashtreme)
├── Web.config                    ← Bağlantı cümlesi ve ayarlar
└── SecretSettings.config         ← SMTP bilgileri (git'e eklenmez, kendiniz oluşturursunuz)
```

---

## ⚙️ Kurulum ve Çalıştırma

### Gereksinimler

* **Visual Studio 2026** veya **Visual Studio 2022 (17.14+)** – *ASP.NET ve web geliştirme* iş yükü ile
  > `.slnx` çözüm biçimini eski Visual Studio 2022 sürümleri açamaz. Bu durumda doğrudan `Restorant-Sitesi.csproj` dosyasını açın.
* **SQL Server** 2019 veya üzeri (Express yeterli)
* **SQL Server Management Studio (SSMS) 22**

### 1. Projeyi indirin

```bash
git clone https://github.com/GencayCeliker/Restoran-Sitesi.git
```

### 2. Veritabanını oluşturun (SSMS 22)

1. SSMS 22'yi açın ve sunucunuza bağlanın (Server name: `.\SQLEXPRESS`, Authentication: *Windows Authentication*).
2. **File → Open → File...** ile `Veri Tabanı/DB.sql` dosyasını açın.
3. **Execute (F5)**'e basın.

Script şunları yapar:

* `WRestourantDB` veritabanını oluşturur
* 19 tabloyu, birincil/yabancı anahtarları ve varsayılan değerleri kurar
* Menü, kategori, masa, şef, slider, blog, şube gibi örnek verileri ekler
* İki demo hesap ekler:

| Rol | Ad Soyad | Şifre |
| --- | --- | --- |
| Yönetici | `Admin` | `Admin123!` |
| Üye | `Demo Uye` | `Uye123!` |

> `WRestourantDB` zaten varsa script hiçbir şey yapmadan durur. Yeniden kurmak için önce mevcut veritabanını silin (Object Explorer → veritabanına sağ tık → *Delete*).

### 3. Bağlantı cümlesini kontrol edin

`Web.config` içindeki varsayılan sunucu **`.\SQLEXPRESS`**'tir:

```xml
<add name="WRestourantDBEntities"
     connectionString="metadata=res://*/Models.Model1.csdl|res://*/Models.Model1.ssdl|res://*/Models.Model1.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=.\SQLEXPRESS;initial catalog=WRestourantDB;integrated security=True;trustservercertificate=True;MultipleActiveResultSets=True;App=EntityFramework&quot;"
     providerName="System.Data.EntityClient" />
```

SQL Server varsayılan örnek olarak kuruluysa `data source=.\SQLEXPRESS` yerine `data source=.` yazın.

### 4. E-posta ayarı – `SecretSettings.config`

`Web.config`, SMTP bilgilerini proje kök klasöründeki **`SecretSettings.config`** dosyasından okur. Bu dosya `.gitignore` ile hariç tutulduğu için depoda yoktur; aşağıdaki içerikle kendiniz oluşturun:

```xml
<appSettings>
  <add key="EmailAdresi" value="ornek@gmail.com" />
  <add key="UygulamaSifresi" value="gmail-uygulama-sifresi" />
</appSettings>
```

* `UygulamaSifresi` normal Gmail şifreniz değil, **Google Hesabı → Güvenlik → 2 Adımlı Doğrulama → Uygulama şifreleri** bölümünden alınan 16 haneli şifredir.
* Dosya olmadan site çalışır; yalnızca rezervasyon durum e-postaları gönderilemez.

### 5. Visual Studio ile çalıştırın

1. `Restorant-Sitesi.slnx` dosyasını açın.
2. NuGet paketleri ilk derlemede otomatik geri yüklenir. Yüklenmezse: **Solution Explorer → sağ tık → Restore NuGet Packages**.
3. **F5** ile IIS Express üzerinde başlatın.
4. Yönetim paneli için **Giriş Yap** sayfasından `Admin` / `Admin123!` ile giriş yapın; otomatik olarak `/Admin` sayfasına yönlendirilirsiniz.

---

## ❓ Sık Karşılaşılan Sorunlar

| Sorun | Çözüm |
| --- | --- |
| *Cannot open database "WRestourantDB"* | `DB.sql` script'ini çalıştırdığınızdan ve `Web.config` içindeki `data source` değerinin doğru olduğundan emin olun. |
| *Could not find a part of the path ...\bin\roslyn\csc.exe* | **Restore NuGet Packages** ve ardından **Rebuild Solution** yapın. |
| *Mail Gönderim Hatası* | `SecretSettings.config` dosyasını ve Gmail uygulama şifresini kontrol edin. |
| `.slnx` açılmıyor | Visual Studio'yu güncelleyin veya `Restorant-Sitesi.csproj` dosyasını açın. |

---

## 🔒 Güvenlik Notları

* SMTP bilgileri `SecretSettings.config` içinde tutulur ve `.gitignore` ile depoya eklenmez.
* Yönetim paneli rol kontrolü ile korunur.
* Şifreler veritabanında **düz metin** olarak saklanmaktadır. Proje eğitim amaçlıdır; gerçek kullanımda şifreler hash'lenmelidir (ör. PBKDF2 / BCrypt).

---

## 🙏 Teşekkürler (Credits)

* [Colorlib](https://colorlib.com/) – *Tasteit* site teması
* [Codervent](https://codervent.com/) – *Dashtreme* admin teması
* [ThemeWagon](https://themewagon.com/) – UI şablon kaynakları

---

## 📌 Not

Bu proje, ASP.NET MVC ile full-stack web geliştirme öğrenme sürecinin bir parçası olarak geliştirilmiştir.

## 📄 Lisans

Bu proje [MIT](LICENSE) lisansı altında sunulmuştur.
