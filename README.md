# 🍽️ Restoran Web Sitesi ve Yönetim Panali (ASP.NET MVC)

**Moly RS**, standart bir restoran tanıtım sitesinin çok ötesinde; asenkron veri işleme, otomatik bildirim altyapısı, çok katmanlı güvenlik protokolleri ve gelişmiş içerik yönetimi ile donatılmış profesyonel bir web otomasyon platformudur. 

Bu proje, bir işletmenin müşteri taleplerini karşılarken arka planda süreçleri nasıl otomatize edebileceğini ve güvenliği nasıl sağlayabileceğini gösteren kapsamlı bir mühendislik çalışmasıdır.

---

## 🚀 Temel Sistem Modülleri ve Özellikler

Projeyi bilgisayarına kuracak veya inceleyecek kullanıcıların karşılaşacağı temel sistem mimarileri şunlardır:

### 1. 📧 Akıllı Rezervasyon ve Otomatik Bildirim Ağı
Sistemin en kritik modüllerinden biri, insan müdahalesini en aza indiren rezervasyon ve iletişim otomasyonudur:
*   **Dinamik Talep Oluşturma:** Müşteriler, uygun tarih ve saatleri seçerek anlık rezervasyon talebi oluşturabilir.
*   **Gmail SMTP Entegrasyonu:** Bir rezervasyon veya iletişim formu doldurulduğunda, sistem arka planda otomatik olarak tetiklenir. **Yöneticiye ve (gerekirse) müşteriye anlık olarak onay/bilgilendirme e-postaları gönderilir.**
*   **Asenkron İşleyiş:** AJAX altyapısı sayesinde e-posta gönderim işlemleri sayfa yüklenmesini bekletmeden, akıcı bir şekilde arka planda tamamlanır.

### 2. 🔐 Üst Düzey Güvenlik ve Yetkilendirme Katmanı
Sistem, yetkisiz erişimlere ve veri ihlallerine karşı korunmaktadır:
*   **Session (Oturum) Mimarisi:** Yönetim paneli tamamen `Session` bazlı yetkilendirme ile korunur. Oturum açmamış bir kullanıcının URL manipülasyonu ile panele erişimi engellenmiş olup, anında güvenli Login sayfasına yönlendirilir (Redirect).
*   **Gizli Yapılandırmalar (SecretSettings):** Projede kullanılan SMTP şifreleri, API anahtarları veya veritabanı bağlantı dizesi gibi kritik veriler kod içine gömülmemiştir. Bu veriler dışarıdan `SecretSettings.config` ile çekilir ve `.gitignore` ile GitHub üzerinde korunur.

### 3. 📝 Çok Aşamalı Kullanıcı Etkileşimi ve Spam Koruması
*   **Kayıt Zorunlu Yorum Sistemi:** Ana sayfadaki "Müşteri Deneyimleri" alanına yorum yapabilmek için ziyaretçilerin sisteme kayıt olması ve oturum açması zorunludur. Bu, bot ve spam saldırılarını engeller.
*   **Admin Onay Süzgeci:** Kullanıcıların yaptığı yorumlar anında yayına alınmaz. Veritabanına "Pasif/Onay Bekliyor" statüsü ile düşer ve sadece yönetici tarafından incelenip onaylandıktan sonra sitede görünür hale gelir.

### 4. 🗂️ Zengin İçerik ve Döküman Yönetimi
*   **Summernote (WYSIWYG) Editör Entegrasyonu:** Yönetim panelinde ürün eklerken veya duyuru yayınlarken düz metin yerine **Summernote** editörü kullanılmıştır. Yönetici; metinleri renklendirebilir, tablo ekleyebilir veya görsel yerleştirebilir.
*   **PDF Döküman Desteği:** Restorana ait resmi belgeler veya detaylı PDF menüler sisteme yüklenebilir ve son kullanıcı tarafından web arayüzünde indirmeye gerek kalmadan doğrudan görüntülenebilir.

---

## 🛠️ Kullanılan Teknolojiler ve Mimari

Proje, güncel yazılım geliştirme standartlarına uygun olarak tasarlanmıştır:

| Alan | Teknolojiler ve Yaklaşımlar |
| :--- | :--- |
| **Backend** | C#, ASP.NET MVC 5 (.NET Framework 4.7.2), Katmanlı Mimari |
| **Veritabanı** | MSSQL Server, Entity Framework (Database First), T-SQL Normalizasyonu |
| **Frontend** | JavaScript (AJAX, jQuery), Bootstrap 5, HTML5, SCSS |
| **Araçlar & Kütüphaneler**| Summernote Editör, SMTP Client, Password Hashing Modülleri |

---

## 📂 Proje Dizin Yapısı (Sistemin İşleyişi)
*   `Controllers/`: Session kontrollerinin, yetkilendirmelerin ve e-posta gönderim algoritmalarının bulunduğu iş mantığı katmanı.
*   `Models/`: Entity Framework `.edmx` yapısı ve veritabanı ilişkileri.
*   `Views/`: Razor motoru ile güçlendirilmiş dinamik arayüzler.
*   `Scripts/`: Asenkron işlemler (AJAX) ve editör konfigürasyonlarını içeren JavaScript dosyaları.
*   `Dosyalar/`: PDF, görsel ve zengin medya içeriklerinin depolandığı alan.

---

## 🙏 Teşekkürler (Credits)
Projenin görsel tasarımında ve yönetim paneli hiyerarşisinde yol gösterici olan açık kaynak şablonlar:
*   **colorlib (Testeit):** Kullanıcı arayüzü, proje mimarisi ve bazı fonksiyonel modüllerdeki değerli paylaşımları için.
*   **Codervent (Dashtreme):** Projenin yönetim paneli kısmında kullanılan AdminTemplate için sağladığı profesyonel ve ücretsiz şablon desteğinden dolayı. 
* **ThemeWagon:**  Bu değerli şablonların ücretsiz olarak erişimine olanak sağladığı için.
---

## ⚙️ Kurulum ve Test Rehberi
Projeyi yerel ortamınızda tam kapasiteyle test etmek için:

1.  **Veritabanı Kurulumu:** WRestourantDB veritabanını MSSQL üzerinde oluşturun ve `Models` klasörüne göre güncelleyin.
2.  **Güvenlik Dosyası:** Proje kök dizininde `SecretSettings.config` isimli bir dosya oluşturup e-posta otomasyonu için gerekli bilgileri girin:
    ```xml
    <appSettings>
      <add key="EmailAdresi" value="otomatik-mail-gonderecek-adres@gmail.com" />
      <add key="UygulamaSifresi" value="gmail-16-haneli-uygulama-sifresi" />
    </appSettings>
    ```
3.  **Çalıştırma:** Çözüm dosyasını (`.sln`) Visual Studio ile açarak derleyin (Build). 

> **Not:** E-posta bildirimlerinin sorunsuz çalışması için Gmail hesabınızdan "Uygulama Şifreleri" özelliğini aktif etmeniz gerekmektedir.

---

## 🎓 Geliştirici Hakkında
2026 yazında mezuniyetini hedefleyen bir **Bilgisayar Programcılığı öğrencisiyim**. Bu proje; sadece C# ve SQL yazmaktan ibaret olmayan, bir sistemin uçtan uca nasıl planlanacağını, güvenliğinin nasıl sağlanacağını ve süreçlerin (e-posta otomasyonu gibi) nasıl otomatikleştirileceğini öğrendiğim ve uyguladığım kapsamlı bir "öğrenim günlüğü" projesidir.