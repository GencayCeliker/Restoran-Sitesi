# 🍽️ Restoran Yönetim Sistemi

## ASP.NET MVC Web Uygulaması

Rezervasyon, menü yönetimi, müşteri geri bildirimleri ve yönetim
işlemlerini web tabanlı bir panel üzerinden yöneten tam kapsamlı bir
restoran otomasyon sistemidir.

------------------------------------------------------------------------

## 📌 Proje Hakkında

Bu proje, ASP.NET MVC 5 (.NET Framework) kullanılarak geliştirilmiş web
tabanlı bir restoran yönetim sistemidir.\
Müşteri ve yönetici tarafını birlikte içeren, gerçek dünya senaryolarına
uygun bir yapı sunar.

Sistem; kimlik doğrulama, e-posta gönderimi, asenkron işlemler ve içerik
yönetimi gibi modern web geliştirme özelliklerini içermektedir.

------------------------------------------------------------------------

## ✨ Temel Özellikler

### 📅 Rezervasyon Sistemi

-   Müşteriler dinamik form üzerinden rezervasyon oluşturabilir\
-   Tarih ve uygunluk kontrolü ile çalışma\
-   Rezervasyon talepleri sistem üzerinden işlenir

### 📧 E-posta Bildirim Sistemi

-   SMTP entegrasyonu ile otomatik e-posta gönderimi\
-   Rezervasyon ve iletişim formlarında bildirim sistemi\
-   AJAX ile asenkron çalışarak sayfa deneyimini etkilemez

### 🔐 Kimlik Doğrulama ve Yetkilendirme

-   Session tabanlı oturum yönetimi\
-   Yönetim paneli güvenliği\
-   Giriş yapmamış kullanıcıların yönlendirilmesi

### 💬 Yorum Sistemi

-   Yorum yapabilmek için kayıt ve giriş zorunluluğu\
-   Spam ve bot saldırılarına karşı koruma\
-   Yorumlar yönetici onayından sonra yayınlanır

### 📝 İçerik Yönetim Sistemi

-   Summernote editörü ile zengin metin düzenleme\
-   Menü ve duyuruların dinamik olarak yönetilmesi\
-   Görsel ve formatlı içerik desteği

### 📄 PDF ve Doküman Desteği

-   Menü ve dokümanların PDF olarak yüklenmesi\
-   Kullanıcıların doğrudan görüntüleyebilmesi veya indirebilmesi

------------------------------------------------------------------------

## 🛠️ Kullanılan Teknolojiler

### Backend

-   C#\
-   ASP.NET MVC 5 (.NET Framework 4.7.2)\
-   Entity Framework (Database First)

### Frontend

-   HTML5, CSS3, Bootstrap 5\
-   JavaScript (AJAX, jQuery)

### Veritabanı

-   Microsoft SQL Server\
-   T-SQL\
-   İlişkisel veritabanı yapısı

### Kütüphaneler ve Araçlar

-   Summernote (WYSIWYG Editör)\
-   SMTP Mail Servisi\
-   Şifreleme ve güvenlik yardımcı araçları

------------------------------------------------------------------------

## 🗂️ Proje Yapısı

Controllers/ → İş mantığı, yetkilendirme, e-posta işlemleri\
Models/ → Entity Framework veri modelleri\
Views/ → Razor tabanlı kullanıcı arayüzü\
Scripts/ → JavaScript ve AJAX işlemleri\
ContentFiles/ → Görseller, PDF ve medya dosyaları

------------------------------------------------------------------------

## ⚙️ Kurulum ve Çalıştırma

### 1. Veritabanı Kurulumu

-   SQL Server Management Studio (SSMS) açılır\
-   DB.sql dosyası çalıştırılır\
-   Gerekli tablolar otomatik oluşturulur

### 2. Konfigürasyon Ayarı

SecretSettings.config dosyası oluşturulur:

``` xml
<appSettings>
  <add key="EmailAddress" value="ornek@gmail.com" />
  <add key="AppPassword" value="gmail-uygulama-sifresi" />
</appSettings>
```

### 3. Projeyi Çalıştırma

-   Visual Studio ile .sln dosyası açılır\
-   NuGet paketleri yüklenir\
-   Proje build edilip çalıştırılır

------------------------------------------------------------------------

## ⚠️ Önemli Not

E-posta sisteminin çalışabilmesi için Gmail "Uygulama Şifresi"
özelliğinin aktif olması gerekir.

------------------------------------------------------------------------

## 🔒 Güvenlik Yapısı

-   Hassas bilgiler config dosyasında tutulur\
-   .gitignore ile gizli veriler korunur\
-   Session tabanlı yetkilendirme kullanılır

------------------------------------------------------------------------

## 👨‍💻 Geliştirici Hakkında

Bu proje, ASP.NET MVC ile full-stack web geliştirme öğrenme sürecinin
bir parçası olarak geliştirilmiştir.\
Gerçek dünya senaryolarına uygun bir sistem kurmayı, backend mimarisini
ve servis entegrasyonlarını öğrenme amacı taşır.

------------------------------------------------------------------------

## 📷 Ekran Görüntüleri / Demo

(Buraya ekran görüntüsü veya demo video eklenecektir!)

------------------------------------------------------------------------

## 🙏 Teşekkürler (Credits)

-   colorlib (Testeit) -- UI tasarım katkıları\
-   Codervent (Dashtreme) -- Admin template\
-   ThemeWagon -- UI şablon kaynakları

------------------------------------------------------------------------

## 📌 Not

Bu proje eğitim ve portföy amaçlı geliştirilmiştir ve gerçek dünya web
uygulama mimarisini temel almaktadır.
