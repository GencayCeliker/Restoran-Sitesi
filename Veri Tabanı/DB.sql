/* =====================================================================
   Moly Restaurant Sitesi - Veritabanı Kurulum Script'i (WRestourantDB)
   ---------------------------------------------------------------------
   SQL Server Management Studio (SSMS) 22 ile:
     1. Sunucunuza bağlanın (ör. .\SQLEXPRESS)
     2. File > Open > File... ile bu dosyayı açın
     3. Execute (F5) ile çalıştırın
   Script boş bir sunucuda çalışacak şekilde hazırlanmıştır:
     - WRestourantDB veritabanını oluşturur
     - 19 tabloyu, birincil/yabancı anahtarları ve varsayılan değerleri kurar
     - Menü, kategori, masa, şef, slider, blog vb. örnek verileri ekler
     - Demo kullanıcı hesaplarını ekler (aşağıda)
   Veritabanı zaten varsa script durur; önce eski veritabanını silin
   veya yedekleyin.

   Demo hesaplar (Giriş Yap sayfasında "Ad Soyad" + "Şifre" ile girilir):
     Yönetici : Ad Soyad = Admin        Şifre = Admin123!
     Üye      : Ad Soyad = Demo Uye     Şifre = Uye123!
   ===================================================================== */

USE [master];
GO

IF DB_ID(N'WRestourantDB') IS NOT NULL
BEGIN
    RAISERROR(N'WRestourantDB zaten mevcut. Yeniden kurmak için önce mevcut veritabanını silin.', 16, 1);
    SET NOEXEC ON;
END
GO

CREATE DATABASE [WRestourantDB] COLLATE Turkish_CI_AS;
GO

USE [WRestourantDB];
GO

