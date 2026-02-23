🍽️ Moly RS - Restoran Otomasyon Sistemi
Moly RS, restoranlar için geliştirilmiş, rezervasyon yönetimi ve yönetim paneli desteği sunan profesyonel bir web otomasyon sistemidir. 

🚀 Proje Hakkında
Bu proje, bir restoranın dijital dünyadaki yüzü olmakla birlikte; arka planda rezervasyon takibi, menü yönetimi ve müşteri iletişimini kolaylaştırmak amacıyla tasarlanmıştır ve Okul Projesidir. 

Temel Özellikler

Dinamik Rezervasyon Sistemi: Müşterilerin web üzerinden masa ayırtabilmesi. 


Gelişmiş Admin Paneli: Restoran verilerinin, rezervasyonların ve içeriklerin tek bir merkezden yönetilmesi. 

E-Posta Bildirimleri: Rezervasyon onayları ve iletişim formları için otomatik Gmail SMTP entegrasyonu.

Responsive Tasarım: Tüm cihazlarla (PC, Tablet, Mobil) uyumlu kullanıcı arayüzü.

🛠️ Kullanılan Teknolojiler

Backend: ASP.NET MVC (.NET Framework 4.7.2) 

Frontend: HTML5, CSS3, JavaScript, Bootstrap (Modern Templateler)


Veritabanı: MSSQL Server & Entity Framework (Database First) 

Güvenlik: Hassas veriler için dış yapılandırma (SecretSettings.config) mimarisi.

⚙️ Kurulum ve Çalıştırma
Projeyi kendi yerel ortamınızda çalıştırmak için:

Bu repoyu bilgisayarınıza indirin veya klonlayın.

SQL Server üzerinde WRestourantDB veritabanını oluşturun ve Models klasöründeki .edmx yapısına göre tabloları güncelleyin. 

Proje ana dizininde SecretSettings.config dosyası oluşturun:

XML
<appSettings>
  <add key="EmailAdresi" value="mail-adresiniz@gmail.com" />
  <add key="UygulamaSifresi" value="16-haneli-uygulama-sifreniz" />
</appSettings>
Visual Studio ile Restorant-Sitesi.sln dosyasını açın ve projeyi derleyin. 

🔒 Güvenlik Notu
Bu projede güvenlik gereği API anahtarları ve e-posta şifreleri doğrudan kod içerisine yazılmamıştır. Tüm hassas yapılandırmalar .gitignore ile korunmaktadır.