/* ---------------------------- TABLOLAR ---------------------------- */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ANASAYFA](
	[AnasayfaID] [int] IDENTITY(1,1) NOT NULL,
	[Resim] [nvarchar](max) NULL,
	[Baslik] [nvarchar](200) NOT NULL,
	[Icerik] [nvarchar](max) NOT NULL,
	[Aciklama] [nvarchar](max) NULL,
	[Durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AnasayfaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[ANASAYFA] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DUYURUBLOGYORUMLARI](
	[YorumID] [int] IDENTITY(1,1) NOT NULL,
	[DuyuruID] [int] NULL,
	[MusteriAdSoyad] [nvarchar](200) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[Tarih] [datetime] NULL,
	[YorumMetni] [nvarchar](max) NOT NULL,
	[Yildiz] [int] NULL,
	[Durum] [bit] NOT NULL,
 CONSTRAINT [PK__DUYURUBL__F2BE14C8949FE24F] PRIMARY KEY CLUSTERED 
(
	[YorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] ADD  CONSTRAINT [DF__DUYURUBLO__Tarih__6C190EBB]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] ADD  CONSTRAINT [DF__DUYURUBLO__Durum__6D0D32F4]  DEFAULT ((0)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DUYURULABLOGLAR](
	[DuyuruID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](200) NOT NULL,
	[Icerik] [nvarchar](max) NOT NULL,
	[Tarih] [date] NULL,
	[Resim] [nvarchar](max) NULL,
	[Yazar] [nvarchar](100) NOT NULL,
	[Goruntulenme] [int] NULL,
	[Begeni] [int] NULL,
	[Durum] [bit] NOT NULL,
 CONSTRAINT [PK__DUYURULA__98E5E1C825C43062] PRIMARY KEY CLUSTERED 
(
	[DuyuruID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] ADD  CONSTRAINT [DF__DUYURULAB__Tarih__619B8048]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] ADD  CONSTRAINT [DF__DUYURULAB__Durum__628FA481]  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HAKKIMDA](
	[HakkimdaID] [int] IDENTITY(1,1) NOT NULL,
	[Resim] [nvarchar](max) NULL,
	[Baslik] [nvarchar](200) NOT NULL,
	[Icerik] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[HakkimdaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICERIKLER](
	[IcerikID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](255) NOT NULL,
	[Tarih] [date] NULL,
	[IcerikMetni] [nvarchar](max) NOT NULL,
	[KFotograf] [nvarchar](max) NULL,
	[Dosya] [nvarchar](max) NULL,
	[Durum] [bit] NOT NULL,
 CONSTRAINT [PK__ICERIKLE__2F4D46C977AA21DF] PRIMARY KEY CLUSTERED 
(
	[IcerikID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[ICERIKLER] ADD  CONSTRAINT [DF__ICERIKLER__Tarih__3C34F16F]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[ICERIKLER] ADD  CONSTRAINT [DF__ICERIKLER__Durum__3D2915A8]  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KATEGORILER](
	[KategoriID] [int] IDENTITY(1,1) NOT NULL,
	[KategoriAd] [nvarchar](100) NOT NULL,
	[Resim] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[KategoriID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASALAR](
	[MasaID] [int] IDENTITY(1,1) NOT NULL,
	[MasaNo] [int] NOT NULL,
	[Kapasite] [int] NULL,
	[Durum] [bit] NOT NULL,
 CONSTRAINT [PK__MASALAR__9F94EBD3DC4DCC85] PRIMARY KEY CLUSTERED 
(
	[MasaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MESAJLAR](
	[MesajID] [int] IDENTITY(1,1) NOT NULL,
	[AdSoyad] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Konu] [nvarchar](150) NULL,
	[Mesaj] [nvarchar](max) NOT NULL,
	[Tarih] [datetime] NULL,
	[OkunduMu] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MesajID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[MESAJLAR] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[MESAJLAR] ADD  DEFAULT ((0)) FOR [OkunduMu]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NAVBAR](
	[NavbarID] [int] IDENTITY(1,1) NOT NULL,
	[MenuAd] [nvarchar](100) NOT NULL,
	[Link] [nvarchar](200) NOT NULL,
	[Sira] [int] NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[NavbarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[NAVBAR] ADD  DEFAULT ((0)) FOR [Sira]
GO
ALTER TABLE [dbo].[NAVBAR] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REZARVASYONDURUM](
	[DurumID] [int] IDENTITY(1,1) NOT NULL,
	[DurumAd] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DurumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REZARVASYONLAR](
	[RezervasyonID] [int] IDENTITY(1,1) NOT NULL,
	[MasaID] [int] NULL,
	[MusteriAdSoyad] [nvarchar](200) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[MusteriTelefon] [nvarchar](20) NOT NULL,
	[Tarih] [date] NULL,
	[Saat] [time](7) NULL,
	[KisiSayisi] [int] NOT NULL,
	[DurumID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RezervasyonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT (getdate()) FOR [Saat]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT ((1)) FOR [DurumID]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEFLER](
	[SefID] [int] IDENTITY(1,1) NOT NULL,
	[Resim] [nvarchar](max) NULL,
	[SefAdSoyad] [nvarchar](100) NOT NULL,
	[Uzmanlik] [nvarchar](100) NOT NULL,
	[Aciklama] [nvarchar](max) NULL,
	[Durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[SEFLER] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIFRE_SIFIRLAMA](
	[TalepID] [int] IDENTITY(1,1) NOT NULL,
	[UyeID] [int] NULL,
	[SifirlamaKodu] [nvarchar](50) NOT NULL,
	[OlusturmaTarihi] [datetime] NULL,
	[GecerlilikTarihi] [datetime] NOT NULL,
	[KullanildiMi] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TalepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] ADD  DEFAULT (getdate()) FOR [OlusturmaTarihi]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] ADD  DEFAULT ((0)) FOR [KullanildiMi]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SITE_AYARLARI](
	[AyarID] [int] IDENTITY(1,1) NOT NULL,
	[Logo] [nvarchar](max) NULL,
	[SiteAd] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AyarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBELER](
	[SubeID] [int] IDENTITY(1,1) NOT NULL,
	[SubeAd] [nvarchar](100) NOT NULL,
	[Sehir] [nvarchar](50) NULL,
	[Adres] [nvarchar](500) NULL,
	[Telefon] [nvarchar](20) NULL,
	[Durum] [bit] NULL,
	[KayitTarihi] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SubeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[SUBELER] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[SUBELER] ADD  DEFAULT (getdate()) FOR [KayitTarihi]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[URUNLER](
	[UrunID] [int] IDENTITY(1,1) NOT NULL,
	[UrunAd] [nvarchar](100) NOT NULL,
	[Fiyat] [decimal](18, 2) NOT NULL,
	[Icindekiler] [nvarchar](max) NULL,
	[Resim] [nvarchar](max) NULL,
	[KategoriID] [int] NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UrunID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[URUNLER] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USTILETISIM](
	[UstID] [int] IDENTITY(1,1) NOT NULL,
	[Telefon] [nvarchar](20) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[AcilisKapanis] [nvarchar](max) NOT NULL,
	[Facebook] [nvarchar](100) NULL,
	[Instagram] [nvarchar](100) NULL,
	[Twitter] [nvarchar](100) NULL,
	[Linkedin] [nvarchar](100) NULL,
	[Durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UstID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[USTILETISIM] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UYELER](
	[UyeID] [int] IDENTITY(1,1) NOT NULL,
	[AdSoyad] [nvarchar](100) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[Sifre] [nvarchar](100) NOT NULL,
	[Yetki] [nvarchar](20) NULL,
	[SozlesmeOnay] [bit] NULL,
	[KayitTarihi] [date] NULL,
	[Durum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UyeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ('Uye') FOR [Yetki]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ((1)) FOR [SozlesmeOnay]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT (getdate()) FOR [KayitTarihi]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ((1)) FOR [Durum]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YORUMLAR](
	[YorumID] [int] IDENTITY(1,1) NOT NULL,
	[MusteriAdSoyad] [nvarchar](200) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[Tarih] [date] NULL,
	[YorumMetni] [nvarchar](max) NOT NULL,
	[Durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[YorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[YORUMLAR] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[YORUMLAR] ADD  DEFAULT ((0)) FOR [Durum]
GO

/* --------------------------- ÖRNEK VERİLER --------------------------- */
SET IDENTITY_INSERT [dbo].[ANASAYFA] ON;
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (1, N'/images/bg_1.jpg', N'MolyRS Restoran', N'Kalitenin Tek Adresi', N'1915'' ten beri..', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (4, N'/images/bg_2.jpg', N'MolyRS Restoran', N'En İyi Kalite', N'Yemekler', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (6, N'/images/bg_3.jpg', N'MolyRs Restoran', N'Uzman Kadro', N'Personel', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (8, N'/images/gallery-7.jpg', N'MolyRS Restoran', N'Kaliteli Vakit', N'Kaliteli Zaman', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (9, N'/images/d074ad09-5504-487f-a3ee-6abbf66331b6.jpg', N'MolyRS Restoran', N'qwwwwwwwwE', N'qweqweqweqwweqeqweqwıadsadas', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (10, N'/images/bf4e3d7a-e85b-4485-9aca-251785895c8b.jpg', N'MolyRS Restoran', N'wqewqasd', N'qeqeqeq', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (11, N'/images/521effb1-553f-46c6-b627-1e57cb4ded85.jpg', N'MolyRS Restoran', N'qweqwe', N'qweqweqw', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (12, N'/images/bg_3.jpg', N'MolyRS Restoran', N'icerik', N'<p></p><pre><p></p><p></p><ul><li><span style="color: rgb(255, 0, 0);">İçerik werwerewrew</span></li></ul></pre><p></p>', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (15, N'/images/cb44a6b3-88b0-4a4d-bf01-1adda7622f2d.jpg', N'MolyRS Restoran', N'qwq', N'<p style="line-height: 1.5; margin-block: 1em; color: rgb(32, 33, 36); font-family: Arial, sans-serif; letter-spacing: normal;"><strong>Makale</strong>, herhangi bir konu hakkında&nbsp;<strong>bilgi vermek, açıklamak veya bir görüşü savunmak amacıyla yazılan düşünce yazısıdır.</strong>&nbsp;Gazete, dergi, blog veya akademik yayınlarda yayımlanabilir. ✍️</p><div><br></div>', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (16, N'/images/40e71e75-7a6e-4cc9-a8e5-63b8637ba6e4.jpg', N'<p><span style="color: rgb(255, 0, 0);">MolyRS Restoran</span></p>', N'<p><span style="font-weight: bold; font-style: italic; text-decoration-line: underline;">İçerik&nbsp;</span></p>', N'<p>asdasdasdasda</p>', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (17, N'/images/13c8dcc4-9997-4b73-9fa6-0e306a959eb1.jpg', N'<font color="#ff0000"><b>MolyRS Restoran</b></font>', N'<b><u>wqeqwewq</u></b>', N'<b><u>qweqweqweqweqww</u></b>', 1);
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (18, N'/images/5a1a5356-36d4-45a8-b342-d8c453a69134.jpg', N'<p><font color="#ff0000"><i><u>Başlık1</u></i></font></p>', N'<p><i style=""><u style=""><b>adasdasdas</b></u></i></p>', N'<p>qeqweeqweqeqwe</p>', 1);
SET IDENTITY_INSERT [dbo].[ANASAYFA] OFF;
GO
SET IDENTITY_INSERT [dbo].[DUYURULABLOGLAR] ON;
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (1, N'Yeni Menümüz Hazırr', N'Şeflerimizin özenle hazırladığı yeni lezzetleri keşfedin...', CAST(N'2026-02-15' AS Date), N'/images/insta-2.jpg', N'Admin', 38, 65, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (2, N'Hafta Sonu Kampanyası', N'Cumartesi günleri tüm tatlılarda %20 indirim.', CAST(N'2026-02-15' AS Date), N'/images/image_2.jpg', N'Admin', 2, NULL, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (3, N'En İyi Restoran Ödülü', N'Bu yıl da şehrin en lezzetli durağı seçildik.', CAST(N'2026-02-15' AS Date), N'/images/image_3.jpg', N'Admin', 2, 1, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (4, N'Vegan Seçenekler', N'<b>Artık menümüzde sağlıklı vegan alternatifler de var.</b>', CAST(N'2026-02-15' AS Date), N'/images/image_1.jpg', N'Admin', 2, NULL, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (5, N'Rezervasyon Kolaylığı', N'Online rezervasyon sistemimiz artık aktif.', CAST(N'2027-10-10' AS Date), N'/images/image_2.jpg', N'Admin', 9, 1, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (6, N'Mekanımız Yenilendi', N'qweqwewqeqweqwewqewq&nbsp;', CAST(N'2026-03-05' AS Date), N'/images/gallery-3.jpg', N'Admin', NULL, NULL, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (7, N'qwewqeqwe', N'qweqweqweqweqweqwsadasdas', CAST(N'2026-03-05' AS Date), N'/images/gallery-6.jpg', N'Admin', 30, 1, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (8, N'qwewq', N'wqeqweqw', CAST(N'2026-03-05' AS Date), N'/images/breakfast-7.jpg', N'Admin', NULL, NULL, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (11, N'qweqwe', N'<ul><li><b><i><u><font color="#ff0000">silinecekkk:DDDDDDDDDDDDDDDDasdsa</font></u></i></b></li></ul>', CAST(N'2026-03-10' AS Date), N'/images/9f7e2005-breakfast-1.jpg', N'eqweqwewqe', 2, NULL, 1);
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (12, N'<p>asdasdas</p>', N'<ul class="post-categories" style="box-sizing: border-box; list-style: none; padding: 0px; margin: 0px; display: inline-block;"><li style="box-sizing: inherit; padding: 0px; margin: 0px; display: inline-block;"><a href="https://toguhaber.gop.edu.tr/kategori/kampus" rel="category tag" style="box-sizing: inherit; background-color: transparent; color: rgb(6, 90, 173); text-decoration: none; transition: 0.2s; border-color: rgb(10, 113, 192); text-transform: uppercase; padding: 0px 5px;">KAMPÜS</a></li></ul><p><span class="cat-links" style="box-sizing: inherit; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);">&nbsp;</span><span class="posted-on mt-clearfix" itemprop="datePublished" style="box-sizing: inherit; position: relative; margin-left: 64px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><a href="https://toguhaber.gop.edu.tr/h/11796" rel="bookmark" style="box-sizing: inherit; color: rgb(136, 136, 136); transition: 0.2s; border-color: rgb(10, 113, 192); font-size: 14px;">25 Mart 2026</a></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span></p><div class="entry-thumbnail single-entry-thumbnail mt-clearfix" style="box-sizing: inherit; margin: 30px 0px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><figure class="post-thumb cover-image" style="margin-bottom: 0px; box-sizing: inherit; line-height: 0; position: relative;"><img width="1600" height="1066" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg" class="attachment-full size-full wp-post-image" alt="Rektörümüzden TOGÜ ŞİFA Merkezine Ziyaret" itemprop="image" decoding="async" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg 1600w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-1536x1023.jpeg 1536w" sizes="(max-width: 1600px) 100vw, 1600px" style="box-sizing: inherit; height: 559.65px; max-width: 100%; width: 840px; object-fit: cover;"></figure></div><div class="entry-meta single-entry-meta" style="box-sizing: inherit; display: flex; justify-content: space-between; align-items: center; padding-bottom: 25px; border-bottom: 1px solid rgb(204, 204, 204); color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><div class="entry-meta-posted-by posted-by-wrap" style="box-sizing: inherit; display: flex; align-items: center;"><span class="byline" style="box-sizing: inherit;"><span class="author vcard" style="box-sizing: inherit;"><a class="url fn n" href="https://toguhaber.gop.edu.tr/h/author/kurumsaliletisim" style="box-sizing: inherit; color: rgb(51, 51, 51); transition: 0.2s; border-color: rgb(10, 113, 192); font-weight: 600;">Kurumsal İletişim Koordinatörlüğü</a></span></span></div><div class="entry-meta-comment comment-mark" style="box-sizing: inherit;"></div><div class="post-views content-post post-11796 entry-meta load-static" style="box-sizing: inherit; line-height: 1.3;"><span class="post-views-label" style="box-sizing: inherit; margin-right: 0px !important; padding-right: 5px; cursor: pointer;"><span class="dashicons dashicons-share" title="Paylaş" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>Paylaş</span>&nbsp;<span class="post-views-count" style="box-sizing: inherit; margin-right: 0px !important; font-weight: bold;"><span class="dashicons dashicons-visibility" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; font-weight: 400; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>81</span></div></div><div class="entry-content single-entry-summary mt-clearfix" itemprop="text" style="box-sizing: inherit; counter-reset: footnotes 0; margin: 1.5rem 0px 30px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; background-color: rgb(249, 249, 249);"><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Rektörümüz Prof. Dr. Fatih Yılmaz, Üniversitemiz bünyesinde faaliyet gösteren TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezini ziyaret ederek yürütülen çalışmaları yerinde inceledi. Ziyarete Rektör yardımcıları, Genel Sekreter ve Rektör Danışmanları da eşlik etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Bitkisel Ürün Geliştirmede Öncü Merkez</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Üniversitemiz Eczacılık Fakültesi tarafından kurulan TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezi, bitkisel kaynaklı sağlık ürünlerinin geliştirilmesi, analiz edilmesi ve pilot ölçekte üretimi amacıyla faaliyetlerini sürdürüyor. Merkez, bilimsel araştırmalar ile üretim süreçlerini bir araya getirerek sektöre önemli katkılar sunmayı hedefliyor.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Rektör Yılmaz: “Uygulamalı Eğitim Vizyonumuza Katkı Sağlıyor”</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Ziyaret kapsamında merkezde yürütülen çalışmalar hakkında bilgi alan Rektörümüz Prof. Dr. Fatih Yılmaz, projenin önemine dikkat çekti. Üniversitemizin “üreten üniversite” ve uygulamalı eğitim vizyonuna vurgu yapan Rektörümüz, merkezin hem öğrenciler hem de araştırmacılar için önemli fırsatlar sunduğunu ifade etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Geniş Kapsamlı Analiz ve Ar-Ge Hizmeti</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Merkezde gerçekleştirilen çalışmalar kapsamında; kremler ve benzeri kozmetik ürünler ile sağlığa faydalı çaylar üretiliyor. TOGÜ Şifa’da üretilen Bağışıklık Çayı’ndan tadan Rektörümüz Prof. Dr. Fatih Yılmaz, üretilen kremi de inceledi. Merkezde ayrıca, Dünya Sağlık Örgütü onaylı formülasyona sahip dezenfektanlar üretilirken, bu ürünlere yöresel kokular eklenerek özgün bir nitelik kazandırılıyor. Bununla birlikte bitkisel hammaddelerin ekstraksiyonu ve standardizasyonu, uçucu yağ ve etken madde analizleri (GC-MS, LC-MS/MS) ile pestisit, ağır metal ve mikrobiyolojik kalite testleri de gerçekleştiriliyor. Yürütülen bu çalışmalarla birlikte merkez, üreticilere kapsamlı analiz hizmeti sunarken Ar-Ge faaliyetlerine de önemli katkı sağlıyor.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Eğitim ve Araştırmanın Buluşma Noktası</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezi, Eczacılık Fakültesi’nin akademik altyapısıyla entegre bir şekilde faaliyet göstererek aynı zamanda bir eğitim üssü olarak hizmet veriyor. Merkez, öğrencilerin uygulamalı eğitim süreçlerine katkı sağlarken, araştırmacılar için de nitelikli bir çalışma ortamı sunuyor.</p><figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-2 is-layout-flex wp-block-gallery-is-layout-flex" style="margin-top: 1em; margin-bottom: 30px; box-sizing: inherit; gap: 8px; flex-wrap: wrap; align-items: normal; display: flex; --wp--style--unstable-gallery-gap: 0.5em; text-align: center; justify-content: center;"><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11798" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-901x600.jpeg" alt="" class="wp-image-11798" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11799" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-901x600.jpeg" alt="" class="wp-image-11799" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11797" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-901x600.jpeg" alt="" class="wp-image-11797" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11801" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-901x600.jpeg" alt="" class="wp-image-11801" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11800" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-901x600.jpeg" alt="" class="wp-image-11800" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11802" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-901x600.jpeg" alt="" class="wp-image-11802" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 559.65px; object-fit: cover; width: 840px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11803" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg" alt="" class="wp-image-11803" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 559.65px; max-width: 100%; vertical-align: bottom; display: block; width: 840px; flex: 1 0 0%; object-fit: cover;"></a></figure></figure></div>', CAST(N'2026-03-25' AS Date), N'/images/d329e5a1-FAEO1242.jpg', N'admin', 38, 3, 1);
SET IDENTITY_INSERT [dbo].[DUYURULABLOGLAR] OFF;
GO
SET IDENTITY_INSERT [dbo].[DUYURUBLOGYORUMLARI] ON;
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (2, 2, N'Yusuf Erdoğan', N'yusuf@gmail.com', CAST(N'2025-10-10T00:00:00.000' AS DateTime), N'Tatlı Çok Güzeldi ', 5, 1);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (3, 3, N'Mustafa Altın', N'mıstk@gmail.com', CAST(N'2026-10-10T00:00:00.000' AS DateTime), N'Tek Tercihimiz', 5, 1);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (4, 4, N'Eyşan Mutlu', N'eysan@gmail.com', CAST(N'2026-10-10T00:00:00.000' AS DateTime), N'Rezervasyon Sistemi Çok Başarlı Olmuş', 4, 1);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (5, 1, N'wqeq', N'wqewqewq@mail.com', CAST(N'2026-02-26T21:27:45.327' AS DateTime), N'qwewqeqw', 4, 1);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (6, 2, N'qwewqe', N'qwewqeq@mail.com', CAST(N'2026-02-26T22:01:43.117' AS DateTime), N'wqeqw', 4, 0);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (8, 2, N'asdasda', N'sdsadsa@mail.com', CAST(N'2026-03-04T20:32:14.447' AS DateTime), N'werfwr', 5, 0);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (9, 7, N'qweqwewq', N'qweqweqwewq@mail.com', CAST(N'2026-03-05T00:41:48.080' AS DateTime), N'qeqweqwewqewqe', 5, 0);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (10, 6, N'qwqeqwewq', N'qweqwewq@mail.com', CAST(N'2026-03-06T14:25:48.197' AS DateTime), N'qweqweqw', 4, 0);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (12, 1, N'qweqwe', N'qweqwew@mail.com', CAST(N'2026-03-10T20:06:05.947' AS DateTime), N'qwewwqeqw', 5, 0);
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (13, 1, N'qweqwe', N'wqeqweqw@mail.com', CAST(N'2026-03-20T21:27:26.150' AS DateTime), N'wqeqweqw', 4, 1);
SET IDENTITY_INSERT [dbo].[DUYURUBLOGYORUMLARI] OFF;
GO
SET IDENTITY_INSERT [dbo].[HAKKIMDA] ON;
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (1, N'/images/5397fc84-about.jpg', N'MOLYRS''E HOŞGELDİNİZ', N'Yusuf, Emrah ve Gencay’ın yolları, gastronomiye olan ortak tutkularıyla kesişti. Yusuf''un geleneksel mutfak ustalığı, Emrah''ın modern vizyonu ve Gencay''ın teknoloji odaklı kusursuz işletme zekası bir araya gelerek Moly RS''in temellerini oluşturdu. Küçük bir mutfakta başlayan bu serüven, kısa sürede şehrin en prestijli lezzet duraklarından birine dönüştü. Bugün misafirlerimize sunulan her tabakta bu eşsiz üçlünün tecrübesini, sanatını ve vizyonunu hissetmek mümkün. Moly RS, sadece bir restoran değil; dostluğun ve azmin yazdırdığı yaşayan bir başarı hikayesidir. Bizim en büyük sırrımız mutfağımızdaki tariflerde değil, işte bu sarsılmaz ekip ruhunda gizlidir."');
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (3, N'/images/yceo.png', N'Yusuf Erdoğan sfsdf', N'Geleneksel lezzetleri modern dokunuşlarla harmanlayan usta şefimiz. Yılların getirdiği mutfak tecrübesiyle, misafirlerimize her tabakta unutulmaz ve imza bir lezzet şöleni sunuyor.. weqeqweqweqw');
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (4, N'/images/eceo.png', N'Emrah Çapkan', N'Dünya mutfağının dinamik ve yenilikçi tatlarını menümüze taşıyan vizyoner kurucumuz. Cesur tarifleri, sıradışı malzeme kombinasyonları ve sunum sanatıyla yemek yemeyi sanatsal bir deneyime dönüştürüyor.');
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (5, N'/images/gceo.png', N'Gencay Çeliker', N'Restoranımızın kusursuz işleyişini, misafir memnuniyetini ve teknolojik altyapısını yöneten operasyon beyni. Moly RS''in modern yüzünü temsil ediyor ve her detayın mükemmel olmasını sağlıyor.');
SET IDENTITY_INSERT [dbo].[HAKKIMDA] OFF;
GO
SET IDENTITY_INSERT [dbo].[ICERIKLER] ON;
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (1, N'qwewqeqwewq', CAST(N'2026-04-03' AS Date), N'<p>wqeqwewqewq</p>', N'kapak_aade4174-5b66-4a21-bdb9-a39f25182895.jpg', N'89e98d38-3e33-4345-b054-c8c7b0036df4.pdf', 1);
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (2, N'Geleneksel Okçulardan Rektörümüze Ziyaret', CAST(N'2026-04-03' AS Date), N'<ul class="post-categories" style="box-sizing: border-box; list-style: none; padding: 0px; margin: 0px; display: inline-block;"><li style="box-sizing: inherit; padding: 0px; margin: 0px; display: inline-block;"><a href="https://toguhaber.gop.edu.tr/kategori/kampus" rel="category tag" style="box-sizing: inherit; background-color: transparent; color: rgb(6, 90, 173); text-decoration: none; transition: 0.2s; border-color: rgb(10, 113, 192); text-transform: uppercase; padding: 0px 5px;">KAMPÜS</a></li></ul><p><span class="cat-links" style="box-sizing: inherit; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);">&nbsp;</span><span class="posted-on mt-clearfix" itemprop="datePublished" style="box-sizing: inherit; position: relative; margin-left: 64px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><a href="https://toguhaber.gop.edu.tr/h/11833" rel="bookmark" style="box-sizing: inherit; color: rgb(136, 136, 136); transition: 0.2s; border-color: rgb(10, 113, 192); font-size: 14px;">26 Mart 2026</a></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span></p><div class="entry-thumbnail single-entry-thumbnail mt-clearfix" style="box-sizing: inherit; margin: 30px 0px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><figure class="post-thumb cover-image" style="margin-bottom: 0px; box-sizing: inherit; line-height: 0; position: relative;"><img width="1600" height="968" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19.jpeg" class="attachment-full size-full wp-post-image" alt="Geleneksel Okçulardan Rektörümüze Ziyaret" itemprop="image" decoding="async" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19.jpeg 1600w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-496x300.jpeg 496w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-992x600.jpeg 992w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-248x150.jpeg 248w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-768x465.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-1536x929.jpeg 1536w" sizes="(max-width: 1600px) 100vw, 1600px" style="box-sizing: inherit; height: 508.2px; max-width: 100%; width: 840px; object-fit: cover;"></figure></div><div class="entry-meta single-entry-meta" style="box-sizing: inherit; display: flex; justify-content: space-between; align-items: center; padding-bottom: 25px; border-bottom: 1px solid rgb(204, 204, 204); color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><div class="entry-meta-posted-by posted-by-wrap" style="box-sizing: inherit; display: flex; align-items: center;"><span class="byline" style="box-sizing: inherit;"><span class="author vcard" style="box-sizing: inherit;"><a class="url fn n" href="https://toguhaber.gop.edu.tr/h/author/kurumsaliletisim" style="box-sizing: inherit; color: rgb(51, 51, 51); transition: 0.2s; border-color: rgb(10, 113, 192); font-weight: 600;">Kurumsal İletişim Koordinatörlüğü</a></span></span></div><div class="entry-meta-comment comment-mark" style="box-sizing: inherit;"></div><div class="post-views content-post post-11833 entry-meta load-static" style="box-sizing: inherit; line-height: 1.3;"><span class="post-views-label" style="box-sizing: inherit; margin-right: 0px !important; padding-right: 5px; cursor: pointer;"><span class="dashicons dashicons-share" title="Paylaş" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>Paylaş</span>&nbsp;<span class="post-views-count" style="box-sizing: inherit; margin-right: 0px !important; font-weight: bold;"><span class="dashicons dashicons-visibility" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; font-weight: 400; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>146</span></div></div><div class="entry-content single-entry-summary mt-clearfix" itemprop="text" style="box-sizing: inherit; counter-reset: footnotes 0; margin: 1.5rem 0px 30px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; background-color: rgb(249, 249, 249);"><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Rektörümüz Prof. Dr. Fatih Yılmaz, Gaziosmanpaşa Geleneksel Osmanlı Atlı Okçuluk Spor Kulübü Başkanı Nadir Oflaz ve beraberindeki heyeti makamında kabul etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Gerçekleştirilen ziyarette, geleneksel sporların yaşatılması ve gelecek nesillere aktarılmasının önemi üzerinde duruldu. Heyet, kulübün faaliyetleri ve yürüttükleri çalışmalar hakkında Rektör Yılmaz’a bilgi verdi. Rektörümüz Prof. Dr. Fatih Yılmaz ise kültürel mirasın önemli bir parçası olan atlı okçuluk sporunun desteklenmesinin büyük değer taşıdığını ifade etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Ziyaret kapsamında Rektörümüz Prof. Dr. Fatih Yılmaz’a bir hediye de takdim edildi. Hediyenin üzerinde “Attığın zaman sen atmadın lakin Allah attı.” (Enfal Suresi, 17. Ayet) ifadesi yer alıyor.</p><figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-2 is-layout-flex wp-block-gallery-is-layout-flex" style="margin-top: 1em; margin-bottom: 30px; box-sizing: inherit; gap: 8px; flex-wrap: wrap; align-items: normal; display: flex; --wp--style--unstable-gallery-gap: 0.5em; text-align: center; justify-content: center;"><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11834" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-901x600.jpeg" alt="" class="wp-image-11834" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-19.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11836" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-901x600.jpeg" alt="" class="wp-image-11836" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-20.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11835" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-901x600.jpeg" alt="" class="wp-image-11835" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-17.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19.jpeg" style="box-sizing: inherit; color: rgb(6, 90, 173); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; outline-style: initial; outline-width: 0px; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 508.038px; object-fit: cover; width: 840px;"><img loading="lazy" decoding="async" width="992" height="600" data-id="11837" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-992x600.jpeg" alt="" class="wp-image-11837" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-992x600.jpeg 992w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-496x300.jpeg 496w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-248x150.jpeg 248w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-768x465.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19-1536x929.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-19.jpeg 1600w" sizes="(max-width: 992px) 100vw, 992px" style="height: 508.038px; max-width: 100%; vertical-align: bottom; display: block; width: 840px; flex: 1 0 0%; object-fit: cover;"></a></figure></figure></div>', N'kapak_924685e2-5aed-41fb-9a59-e75680d28bd0.jpg', N'8e0a3d7e-42dd-43ad-b8a2-0e844d77aea1.pdf', 1);
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (4, N'Üniversite öğrencileri hurda malzemelerinden araç üretti', CAST(N'2026-04-05' AS Date), N'<div class="detay-bg" style="width: 1520.8px; height: auto; background-color: rgb(0, 51, 161); color: rgb(33, 37, 41); font-family: GothamNarrow-Book; font-size: 16px; letter-spacing: normal;"><div class="detay-spot container " style="width: 1140px; margin-top: auto; margin-bottom: auto; color: white;"><div class="detay-spot-category" style="margin: auto; padding: 15px 10px 15px 0px;"><h1 style="font-family: GothamNarrow-Black; line-height: 1.2; color: inherit; font-size: 2.5rem; letter-spacing: 1px;">Üniversite öğrencileri hurda malzemelerinden araç üretti</h1><h4 style="line-height: 1.2; color: inherit; font-size: 1.5rem; width: 990px;">Tokat Gaziosmanpaşa Üniversitesi Zile Meslek Yüksekokulu öğrencileri, yaklaşık 3 ayda hurda parçalarından motorlu araç üretti.</h4><div class="row" style="margin-right: 0px; margin-left: 0px; width: 1100px;"><span class="tarih" style="display: block; float: left; padding-left: 0px;">08.05.2018 - Güncelleme : 09.05.2018</span></div></div></div></div><div style="color: rgb(33, 37, 41); font-family: GothamNarrow-Book; font-size: 16px; letter-spacing: normal; height: 200px; background-color: rgb(0, 51, 161); width: 1520.8px; margin-top: -2px;"></div><div class="row detay container" style="width: 1140px; margin: auto; color: rgb(33, 37, 41); font-family: GothamNarrow-Book; font-size: 16px; letter-spacing: normal; background-color: rgb(255, 255, 255);"><div class="col-md-10" style="width: 925px; min-height: 1px; flex-basis: 83.3333%; max-width: 83.3333%; margin-top: -225px; padding: 10px 0px !important;"><img src="https://cdnuploads.aa.com.tr/uploads/Contents/2018/05/08/thumbs_b_c_08b3360fc2e3cafa096da68cd0e1c9e9.jpg?v=131329" class="detay-buyukFoto img-fluid" alt="Üniversite öğrencileri hurda malzemelerinden araç üretti" style="width: 925px; padding-top: 15px;"><span class="detay-foto-editor" style="width: 925px; padding: 10px; float: left; font-size: small; color: gray;">Fotoğraf: AA/Ekber Türkoğlu</span><br><br><div><div class="sticky-top social-left d-none d-sm-block" style="z-index: 0; float: left; width: 50px; margin-right: 10px; top: 80px !important;">&nbsp;&nbsp;<a role="button" class="btn twitter" target="_blank" href="https://twitter.com/intent/tweet?url=http://v.aa.com.tr/1138522&amp;text=Hurda+malzemelerinden+ara%c3%a7+%c3%bcrettiler" style="color: white; background-color: rgb(45, 45, 45); opacity: 1; text-wrap-mode: nowrap; border-color: rgb(95, 93, 93); padding: 5px; font-size: 1rem; border-radius: 35px; width: 35px; height: 35px; margin: 5px; cursor: pointer;"><svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"></svg></a>&nbsp;&nbsp;&nbsp;</div><div class="detay-icerik" style="padding: 0px 40px 0px 94px; font-size: 17px;"><h6 style="font-family: GothamNarrow-black; line-height: 1.2; color: inherit; font-size: 1rem; padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 0px !important;"></h6><div><p class="selectionShareable" style="margin-bottom: 1rem;">TOKAT</p><p class="selectionShareable" style="margin-bottom: 1rem;"><span style="font-weight: bolder; font-family: GothamNarrow-Bold;">Tokat Gaziosmanpaşa Üniversitesi&nbsp;</span>(<span style="font-weight: bolder; font-family: GothamNarrow-Bold;">GOÜ</span>) Zile Meslek Yüksekokulu öğrencileri, hurda parçalarından araç üretti.</p><p class="selectionShareable" style="margin-bottom: 1rem;">Yüksekokulun otomotiv programında okuyan 10 öğrenci, yaklaşık 3 ay süren çalışmaları sonucunda motosiklet motoru kullanarak yaptıkları, saatte 20 kilometre hıza ulaşan araca "Sürüngen 1" adını verdi.</p><p class="selectionShareable" style="margin-bottom: 1rem;"><img alt="" src="https://cdnuploads.aa.com.tr/uploads/userFiles/a3cef322-2226-46a7-8042-dd229a26755a/8%20mayis%2F20180508_2_30230566_33467745.jpg" style="max-width: 100%;"></p><p class="selectionShareable" style="margin-bottom: 1rem;">Zile Meslek Yüksekokulu Otomotiv Programı Öğretim Görevlisi Mehmet Zorkoç, gazetecilere yaptığı açıklamada, bölümlerinde daha önce de araç yaptıklarını söyledi.</p><p class="selectionShareable" style="margin-bottom: 1rem;">Öğrencilerin mesleki bilgi ve becerilerinin gelişmesi için benzinle, elektrikle , güneş enerjisi ile çalışan araçlar yaptıklarını anlatan Zorkoç, son olarak öğrencilerin hurda parçalarını kullanarak araç yaptıklarını belirtti.</p><p class="selectionShareable" style="margin-bottom: 1rem;"><img alt="" src="https://cdnuploads.aa.com.tr/uploads/userFiles/de89f914-66b1-4a0b-9347-13c0eafe70cc/2018%2F05%2Farac_1.jpg" style="max-width: 100%;"></p><p class="selectionShareable" style="margin-bottom: 1rem;">Araçta motosiklet motoru kullanıldığını ifade eden Zorkoç, "Okulumuzda mekatronik programımız var. Onlar da yazılım aşamasında. Farklı yazılımlarla uğraşan öğretim görevlisi arkadaşlarımızın da desteklerini alarak mesela ön frenleme mesafesi, parmak iziyle çalıştırma, park sensörü, navigator sistemi ilave etme gibi farklı farklı sistemleri ilerleyen çalışmalarımızda gerçekleştireceğiz." dedi.</p><p class="selectionShareable" style="margin-bottom: 1rem;">Öğrencilerden Faruk Demirbağ ise araç için yaklaşık 3 bin lira harcadıklarını aktardı.</p><p class="selectionShareable" style="margin-bottom: 1rem;">Muhabir:&nbsp;Ekber Türkoğlu</p></div></div></div></div></div>', N'kapak_ade76d8a-1cd3-4e5a-a772-4e202ef60c19.jpg', NULL, 1);
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (5, N'Müdürümüz İsmail Küçükali’den Zile Kaymakamı ve Belediye Başkanına Nezaket Ziyareti', CAST(N'2026-04-02' AS Date), N'<div class="duyuru-detay-header" style="border-bottom: 1px solid rgb(229, 234, 234); margin-bottom: 22px;"><h3 style="padding: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; font-family: Pavanam, sans-serif; line-height: 1.3em; letter-spacing: 0.05em; font-size: 20px; color: rgb(96, 157, 219); font-weight: 600 !important;">Müdürümüz İsmail Küçükali’den Zile Kaymakamı ve Belediye Başkanına Nezaket Ziyareti</h3><ul style="margin-block: 0px; padding: 0px 0px 12px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none;"><li style="margin: 4px 0px; padding-right: 10px; color: rgb(156, 165, 171); font-size: 12px; display: inline; position: relative;"><span class="fa fa-clock-o"></span>&nbsp;15 Mart 2026 Pazar</li><li style="margin: 4px 0px; padding-right: 10px; color: rgb(156, 165, 171); font-size: 12px; display: inline; position: relative;"><span class="fa fa-eye"></span>&nbsp;177 Görüntüleme</li><li style="margin: 4px 0px; padding-right: 10px; color: rgb(156, 165, 171); font-size: 12px; display: inline; position: relative;"><span class="fa fa-print"></span>&nbsp;Yazdır</li><li style="margin: 4px 0px; padding-right: 10px; color: rgb(156, 165, 171); font-size: 12px; display: inline; position: relative;"><div style="position: absolute; display: inline-block; margin-top: 2px;"><div id="fb-root" class=" fb_reset" style="background: none; border: 0px; border-spacing: 0px; color: rgb(0, 0, 0); cursor: auto; direction: ltr; font-family: &quot;lucida grande&quot;, tahoma, verdana, arial, sans-serif; font-size: 11px; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; letter-spacing: normal; line-height: 1; margin: 0px; overflow: visible; padding: 0px; text-shadow: none; visibility: visible; word-spacing: normal;"><div style="overflow: hidden; position: absolute; top: -10000px; width: 0px; height: 0px;"><div></div></div></div><div class="fb-share-button fb_iframe_widget" data-href="http://zmyo.gop.edu.tr/duyuruDetay.aspx?d=tr-TR&amp;m=duyuru_detay&amp;id=48365" data-layout="button_count" fb-xfbml-state="rendered" fb-iframe-plugin-query="app_id=&amp;container_width=0&amp;href=http%3A%2F%2Fzmyo.gop.edu.tr%2FduyuruDetay.aspx%3Fd%3Dtr-TR%26m%3Dduyuru_detay%26id%3D48365&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey" style="display: inline-block; position: relative;"><span style="display: inline-block; position: relative; text-align: justify; vertical-align: bottom; width: 77px; height: 20px;"><iframe name="faffe1d9749f25e47" width="1000px" height="1000px" data-testid="fb:share_button Facebook Social Plugin" title="fb:share_button Facebook Social Plugin" frameborder="0" allowtransparency="true" allowfullscreen="true" scrolling="no" allow="encrypted-media" src="https://www.facebook.com/v3.0/plugins/share_button.php?app_id=&amp;channel=https%3A%2F%2Fstaticxx.facebook.com%2Fx%2Fconnect%2Fxd_arbiter%2F%3Fversion%3D46%23cb%3Df8d1a3e751629dd07%26domain%3Dzmyo.gop.edu.tr%26is_canvas%3Dfalse%26origin%3Dhttps%253A%252F%252Fzmyo.gop.edu.tr%252Ff06446ce5d5e846b5%26relation%3Dparent.parent&amp;container_width=0&amp;href=http%3A%2F%2Fzmyo.gop.edu.tr%2FduyuruDetay.aspx%3Fd%3Dtr-TR%26m%3Dduyuru_detay%26id%3D48365&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey" class="" style="position: absolute; border-width: initial; border-style: none; visibility: visible; width: 77px; height: 20px;"></iframe></span></div></div></li><li style="margin: 4px 0px 4px 60px; padding-right: 10px; color: rgb(156, 165, 171); font-size: 12px; display: inline; position: relative;"><div style="position: absolute; display: inline-block; margin-top: 2px;"><iframe id="twitter-widget-0" scrolling="no" frameborder="0" allowtransparency="true" allowfullscreen="true" class="twitter-share-button twitter-share-button-rendered twitter-tweet-button" title="X Post Button" src="https://platform.twitter.com/widgets/tweet_button.2f70fb173b9000da126c79afe2098f02.en.html#dnt=false&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=https%3A%2F%2Fzmyo.gop.edu.tr%2FduyuruDetay.aspx%3Fd%3Dtr-TR%26m%3Dduyuru_detay%26id%3D48365&amp;size=m&amp;text=Tokat%20Gaziosmanpa%C5%9Fa%20%C3%9Cniversitesi%20Zile%20Meslek%20Y%C3%BCksekokulu&amp;time=1775213362134&amp;type=share&amp;url=https%3A%2F%2Fzmyo.gop.edu.tr%2FduyuruDetay.aspx%3Fd%3Dtr-TR%26m%3Dduyuru_detay%26id%3D48365" style="position: static; visibility: visible; width: 65px; height: 20px;"></iframe></div></li></ul></div><p style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;"></p><p style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;">Tokat Gaziosmanpaşa Üniversitesi Zile Meslek Yüksekokulu Müdürlüğü görevine başlayan Öğr. Gör. İsmail Küçükali, Zile Kaymakamı Sayın Çağlar Tekin ve Zile Belediye Başkanı Sayın Şükrü Sargın’a nezaket ziyaretlerinde bulundu.</p><p data-start="327" data-end="564" style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;">Bu kapsamda ilk olarak Zile Kaymakamı Sayın Çağlar Tekin’i makamında ziyaret eden Küçükali, yüksekokulun yürüttüğü akademik çalışmalar ve planlanan faaliyetler hakkında bilgi vererek ilçedeki kurumlarla iş birliğinin önemine vurgu yaptı.</p><p data-start="566" data-end="806" style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;">Küçükali daha sonra Zile Belediye Başkanı Sayın Şükrü Sargın’ı makamında ziyaret etti. Ziyarette yüksekokul ile yerel yönetimler arasında gerçekleştirilebilecek ortak çalışmalar ve iş birliği imkanları üzerine görüş alışverişinde bulunuldu.</p><p data-start="808" data-end="937" style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;">Gerçekleştirilen ziyaretlere Zile Meslek Yüksekokulu Müdür Yardımcıları Öğr. Gör. Emre Türk ve Öğr. Gör. İmdat Köksal da katıldı.</p><p><br></p><div class="slider-navigation-container" style="text-align: right; margin-right: 7px;"></div><div class="responsive" style="width: auto; margin-left: 0px; margin-top: 10px;"><div id="links"><div class="caroufredsel_wrapper" style="float: none; inset: auto; z-index: auto; margin: 0px; overflow: hidden; position: relative; height: 131px; width: initial;"><ul id="foto_slider" style="margin-block: 0px; padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; float: none; position: absolute; inset: 0px auto auto 0px; width: 2241px; height: 131px;"><li style="margin: 6px; font-size: 10px; color: rgb(153, 153, 153); text-align: center; background-color: rgb(238, 238, 238); border: 1px solid rgb(153, 153, 153); padding: 0px; display: block; float: left; width: 237px; height: 119.3px;"><a href="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/dcc0ng3j.jpg" title="" style="padding: 0px; transition: 0.1s ease-in-out; color: rgb(51, 122, 183);"><img src="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/dcc0ng3j.jpg" alt="" style="border: 0px; max-width: 100%;"></a></li><li style="margin: 6px; font-size: 10px; color: rgb(153, 153, 153); text-align: center; background-color: rgb(238, 238, 238); border: 1px solid rgb(153, 153, 153); padding: 0px; display: block; float: left; width: 237px; height: 119.3px;"><a href="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/m0rexs0j.jpg" title="" style="padding: 0px; transition: 0.1s ease-in-out; color: rgb(51, 122, 183);"><img src="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/m0rexs0j.jpg" alt="" style="border: 0px; max-width: 100%;"></a></li><li style="margin: 6px; font-size: 10px; color: rgb(153, 153, 153); text-align: center; background-color: rgb(238, 238, 238); border: 1px solid rgb(153, 153, 153); padding: 0px; display: block; float: left; width: 237px; height: 119.3px;"><a href="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/wq12pbxd.jpg" title="" style="padding: 0px; transition: 0.1s ease-in-out; color: rgb(51, 122, 183);"><img src="https://zmyo.gop.edu.tr/depo/menuler/birim_11332/haberler_195/6874385/resim_slider/wq12pbxd.jpg" alt="" style="border: 0px; max-width: 100%;"></a></li></ul></div></div><div style="float: none; clear: both;"></div></div><p style="padding-bottom: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; text-align: justify;"><br style="color: rgb(102, 110, 112); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; letter-spacing: normal; background-color: rgb(255, 255, 255);"></p><p style="box-sizing: border-box; padding-bottom: 0px; margin: 0px 0px 10px; text-align: justify;"></p>', N'kapak_e36078af-e19d-4620-92ef-c2da839c2b1f.jpg', NULL, 1);
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (6, N'mqweqweqw', CAST(N'2026-04-02' AS Date), N'<p>wqeqwewqe</p>', NULL, N'8eb316fe-8643-45af-8ac9-4e23829c9b7c.pdf', 1);
INSERT [dbo].[ICERIKLER] ([IcerikID], [Baslik], [Tarih], [IcerikMetni], [KFotograf], [Dosya], [Durum]) VALUES (7, N'Medeni Kanun Sempozyumu Öncesi Rektörümüze Ziyaret', CAST(N'2026-04-02' AS Date), N'<ul class="post-categories" style="box-sizing: border-box; list-style: none; padding: 0px; margin: 0px; display: inline-block;"><li style="box-sizing: inherit; padding: 0px; margin: 0px; display: inline-block;"><a href="https://toguhaber.gop.edu.tr/kategori/kampus" rel="category tag" style="box-sizing: inherit; background-color: transparent; color: rgb(6, 90, 173); text-decoration: none; transition: 0.2s; border-color: rgb(10, 113, 192); text-transform: uppercase; padding: 0px 5px;">KAMPÜS</a></li></ul><p><span class="cat-links" style="box-sizing: inherit; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);">&nbsp;</span><span class="posted-on mt-clearfix" itemprop="datePublished" style="box-sizing: inherit; position: relative; margin-left: 64px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><a href="https://toguhaber.gop.edu.tr/h/11819" rel="bookmark" style="box-sizing: inherit; color: rgb(136, 136, 136); transition: 0.2s; border-color: rgb(10, 113, 192); font-size: 14px;">26 Mart 2026</a></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span></p><div class="entry-thumbnail single-entry-thumbnail mt-clearfix" style="box-sizing: inherit; margin: 30px 0px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><figure class="post-thumb cover-image" style="margin-bottom: 0px; box-sizing: inherit; line-height: 0; position: relative;"><img width="1600" height="1066" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1.jpeg" class="attachment-full size-full wp-post-image" alt="Medeni Kanun Sempozyumu Öncesi Rektörümüze Ziyaret" itemprop="image" decoding="async" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1.jpeg 1600w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-1536x1023.jpeg 1536w" sizes="(max-width: 1600px) 100vw, 1600px" style="box-sizing: inherit; height: 559.65px; max-width: 100%; width: 840px; object-fit: cover;"></figure></div><div class="entry-meta single-entry-meta" style="box-sizing: inherit; display: flex; justify-content: space-between; align-items: center; padding-bottom: 25px; border-bottom: 1px solid rgb(204, 204, 204); color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><div class="entry-meta-posted-by posted-by-wrap" style="box-sizing: inherit; display: flex; align-items: center;"><span class="byline" style="box-sizing: inherit;"><span class="author vcard" style="box-sizing: inherit;"><a class="url fn n" href="https://toguhaber.gop.edu.tr/h/author/kurumsaliletisim" style="box-sizing: inherit; color: rgb(51, 51, 51); transition: 0.2s; border-color: rgb(10, 113, 192); font-weight: 600;">Kurumsal İletişim Koordinatörlüğü</a></span></span></div><div class="entry-meta-comment comment-mark" style="box-sizing: inherit;"></div><div class="post-views content-post post-11819 entry-meta load-static" style="box-sizing: inherit; line-height: 1.3;"><span class="post-views-label" style="box-sizing: inherit; margin-right: 0px !important; padding-right: 5px; cursor: pointer;"><span class="dashicons dashicons-share" title="Paylaş" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>Paylaş</span>&nbsp;<span class="post-views-count" style="box-sizing: inherit; margin-right: 0px !important; font-weight: bold;"><span class="dashicons dashicons-visibility" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; font-weight: 400; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>145</span></div></div><div class="entry-content single-entry-summary mt-clearfix" itemprop="text" style="box-sizing: inherit; counter-reset: footnotes 0; margin: 1.5rem 0px 30px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; background-color: rgb(249, 249, 249);"><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Üniversitemiz ev sahipliğinde düzenlenen “Türk Medeni Kanunu’nun Yüzüncü Yılı” temalı sempozyum öncesinde, Rektörümüz Prof. Dr. Fatih Yılmaz’a nezaket ziyareti gerçekleştirildi.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Ziyarete, Adalet Komisyonu Başkanı Sedat Soydemir, Atatürk Araştırma Merkezi Başkanı Prof. Dr. Ahmet Kılınç ve İdare Mahkemesi Başkanı Alper Aksakal katıldı.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Rektörlük makamında gerçekleşen ziyarette, üniversitemizin ev sahipliğinde düzenlenecek sempozyuma ilişkin değerlendirmelerde bulunuldu. Hukuk alanında önemli bir dönüm noktası olan Medeni Kanun’un 100. yılı kapsamında gerçekleştirilecek etkinliklerin bilimsel katkısı ve önemi üzerine görüş alışverişinde bulunuldu.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Rektörümüz Prof. Dr. Fatih Yılmaz, nazik ziyaretlerinden dolayı misafirlere teşekkür ederek, sempozyumun verimli geçmesi temennisinde bulundu.</p><figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-2 is-layout-flex wp-block-gallery-is-layout-flex" style="margin-top: 1em; margin-bottom: 30px; box-sizing: inherit; gap: 8px; flex-wrap: wrap; align-items: normal; display: flex; --wp--style--unstable-gallery-gap: 0.5em; text-align: center; justify-content: center;"><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11826" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-901x600.jpeg" alt="" class="wp-image-11826" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11822" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-901x600.jpeg" alt="" class="wp-image-11822" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11824" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-901x600.jpeg" alt="" class="wp-image-11824" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.07-1.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11820" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-901x600.jpeg" alt="" class="wp-image-11820" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11821" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-901x600.jpeg" alt="" class="wp-image-11821" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.09.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11823" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-901x600.jpeg" alt="" class="wp-image-11823" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.08.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 559.65px; object-fit: cover; width: 840px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11825" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-901x600.jpeg" alt="" class="wp-image-11825" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/WhatsApp-Image-2026-03-26-at-11.14.06-1.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 559.65px; max-width: 100%; vertical-align: bottom; display: block; width: 840px; flex: 1 0 0%; object-fit: cover;"></a></figure></figure></div>', N'kapak_1c8adc7c-3751-46d8-9896-ca387582fb3a.jpg', N'ae8fe2a3-05ae-42c9-b378-d6ef478410e0.pdf', 1);
SET IDENTITY_INSERT [dbo].[ICERIKLER] OFF;
GO
SET IDENTITY_INSERT [dbo].[KATEGORILER] ON;
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (1, N'Kahvaltı', N'/images/breakfast-icon.png');
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (2, N'Öğle Yemeği', N'/images/lunch-icon.png');
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (3, N'Akşam Yemeği', N'/images/dinner-icon.png');
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (4, N'Tatlılar', N'/images/dessert-icon.png');
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (5, N'İçecekler', N'/images/drink-icon.png');
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (9, N'Sulu Yemekler', NULL);
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (10, N'Atıştırmalıklar', NULL);
SET IDENTITY_INSERT [dbo].[KATEGORILER] OFF;
GO
SET IDENTITY_INSERT [dbo].[MASALAR] ON;
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (1, 1, 2, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (2, 2, 3, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (3, 3, 4, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (4, 4, 5, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (5, 5, 6, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (6, 6, 7, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (7, 7, 8, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (8, 8, 9, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (9, 9, 10, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (10, 10, 15, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (11, 11, 13, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (12, 12, 12, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (13, 13, 11, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (14, 14, 4, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (15, 15, 6, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (16, 16, 8, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (17, 17, 5, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (18, 18, 3, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (19, 19, 2, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (20, 20, 20, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (21, 21, 2, 0);
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (23, 22, 4, 0);
SET IDENTITY_INSERT [dbo].[MASALAR] OFF;
GO
SET IDENTITY_INSERT [dbo].[NAVBAR] ON;
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (1, N'Anasayfa', N'/', 1, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (2, N'Hakkımızda', N'/hakkimizda', 2, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (3, N'Menüler', N'/menuler', 3, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (4, N'Rezervasyon', N'/rezervasyon', 4, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (5, N'Şefimiz', N'/sefimiz', 5, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (6, N'Blog', N'/blog', 6, 1);
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (7, N'İletişim', N'/iletisim', 7, 1);
SET IDENTITY_INSERT [dbo].[NAVBAR] OFF;
GO
SET IDENTITY_INSERT [dbo].[REZARVASYONDURUM] ON;
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (1, N'Beklemede');
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (2, N'Onaylandı');
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (3, N'İptal Edildi');
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (4, N'Tamamlandı');
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (5, N'Gelmedi');
SET IDENTITY_INSERT [dbo].[REZARVASYONDURUM] OFF;
GO
SET IDENTITY_INSERT [dbo].[SEFLER] ON;
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (1, N'images/gceo.png', N'Gencay Çeliker', N'CEO, Kurucu Ortak', N'Kurucu İş Kolik', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (2, N'images/yceo.png', N'Yusuf Erdoğan', N'CEO, Kurucu Ortak', N'Kurucu ', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (3, N'images/eceo.png', N'Emrah Çapkan', N'CEO, Kurucu Ortak', N'Operasyon Müdürü', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (4, N'images/chef-1.jpg', N'Buğrahan Yılmaz', N'Baş Aşçı', N'Izgara ve et pişirme teknikleri ustası', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (5, N'images/chef-4.jpg', N'Lena Valo', N'Sous Chef', N'Mutfak koordinasyonu ve tatlı yönetimi sorumlusu.', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (7, N'images/chef-2.jpg', N'Seda Yüce', N'Şef Aşçı', N'Fransız mutfağı ve sunum sanatında uzman.', 0);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (10, N'images/chef-3.jpg', N'qweqwe', N'wqewqe', N'qweqw', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (11, N'/images/83b172ce-a8de-4300-a631-29dd02f7c5a1.jpg', N'Ali Yabacaı', N'İtalyan Mutfağı Uzmanı', N'deneme', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (12, N'/images/5e9fe888-c2ea-4666-bcd1-a619896b5e98.jpg', N'qweqweqwe', N'qweqweqwe', N'eqwewqeq', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (15, N'/images//anayer.jpg', N'qwqeqw', N'wqewqewq', N'wqeqwewqewq', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (16, N'/images/8c6860d6-760b-4ce6-9329-b5120f9adf60.jpg', N'Ahmet Cabbar', N'qweqwewq', N'qweqwewq', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (17, N'/images/testimonials-3.jpg', N'wqeqwe', N'wqewqe', N'wqewqewq', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (18, N'/images/e98ff106-e23c-48e6-81a6-5d84a28018f5.jpg', N'wqeqwewq', N'ewqewq', N'ewqewqewq', 1);
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (19, N'/images/5b82be18-4dba-45d3-9740-c5c0d38cd197.jpg', N'qwewqeqw', N'ewqewq', N'ewqewqewq', 1);
SET IDENTITY_INSERT [dbo].[SEFLER] OFF;
GO
SET IDENTITY_INSERT [dbo].[SITE_AYARLARI] ON;
INSERT [dbo].[SITE_AYARLARI] ([AyarID], [Logo], [SiteAd]) VALUES (1, N'/images/logo.png', N'MolyRS');
SET IDENTITY_INSERT [dbo].[SITE_AYARLARI] OFF;
GO
SET IDENTITY_INSERT [dbo].[SUBELER] ON;
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (1, N'Ankara Moly', N'Ankara', N'ATATÜRK CAD.ŞEVKET DAİRE.24 KAT:4, 44200', N'12345678912', 1, CAST(N'2026-05-10T18:32:11.580' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (2, N'Ankara Moly2', N'Ankara', N'QWEQWEWQE', N'98765432112', 1, CAST(N'2026-05-10T18:32:44.433' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (3, N'Ankara Moly3', N'Ankara', N'weqweqweqw', N'12345678912', 1, CAST(N'2026-05-10T18:34:50.100' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (4, N'İstanbul Moly', N'İstanbul', N'qweqwewq', N'12345678911', 1, CAST(N'2026-05-10T18:35:42.810' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (5, N'İstanbul Moly', N'İstanbul', N'sadadasdasasdasd', N'12356789121', 1, CAST(N'2026-05-10T18:35:51.517' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (6, N'İstanbul Moly', N'İstanbul', N'wdsadsadasdasd', N'12345678922', 1, CAST(N'2026-05-10T18:35:52.533' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (7, N'Tokat Moly', N'Tokat', N'qweqwewq', N'58643214560', 1, CAST(N'2026-05-10T18:37:09.170' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (8, N'Tokat Moly', N'Tokat', N'rwerwerwer', N'13254687912', 1, CAST(N'2026-05-10T18:37:22.250' AS DateTime));
INSERT [dbo].[SUBELER] ([SubeID], [SubeAd], [Sehir], [Adres], [Telefon], [Durum], [KayitTarihi]) VALUES (9, N'Ordu Moly (Vabisin Yeri)', N'Ordu', N'Ordu/Altınordu Durugöl MAh. 1091 sk. no3 kat 1', N'05340126384', 1, CAST(N'2025-04-09T00:00:00.000' AS DateTime));
SET IDENTITY_INSERT [dbo].[SUBELER] OFF;
GO
SET IDENTITY_INSERT [dbo].[URUNLER] ON;
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (1, N'Soslu Dana Rosto', 290.00, N'Dana Eti, Patates, Pirinç, Domates', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (2, N'Çikolatalı Sufle', 180.00, N'Bitter Çikolata, Yumurta, Şeker', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (3, N'Taze Portakal Suyu', 85.00, N'Doğal Portakal, Vitaminli, Buzlu', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (4, N'Meyveli Cheesecake', 165.00, N'Labne, Bisküvi, Mevsim Meyveleri', N'/images/dessert-2.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (5, N'Izgara Köfte', 240.00, N'Dana Kıyma, Baharatlar, Köz Biber', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (6, N'Serpme Kahvaltı', 200.00, N'Domates,Yumurta,Patates Kızartması', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (12, N'Serpme Kahvaltı', 200.00, N'Domates,Yumurta,Patates Kızartması', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (13, N'Serpme Kahvaltı', 200.00, N'Domates,Yumurta,Patates Kızarması', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (15, N'Soslu Dana Rosto', 290.00, N'Dana Eti, Patates, Pirinç, Domates', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (16, N'Soslu Dana Roso', 290.00, N'Dana Eti, Patates, Pirinç, Domates', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (22, N'Çikolatalı Sufle', 180.00, N'Bitter Çikolata, Yumurta, Şeker', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (23, N'Çikolatalı Sufle', 180.00, N'Bitter Çikolata, Yumurta, Şeker', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (25, N'Taze Portakal Suyu', 85.00, N'Doğal Portakal, Vitaminli, Buzlu', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (26, N'Taze Portakal Suyu', 85.00, N'Doğal Portakal, Vitaminli, Buzlu', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (28, N'Izgara Köfte', 240.00, N'Dana Kıyma, Baharatlar, Köz Biber', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (29, N'Izgara Köfte', 240.00, N'Dana Kıyma, Baharatlar, Köz Biber', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (30, N'Test Kahvaltı 1', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (31, N'Test Kahvaltı 2', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (32, N'Test Kahvaltı 3', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (33, N'Test Kahvaltı 4', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (34, N'Test Kahvaltı 5', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (35, N'Test Kahvaltı 6', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (36, N'Test Kahvaltı 7', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (37, N'Test Kahvaltı 8', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (38, N'Test Kahvaltı 9', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (39, N'Test Kahvaltı 10', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (40, N'Test Kahvaltı 11', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (41, N'Test Kahvaltı 12', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (42, N'Test Kahvaltı 13', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (43, N'Test Kahvaltı 14', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (44, N'Test Kahvaltı 15', 45.00, N'Peynir, Zeytin, Test Malzemesi', N'/images/breakfast-4.jpg', 1, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (45, N'Test Başlangıç 1', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (46, N'Test Başlangıç 2', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (47, N'Test Başlangıç 3', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (48, N'Test Başlangıç 4', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (49, N'Test Başlangıç 5', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (50, N'Test Başlangıç 6', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (51, N'Test Başlangıç 7', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (52, N'Test Başlangıç 8', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (53, N'Test Başlangıç 9', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (54, N'Test Başlangıç 10', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (55, N'Test Başlangıç 11', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (56, N'Test Başlangıç 12', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (57, N'Test Başlangıç 13', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (58, N'Test Başlangıç 14', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (59, N'Test Başlangıç 15', 35.00, N'Soslar, Atıştırmalık, Test', N'/images/lunch-1.jpg', 2, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (60, N'Test Ana Yemek 1', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (61, N'Test Ana Yemek 2', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (62, N'Test Ana Yemek 3', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (63, N'Test Ana Yemek 4', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (64, N'Test Ana Yemek 5', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (65, N'Test Ana Yemek 6', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (66, N'Test Ana Yemek 7', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (67, N'Test Ana Yemek 8', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (68, N'Test Ana Yemek 9', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (69, N'Test Ana Yemek 10', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (70, N'Test Ana Yemek 11', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (71, N'Test Ana Yemek 12', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (72, N'Test Ana Yemek 13', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (73, N'Test Ana Yemek 14', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (74, N'Test Ana Yemek 15', 125.00, N'Et, Pilav, Sebze, Test', N'/images/breakfast-1.jpg', 3, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (75, N'Test İçecek 1', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (76, N'Test İçecek 2', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (77, N'Test İçecek 3', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (78, N'Test İçecek 4', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (79, N'Test İçecek 5', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (80, N'Test İçecek 6', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (81, N'Test İçecek 7', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (82, N'Test İçecek 8', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (83, N'Test İçecek 9', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (84, N'Test İçecek 10', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (85, N'Test İçecek 11', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (86, N'Test İçecek 12', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (87, N'Test İçecek 13', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (88, N'Test İçecek 14', 20.00, N'Soğuk/Sıcak, Test Karışım', N'/images/dessert-1.jpg', 4, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (89, N'Test İçecek 15', 20.00, N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 0);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (90, N'Test Tatlı 1', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (91, N'Test Tatlı 2', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (92, N'Test Tatlı 3', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (93, N'Test Tatlı 4', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (94, N'Test Tatlı 5', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (95, N'Test Tatlı 6', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (96, N'Test Tatlı 7', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (97, N'Test Tatlı 8', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (98, N'Test Tatlı 9', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (99, N'Test Tatlı 10', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (100, N'Test Tatlı 11', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (101, N'Test Tatlı 12', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (102, N'Test Tatlı 13', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (103, N'Test Tatlı 14', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (104, N'Test Tatlı 15', 60.00, N'Şeker, Çikolata, Meyve, Test', N'/images/drink-1.jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (106, N'jhfvkvfh', 879.00, N'kjnbkjhnbk', N'/ResimlerMenu/images (1).jpg', 5, 1);
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (107, N'asdasd', 15.00, N'asdasdsa', N'/ResimlerMenu/images (1).jpg', 2, 1);
SET IDENTITY_INSERT [dbo].[URUNLER] OFF;
GO
SET IDENTITY_INSERT [dbo].[USTILETISIM] ON;
INSERT [dbo].[USTILETISIM] ([UstID], [Telefon], [Mail], [AcilisKapanis], [Facebook], [Instagram], [Twitter], [Linkedin], [Durum]) VALUES (1, N'+90 555 000 00 00', N'info@molyrs.com', N'Pzt - Cum / 9:00-21:00, Cmt - Paz / 10:00-20:00', N'fb.com/tasteit', N'ig.com/tasteit', N'tw.com/tasteit', NULL, 1);
SET IDENTITY_INSERT [dbo].[USTILETISIM] OFF;
GO
SET IDENTITY_INSERT [dbo].[YORUMLAR] ON;
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (1, N'John Gustavo', N'john@mail.com', CAST(N'2026-02-15' AS Date), N'Çok uzaklarda, kelime dağlarının arkasında kör metinler yaşar.', 0);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (2, N'Sena Yüce', N'sena@mail.com', CAST(N'2026-02-15' AS Date), N'Hizmet ve yemekler harikaydı, herkese tavsiye ederim.', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (3, N'Ali Vural', N'ali@mail.com', CAST(N'2026-02-15' AS Date), N'Mekan çok şık, özellikle bahçe kısmına bayıldım.', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (4, N'Merve Tekin', N'merve@mail.com', CAST(N'2026-02-15' AS Date), N'Fiyat performans olarak bölgedeki en iyi restoran.', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (5, N'Bora Işık', N'bora@mail.com', CAST(N'2026-02-15' AS Date), N'Tatlılar gerçekten efsane, özellikle sufleyi denemelisiniz.', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (8, N'Emrah Çpkan', N'emrah@mail.com', CAST(N'2026-02-20' AS Date), N'Tatlılar Çok Güzeldi.', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (9, N'Ahmet Çakar', N'qwewqeqw@mail.com', CAST(N'2026-02-24' AS Date), N'wqeqweqweqwewqewq', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (11, N'wewqewqeq', N'qweqwe@mail.com', CAST(N'2026-02-26' AS Date), N'qwewqeqw', 1);
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (12, N'Adahan karadeniz', N'nahada@gmail.com', CAST(N'2026-04-08' AS Date), N'KomtanLogar', 1);
SET IDENTITY_INSERT [dbo].[YORUMLAR] OFF;
GO

/* ------------------------- DEMO KULLANICILAR ------------------------- */
SET IDENTITY_INSERT [dbo].[UYELER] ON;
INSERT [dbo].[UYELER] ([UyeID], [AdSoyad], [Mail], [Sifre], [Yetki], [SozlesmeOnay], [KayitTarihi], [Durum]) VALUES (1, N'Admin', N'admin@molyrs.com', N'Admin123!', N'Admin', 1, CAST(GETDATE() AS Date), 1);
INSERT [dbo].[UYELER] ([UyeID], [AdSoyad], [Mail], [Sifre], [Yetki], [SozlesmeOnay], [KayitTarihi], [Durum]) VALUES (2, N'Demo Uye', N'uye@molyrs.com', N'Uye123!', N'Uye', 1, CAST(GETDATE() AS Date), 1);
SET IDENTITY_INSERT [dbo].[UYELER] OFF;
GO

/* ------------------------- YABANCI ANAHTARLAR ------------------------- */
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI]  WITH CHECK ADD  CONSTRAINT [FK_DUYURUBLOGYORUMLARI_DUYURULABLOGLAR] FOREIGN KEY([DuyuruID])
REFERENCES [dbo].[DUYURULABLOGLAR] ([DuyuruID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] CHECK CONSTRAINT [FK_DUYURUBLOGYORUMLARI_DUYURULABLOGLAR]
GO
ALTER TABLE [dbo].[REZARVASYONLAR]  WITH CHECK ADD FOREIGN KEY([DurumID])
REFERENCES [dbo].[REZARVASYONDURUM] ([DurumID])
GO
ALTER TABLE [dbo].[REZARVASYONLAR]  WITH CHECK ADD  CONSTRAINT [FK__REZARVASY__MasaI__5441852A] FOREIGN KEY([MasaID])
REFERENCES [dbo].[MASALAR] ([MasaID])
GO
ALTER TABLE [dbo].[REZARVASYONLAR] CHECK CONSTRAINT [FK__REZARVASY__MasaI__5441852A]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA]  WITH CHECK ADD FOREIGN KEY([UyeID])
REFERENCES [dbo].[UYELER] ([UyeID])
GO
ALTER TABLE [dbo].[URUNLER]  WITH CHECK ADD FOREIGN KEY([KategoriID])
REFERENCES [dbo].[KATEGORILER] ([KategoriID])
GO

SET NOEXEC OFF;
GO
