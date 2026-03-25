USE [WRestourantDB]
GO
ALTER TABLE [dbo].[URUNLER] DROP CONSTRAINT [FK__URUNLER__Kategor__4CA06362]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] DROP CONSTRAINT [FK__SIFRE_SIF__UyeID__2FCF1A8A]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] DROP CONSTRAINT [FK__REZARVASY__MasaI__5441852A]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] DROP CONSTRAINT [FK__REZARVASY__Durum__571DF1D5]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] DROP CONSTRAINT [FK_DUYURUBLOGYORUMLARI_DUYURULABLOGLAR]
GO
ALTER TABLE [dbo].[YORUMLAR] DROP CONSTRAINT [DF__YORUMLAR__Durum__5EBF139D]
GO
ALTER TABLE [dbo].[YORUMLAR] DROP CONSTRAINT [DF__YORUMLAR__Tarih__5DCAEF64]
GO
ALTER TABLE [dbo].[UYELER] DROP CONSTRAINT [DF__UYELER__Durum__2CF2ADDF]
GO
ALTER TABLE [dbo].[UYELER] DROP CONSTRAINT [DF__UYELER__KayitTar__2BFE89A6]
GO
ALTER TABLE [dbo].[UYELER] DROP CONSTRAINT [DF__UYELER__Sozlesme__2B0A656D]
GO
ALTER TABLE [dbo].[UYELER] DROP CONSTRAINT [DF__UYELER__Yetki__2A164134]
GO
ALTER TABLE [dbo].[USTILETISIM] DROP CONSTRAINT [DF__USTILETIS__Durum__656C112C]
GO
ALTER TABLE [dbo].[URUNLER] DROP CONSTRAINT [DF__URUNLER__Durum__4D94879B]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] DROP CONSTRAINT [DF__SIFRE_SIF__Kulla__31B762FC]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] DROP CONSTRAINT [DF__SIFRE_SIF__Olust__30C33EC3]
GO
ALTER TABLE [dbo].[SEFLER] DROP CONSTRAINT [DF__SEFLER__Durum__5AEE82B9]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] DROP CONSTRAINT [DF__REZARVASY__Durum__5812160E]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] DROP CONSTRAINT [DF__REZARVASYO__Saat__5629CD9C]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] DROP CONSTRAINT [DF__REZARVASY__Tarih__5535A963]
GO
ALTER TABLE [dbo].[NAVBAR] DROP CONSTRAINT [DF__NAVBAR__Durum__1AD3FDA4]
GO
ALTER TABLE [dbo].[NAVBAR] DROP CONSTRAINT [DF__NAVBAR__Sira__19DFD96B]
GO
ALTER TABLE [dbo].[ICERIKLER] DROP CONSTRAINT [DF__ICERIKLER__Durum__3D2915A8]
GO
ALTER TABLE [dbo].[ICERIKLER] DROP CONSTRAINT [DF__ICERIKLER__Tarih__3C34F16F]
GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] DROP CONSTRAINT [DF__DUYURULAB__Durum__628FA481]
GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] DROP CONSTRAINT [DF__DUYURULAB__Tarih__619B8048]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] DROP CONSTRAINT [DF__DUYURUBLO__Durum__6D0D32F4]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] DROP CONSTRAINT [DF__DUYURUBLO__Tarih__6C190EBB]
GO
ALTER TABLE [dbo].[ANASAYFA] DROP CONSTRAINT [DF__ANASAYFA__Durum__68487DD7]
GO
/****** Object:  Index [UQ__UYELER__2724B2D1F73DE3CB]    Script Date: 25.03.2026 18:54:24 ******/
ALTER TABLE [dbo].[UYELER] DROP CONSTRAINT [UQ__UYELER__2724B2D1F73DE3CB]
GO
/****** Object:  Table [dbo].[YORUMLAR]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YORUMLAR]') AND type in (N'U'))
DROP TABLE [dbo].[YORUMLAR]
GO
/****** Object:  Table [dbo].[UYELER]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UYELER]') AND type in (N'U'))
DROP TABLE [dbo].[UYELER]
GO
/****** Object:  Table [dbo].[USTILETISIM]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USTILETISIM]') AND type in (N'U'))
DROP TABLE [dbo].[USTILETISIM]
GO
/****** Object:  Table [dbo].[URUNLER]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[URUNLER]') AND type in (N'U'))
DROP TABLE [dbo].[URUNLER]
GO
/****** Object:  Table [dbo].[SITE_AYARLARI]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SITE_AYARLARI]') AND type in (N'U'))
DROP TABLE [dbo].[SITE_AYARLARI]
GO
/****** Object:  Table [dbo].[SIFRE_SIFIRLAMA]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SIFRE_SIFIRLAMA]') AND type in (N'U'))
DROP TABLE [dbo].[SIFRE_SIFIRLAMA]
GO
/****** Object:  Table [dbo].[SEFLER]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SEFLER]') AND type in (N'U'))
DROP TABLE [dbo].[SEFLER]
GO
/****** Object:  Table [dbo].[REZARVASYONLAR]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REZARVASYONLAR]') AND type in (N'U'))
DROP TABLE [dbo].[REZARVASYONLAR]
GO
/****** Object:  Table [dbo].[REZARVASYONDURUM]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REZARVASYONDURUM]') AND type in (N'U'))
DROP TABLE [dbo].[REZARVASYONDURUM]
GO
/****** Object:  Table [dbo].[NAVBAR]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NAVBAR]') AND type in (N'U'))
DROP TABLE [dbo].[NAVBAR]
GO
/****** Object:  Table [dbo].[MASALAR]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MASALAR]') AND type in (N'U'))
DROP TABLE [dbo].[MASALAR]
GO
/****** Object:  Table [dbo].[KATEGORILER]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KATEGORILER]') AND type in (N'U'))
DROP TABLE [dbo].[KATEGORILER]
GO
/****** Object:  Table [dbo].[ICERIKLER]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ICERIKLER]') AND type in (N'U'))
DROP TABLE [dbo].[ICERIKLER]
GO
/****** Object:  Table [dbo].[HAKKIMDA]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HAKKIMDA]') AND type in (N'U'))
DROP TABLE [dbo].[HAKKIMDA]
GO
/****** Object:  Table [dbo].[DUYURULABLOGLAR]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DUYURULABLOGLAR]') AND type in (N'U'))
DROP TABLE [dbo].[DUYURULABLOGLAR]
GO
/****** Object:  Table [dbo].[DUYURUBLOGYORUMLARI]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DUYURUBLOGYORUMLARI]') AND type in (N'U'))
DROP TABLE [dbo].[DUYURUBLOGYORUMLARI]
GO
/****** Object:  Table [dbo].[ANASAYFA]    Script Date: 25.03.2026 18:54:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ANASAYFA]') AND type in (N'U'))
DROP TABLE [dbo].[ANASAYFA]
GO
/****** Object:  Table [dbo].[ANASAYFA]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[DUYURUBLOGYORUMLARI]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[DUYURULABLOGLAR]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[HAKKIMDA]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[ICERIKLER]    Script Date: 25.03.2026 18:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICERIKLER](
	[IcerikID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](255) NOT NULL,
	[Tarih] [date] NULL,
	[IcerikMetni] [nvarchar](max) NOT NULL,
	[Dosya] [nvarchar](max) NULL,
	[Durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IcerikID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KATEGORILER]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[MASALAR]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[NAVBAR]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[REZARVASYONDURUM]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[REZARVASYONLAR]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[SEFLER]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[SIFRE_SIFIRLAMA]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[SITE_AYARLARI]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[URUNLER]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[USTILETISIM]    Script Date: 25.03.2026 18:54:24 ******/
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
/****** Object:  Table [dbo].[UYELER]    Script Date: 25.03.2026 18:54:24 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YORUMLAR]    Script Date: 25.03.2026 18:54:24 ******/
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
SET IDENTITY_INSERT [dbo].[ANASAYFA] ON 
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (1, N'/images/bg_1.jpg', N'MolyRS Restoran', N'Kalitenin Tek Adresi', N'1915'' ten beri..', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (4, N'/images/bg_2.jpg', N'MolyRS Restoran', N'En İyi Kalite', N'Yemekler', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (6, N'/images/bg_3.jpg', N'MolyRs Restoran', N'Uzman Kadro', N'Personel', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (8, N'/images/gallery-7.jpg', N'MolyRS Restoran', N'Kaliteli Vakit', N'Kaliteli Zaman', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (9, N'/images/d074ad09-5504-487f-a3ee-6abbf66331b6.jpg', N'MolyRS Restoran', N'qwwwwwwwwE', N'qweqweqweqwweqeqweqwıadsadas', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (10, N'/images/bf4e3d7a-e85b-4485-9aca-251785895c8b.jpg', N'MolyRS Restoran', N'wqewqasd', N'qeqeqeq', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (11, N'/images/521effb1-553f-46c6-b627-1e57cb4ded85.jpg', N'MolyRS Restoran', N'qweqwe', N'qweqweqw', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (12, N'/images/bg_3.jpg', N'MolyRS Restoran', N'icerik', N'<p></p><pre><p></p><p></p><ul><li><span style="color: rgb(255, 0, 0);">İçerik werwerewrew</span></li></ul></pre><p></p>', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (15, N'/images/cb44a6b3-88b0-4a4d-bf01-1adda7622f2d.jpg', N'MolyRS Restoran', N'qwq', N'<p style="line-height: 1.5; margin-block: 1em; color: rgb(32, 33, 36); font-family: Arial, sans-serif; letter-spacing: normal;"><strong>Makale</strong>, herhangi bir konu hakkında&nbsp;<strong>bilgi vermek, açıklamak veya bir görüşü savunmak amacıyla yazılan düşünce yazısıdır.</strong>&nbsp;Gazete, dergi, blog veya akademik yayınlarda yayımlanabilir. ✍️</p><div><br></div>', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (16, N'/images/40e71e75-7a6e-4cc9-a8e5-63b8637ba6e4.jpg', N'<p><span style="color: rgb(255, 0, 0);">MolyRS Restoran</span></p>', N'<p><span style="font-weight: bold; font-style: italic; text-decoration-line: underline;">İçerik&nbsp;</span></p>', N'<p>asdasdasdasda</p>', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (17, N'/images/13c8dcc4-9997-4b73-9fa6-0e306a959eb1.jpg', N'<font color="#ff0000"><b>MolyRS Restoran</b></font>', N'<b><u>wqeqwewq</u></b>', N'<b><u>qweqweqweqweqww</u></b>', 1)
GO
INSERT [dbo].[ANASAYFA] ([AnasayfaID], [Resim], [Baslik], [Icerik], [Aciklama], [Durum]) VALUES (18, N'/images/5a1a5356-36d4-45a8-b342-d8c453a69134.jpg', N'<p><font color="#ff0000"><i><u>Başlık</u></i></font></p>', N'<p><i style=""><u style=""><b>adasdasdas</b></u></i></p>', N'<p>qeqweeqweqeqwe</p>', 1)
GO
SET IDENTITY_INSERT [dbo].[ANASAYFA] OFF
GO
SET IDENTITY_INSERT [dbo].[DUYURUBLOGYORUMLARI] ON 
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (2, 2, N'Yusuf Erdoğan', N'yusuf@gmail.com', CAST(N'2025-10-10T00:00:00.000' AS DateTime), N'Tatlı Çok Güzeldi ', 5, 1)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (3, 3, N'Mustafa Altın', N'mıstk@gmail.com', CAST(N'2026-10-10T00:00:00.000' AS DateTime), N'Tek Tercihimiz', 5, 1)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (4, 4, N'Eyşan Mutlu', N'eysan@gmail.com', CAST(N'2026-10-10T00:00:00.000' AS DateTime), N'Rezervasyon Sistemi Çok Başarlı Olmuş', 4, 1)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (5, 1, N'wqeq', N'wqewqewq@mail.com', CAST(N'2026-02-26T21:27:45.327' AS DateTime), N'qwewqeqw', 4, 1)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (6, 2, N'qwewqe', N'qwewqeq@mail.com', CAST(N'2026-02-26T22:01:43.117' AS DateTime), N'wqeqw', 4, 0)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (8, 2, N'asdasda', N'sdsadsa@mail.com', CAST(N'2026-03-04T20:32:14.447' AS DateTime), N'werfwr', 5, 0)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (9, 7, N'qweqwewq', N'qweqweqwewq@mail.com', CAST(N'2026-03-05T00:41:48.080' AS DateTime), N'qeqweqwewqewqe', 5, 0)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (10, 6, N'qwqeqwewq', N'qweqwewq@mail.com', CAST(N'2026-03-06T14:25:48.197' AS DateTime), N'qweqweqw', 4, 0)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (12, 1, N'qweqwe', N'qweqwew@mail.com', CAST(N'2026-03-10T20:06:05.947' AS DateTime), N'qwewwqeqw', 5, 0)
GO
INSERT [dbo].[DUYURUBLOGYORUMLARI] ([YorumID], [DuyuruID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Yildiz], [Durum]) VALUES (13, 1, N'qweqwe', N'wqeqweqw@mail.com', CAST(N'2026-03-20T21:27:26.150' AS DateTime), N'wqeqweqw', 4, 1)
GO
SET IDENTITY_INSERT [dbo].[DUYURUBLOGYORUMLARI] OFF
GO
SET IDENTITY_INSERT [dbo].[DUYURULABLOGLAR] ON 
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (1, N'Yeni Menümüz Hazırr', N'Şeflerimizin özenle hazırladığı yeni lezzetleri keşfedin...', CAST(N'2026-02-15' AS Date), N'/images/insta-2.jpg', N'Admin', 36, 65, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (2, N'Hafta Sonu Kampanyası', N'Cumartesi günleri tüm tatlılarda %20 indirim.', CAST(N'2026-02-15' AS Date), N'/images/image_2.jpg', N'Admin', 2, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (3, N'En İyi Restoran Ödülü', N'Bu yıl da şehrin en lezzetli durağı seçildik.', CAST(N'2026-02-15' AS Date), N'/images/image_3.jpg', N'Admin', 1, 1, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (4, N'Vegan Seçenekler', N'<b>Artık menümüzde sağlıklı vegan alternatifler de var.</b>', CAST(N'2026-02-15' AS Date), N'/images/image_1.jpg', N'Admin', NULL, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (5, N'Rezervasyon Kolaylığı', N'Online rezervasyon sistemimiz artık aktif.', CAST(N'2027-10-10' AS Date), N'/images/image_2.jpg', N'Admin', 6, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (6, N'Mekanımız Yenilendi', N'qweqwewqeqweqwewqewq&nbsp;', CAST(N'2026-03-05' AS Date), N'/images/gallery-3.jpg', N'Admin', NULL, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (7, N'qwewqeqwe', N'qweqweqweqweqweqwsadasdas', CAST(N'2026-03-05' AS Date), N'/images/gallery-6.jpg', N'Admin', 14, 1, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (8, N'qwewq', N'wqeqweqw', CAST(N'2026-03-05' AS Date), N'/images/breakfast-7.jpg', N'Admin', NULL, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (11, N'qweqwe', N'<ul><li><b><i><u><font color="#ff0000">silinecekkk:DDDDDDDDDDDDDDDDasdsa</font></u></i></b></li></ul>', CAST(N'2026-03-10' AS Date), N'/images/9f7e2005-breakfast-1.jpg', N'eqweqwewqe', 1, NULL, 1)
GO
INSERT [dbo].[DUYURULABLOGLAR] ([DuyuruID], [Baslik], [Icerik], [Tarih], [Resim], [Yazar], [Goruntulenme], [Begeni], [Durum]) VALUES (12, N'<p>asdasdas</p>', N'<ul class="post-categories" style="box-sizing: border-box; list-style: none; padding: 0px; margin: 0px; display: inline-block;"><li style="box-sizing: inherit; padding: 0px; margin: 0px; display: inline-block;"><a href="https://toguhaber.gop.edu.tr/kategori/kampus" rel="category tag" style="box-sizing: inherit; background-color: transparent; color: rgb(6, 90, 173); text-decoration: none; transition: 0.2s; border-color: rgb(10, 113, 192); text-transform: uppercase; padding: 0px 5px;">KAMPÜS</a></li></ul><p><span class="cat-links" style="box-sizing: inherit; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);">&nbsp;</span><span class="posted-on mt-clearfix" itemprop="datePublished" style="box-sizing: inherit; position: relative; margin-left: 64px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><a href="https://toguhaber.gop.edu.tr/h/11796" rel="bookmark" style="box-sizing: inherit; color: rgb(136, 136, 136); transition: 0.2s; border-color: rgb(10, 113, 192); font-size: 14px;">25 Mart 2026</a></span><span style="color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"></span></p><div class="entry-thumbnail single-entry-thumbnail mt-clearfix" style="box-sizing: inherit; margin: 30px 0px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><figure class="post-thumb cover-image" style="margin-bottom: 0px; box-sizing: inherit; line-height: 0; position: relative;"><img width="1600" height="1066" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg" class="attachment-full size-full wp-post-image" alt="Rektörümüzden TOGÜ ŞİFA Merkezine Ziyaret" itemprop="image" decoding="async" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg 1600w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-1536x1023.jpeg 1536w" sizes="(max-width: 1600px) 100vw, 1600px" style="box-sizing: inherit; height: 559.65px; max-width: 100%; width: 840px; object-fit: cover;"></figure></div><div class="entry-meta single-entry-meta" style="box-sizing: inherit; display: flex; justify-content: space-between; align-items: center; padding-bottom: 25px; border-bottom: 1px solid rgb(204, 204, 204); color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; text-align: center; background-color: rgb(249, 249, 249);"><div class="entry-meta-posted-by posted-by-wrap" style="box-sizing: inherit; display: flex; align-items: center;"><span class="byline" style="box-sizing: inherit;"><span class="author vcard" style="box-sizing: inherit;"><a class="url fn n" href="https://toguhaber.gop.edu.tr/h/author/kurumsaliletisim" style="box-sizing: inherit; color: rgb(51, 51, 51); transition: 0.2s; border-color: rgb(10, 113, 192); font-weight: 600;">Kurumsal İletişim Koordinatörlüğü</a></span></span></div><div class="entry-meta-comment comment-mark" style="box-sizing: inherit;"></div><div class="post-views content-post post-11796 entry-meta load-static" style="box-sizing: inherit; line-height: 1.3;"><span class="post-views-label" style="box-sizing: inherit; margin-right: 0px !important; padding-right: 5px; cursor: pointer;"><span class="dashicons dashicons-share" title="Paylaş" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>Paylaş</span>&nbsp;<span class="post-views-count" style="box-sizing: inherit; margin-right: 0px !important; font-weight: bold;"><span class="dashicons dashicons-visibility" style="box-sizing: inherit; font-family: dashicons; display: inline-block; line-height: 1; font-weight: 400; text-decoration: inherit; text-rendering: auto; -webkit-font-smoothing: antialiased; width: 20px; height: 20px; font-size: 20px; vertical-align: top; transition: color 0.1s ease-in;"></span>81</span></div></div><div class="entry-content single-entry-summary mt-clearfix" itemprop="text" style="box-sizing: inherit; counter-reset: footnotes 0; margin: 1.5rem 0px 30px; color: rgb(61, 61, 61); font-family: Muli; font-size: 16px; letter-spacing: normal; background-color: rgb(249, 249, 249);"><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Rektörümüz Prof. Dr. Fatih Yılmaz, Üniversitemiz bünyesinde faaliyet gösteren TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezini ziyaret ederek yürütülen çalışmaları yerinde inceledi. Ziyarete Rektör yardımcıları, Genel Sekreter ve Rektör Danışmanları da eşlik etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Bitkisel Ürün Geliştirmede Öncü Merkez</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Üniversitemiz Eczacılık Fakültesi tarafından kurulan TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezi, bitkisel kaynaklı sağlık ürünlerinin geliştirilmesi, analiz edilmesi ve pilot ölçekte üretimi amacıyla faaliyetlerini sürdürüyor. Merkez, bilimsel araştırmalar ile üretim süreçlerini bir araya getirerek sektöre önemli katkılar sunmayı hedefliyor.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Rektör Yılmaz: “Uygulamalı Eğitim Vizyonumuza Katkı Sağlıyor”</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Ziyaret kapsamında merkezde yürütülen çalışmalar hakkında bilgi alan Rektörümüz Prof. Dr. Fatih Yılmaz, projenin önemine dikkat çekti. Üniversitemizin “üreten üniversite” ve uygulamalı eğitim vizyonuna vurgu yapan Rektörümüz, merkezin hem öğrenciler hem de araştırmacılar için önemli fırsatlar sunduğunu ifade etti.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Geniş Kapsamlı Analiz ve Ar-Ge Hizmeti</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">Merkezde gerçekleştirilen çalışmalar kapsamında; kremler ve benzeri kozmetik ürünler ile sağlığa faydalı çaylar üretiliyor. TOGÜ Şifa’da üretilen Bağışıklık Çayı’ndan tadan Rektörümüz Prof. Dr. Fatih Yılmaz, üretilen kremi de inceledi. Merkezde ayrıca, Dünya Sağlık Örgütü onaylı formülasyona sahip dezenfektanlar üretilirken, bu ürünlere yöresel kokular eklenerek özgün bir nitelik kazandırılıyor. Bununla birlikte bitkisel hammaddelerin ekstraksiyonu ve standardizasyonu, uçucu yağ ve etken madde analizleri (GC-MS, LC-MS/MS) ile pestisit, ağır metal ve mikrobiyolojik kalite testleri de gerçekleştiriliyor. Yürütülen bu çalışmalarla birlikte merkez, üreticilere kapsamlı analiz hizmeti sunarken Ar-Ge faaliyetlerine de önemli katkı sağlıyor.</p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;"><span style="box-sizing: inherit; font-weight: bolder;">Eğitim ve Araştırmanın Buluşma Noktası</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; padding: 0px; line-height: 1.8; line-break: auto; text-align: justify;">TOGÜ ŞİFA Pilot Üretim ve Analiz Merkezi, Eczacılık Fakültesi’nin akademik altyapısıyla entegre bir şekilde faaliyet göstererek aynı zamanda bir eğitim üssü olarak hizmet veriyor. Merkez, öğrencilerin uygulamalı eğitim süreçlerine katkı sağlarken, araştırmacılar için de nitelikli bir çalışma ortamı sunuyor.</p><figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-2 is-layout-flex wp-block-gallery-is-layout-flex" style="margin-top: 1em; margin-bottom: 30px; box-sizing: inherit; gap: 8px; flex-wrap: wrap; align-items: normal; display: flex; --wp--style--unstable-gallery-gap: 0.5em; text-align: center; justify-content: center;"><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11798" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-901x600.jpeg" alt="" class="wp-image-11798" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/1-18.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11799" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-901x600.jpeg" alt="" class="wp-image-11799" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/2-19.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11797" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-901x600.jpeg" alt="" class="wp-image-11797" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/3-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11801" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-901x600.jpeg" alt="" class="wp-image-11801" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/4-18.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.675px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11800" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-901x600.jpeg" alt="" class="wp-image-11800" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/5-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.675px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 182.938px; object-fit: cover; width: 274.663px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11802" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-901x600.jpeg" alt="" class="wp-image-11802" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/6-17.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 182.938px; max-width: 100%; vertical-align: bottom; display: block; width: 274.663px; flex: 1 0 0%; object-fit: cover;"></a></figure><figure class="wp-block-image size-large" style="margin-bottom: 0px; justify-content: center; display: flex; flex-direction: column; flex-grow: 1; max-width: 100%; position: relative; width: calc(33.33% - 5.33336px); align-self: inherit;"><a href="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg" style="box-sizing: inherit; color: rgb(10, 113, 192); transition: 0.2s; border-color: rgb(10, 113, 192); display: flex; flex-direction: column; flex: 1 0 0%; margin: 0px; height: 559.65px; object-fit: cover; width: 840px;"><img loading="lazy" decoding="async" width="901" height="600" data-id="11803" src="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg" alt="" class="wp-image-11803" srcset="https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-901x600.jpeg 901w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-450x300.jpeg 450w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-225x150.jpeg 225w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-768x512.jpeg 768w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16-1536x1023.jpeg 1536w, https://toguhaber.gop.edu.tr/wp-content/uploads/sites/7/2026/03/7-16.jpeg 1600w" sizes="(max-width: 901px) 100vw, 901px" style="height: 559.65px; max-width: 100%; vertical-align: bottom; display: block; width: 840px; flex: 1 0 0%; object-fit: cover;"></a></figure></figure></div>', CAST(N'2026-03-25' AS Date), N'/images/d7385fb1-Ekran görüntüsü 2025-09-05 092320.png', N'admin', 22, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[DUYURULABLOGLAR] OFF
GO
SET IDENTITY_INSERT [dbo].[HAKKIMDA] ON 
GO
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (1, N'/images/5397fc84-about.jpg', N'MOLYRS''E HOŞGELDİNİZ', N'Yusuf, Emrah ve Gencay’ın yolları, gastronomiye olan ortak tutkularıyla kesişti. Yusuf''un geleneksel mutfak ustalığı, Emrah''ın modern vizyonu ve Gencay''ın teknoloji odaklı kusursuz işletme zekası bir araya gelerek Moly RS''in temellerini oluşturdu. Küçük bir mutfakta başlayan bu serüven, kısa sürede şehrin en prestijli lezzet duraklarından birine dönüştü. Bugün misafirlerimize sunulan her tabakta bu eşsiz üçlünün tecrübesini, sanatını ve vizyonunu hissetmek mümkün. Moly RS, sadece bir restoran değil; dostluğun ve azmin yazdırdığı yaşayan bir başarı hikayesidir. Bizim en büyük sırrımız mutfağımızdaki tariflerde değil, işte bu sarsılmaz ekip ruhunda gizlidir."')
GO
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (3, N'/images/yceo.png', N'Yusuf Erdoğan', N'Geleneksel lezzetleri modern dokunuşlarla harmanlayan usta şefimiz. Yılların getirdiği mutfak tecrübesiyle, misafirlerimize her tabakta unutulmaz ve imza bir lezzet şöleni sunuyor..')
GO
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (4, N'/images/eceo.png', N'Emrah Çapkan', N'Dünya mutfağının dinamik ve yenilikçi tatlarını menümüze taşıyan vizyoner kurucumuz. Cesur tarifleri, sıradışı malzeme kombinasyonları ve sunum sanatıyla yemek yemeyi sanatsal bir deneyime dönüştürüyor.')
GO
INSERT [dbo].[HAKKIMDA] ([HakkimdaID], [Resim], [Baslik], [Icerik]) VALUES (5, N'/images/gceo.png', N'Gencay Çeliker', N'Restoranımızın kusursuz işleyişini, misafir memnuniyetini ve teknolojik altyapısını yöneten operasyon beyni. Moly RS''in modern yüzünü temsil ediyor ve her detayın mükemmel olmasını sağlıyor.')
GO
SET IDENTITY_INSERT [dbo].[HAKKIMDA] OFF
GO
SET IDENTITY_INSERT [dbo].[KATEGORILER] ON 
GO
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (1, N'Kahvaltı', N'/images/breakfast-icon.png')
GO
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (2, N'Öğle Yemeği', N'/images/lunch-icon.png')
GO
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (3, N'Akşam Yemeği', N'/images/dinner-icon.png')
GO
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (4, N'Tatlılar', N'/images/dessert-icon.png')
GO
INSERT [dbo].[KATEGORILER] ([KategoriID], [KategoriAd], [Resim]) VALUES (5, N'İçecekler', N'/images/drink-icon.png')
GO
SET IDENTITY_INSERT [dbo].[KATEGORILER] OFF
GO
SET IDENTITY_INSERT [dbo].[MASALAR] ON 
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (1, 1, 2, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (2, 2, 3, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (3, 3, 4, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (4, 4, 5, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (5, 5, 6, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (6, 6, 7, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (7, 7, 8, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (8, 8, 9, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (9, 9, 10, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (10, 10, 15, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (11, 11, 13, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (12, 12, 12, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (13, 13, 11, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (14, 14, 4, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (15, 15, 6, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (16, 16, 8, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (17, 17, 5, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (18, 18, 3, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (19, 19, 2, 0)
GO
INSERT [dbo].[MASALAR] ([MasaID], [MasaNo], [Kapasite], [Durum]) VALUES (20, 20, 20, 0)
GO
SET IDENTITY_INSERT [dbo].[MASALAR] OFF
GO
SET IDENTITY_INSERT [dbo].[NAVBAR] ON 
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (1, N'Anasayfa', N'/', 1, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (2, N'Hakkımızda', N'/hakkimizda', 2, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (3, N'Menüler', N'/menuler', 3, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (4, N'Rezervasyon', N'/rezervasyon', 4, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (5, N'Şefimiz', N'/sefimiz', 5, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (6, N'Blog', N'/blog', 6, 1)
GO
INSERT [dbo].[NAVBAR] ([NavbarID], [MenuAd], [Link], [Sira], [Durum]) VALUES (7, N'İletişim', N'/iletisim', 7, 1)
GO
SET IDENTITY_INSERT [dbo].[NAVBAR] OFF
GO
SET IDENTITY_INSERT [dbo].[REZARVASYONDURUM] ON 
GO
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (1, N'Beklemede')
GO
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (2, N'Onaylandı')
GO
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (3, N'İptal Edildi')
GO
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (4, N'Tamamlandı')
GO
INSERT [dbo].[REZARVASYONDURUM] ([DurumID], [DurumAd]) VALUES (5, N'Gelmedi')
GO
SET IDENTITY_INSERT [dbo].[REZARVASYONDURUM] OFF
GO
SET IDENTITY_INSERT [dbo].[REZARVASYONLAR] ON 
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (2, NULL, N'ewqewq', N'qwwqeq@gmail.com', N'12345678912', CAST(N'2026-02-17' AS Date), CAST(N'13:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (3, NULL, N'Gencay Çeliker', N'gencay@gmail.com', N'05384525750', CAST(N'2026-02-18' AS Date), CAST(N'10:00:00' AS Time), 5, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (4, NULL, N'qweqwe', N'qeqweqwe@gmail.co', N'1231212', CAST(N'2026-02-15' AS Date), CAST(N'10:30:00' AS Time), 8, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (5, NULL, N'Gencay', N'qweqweq@gmail.com', N'12345678911', CAST(N'2026-02-17' AS Date), CAST(N'10:00:00' AS Time), 4, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (6, NULL, N'hgf', N'ddfg@gmail.com', N'345345', CAST(N'2026-02-19' AS Date), CAST(N'09:30:00' AS Time), 5, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (7, NULL, N'yjdghj', N'dht@gmail.com', N'42', CAST(N'2026-02-25' AS Date), CAST(N'09:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (8, NULL, N'rgsdrh', N'rdg@gmail.com', N'24', CAST(N'2026-02-26' AS Date), CAST(N'10:00:00' AS Time), 3, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (9, NULL, N'fngdf', N'drhg@gmail.com', N'34', CAST(N'2026-02-21' AS Date), CAST(N'10:00:00' AS Time), 3, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (10, NULL, N'dhtsfg', N'fsgfh@gmail.com', N'234', CAST(N'2026-02-26' AS Date), CAST(N'09:30:00' AS Time), 3, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (11, NULL, N'ghıljl', N'gfh@gmail.com', N'324', CAST(N'2026-02-19' AS Date), CAST(N'10:30:00' AS Time), 3, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (12, NULL, N'ıhfgdh', N'jhsd@gmail.com', N'34', CAST(N'2026-02-19' AS Date), CAST(N'09:30:00' AS Time), 3, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (13, NULL, N'fdhj', N'djf@gmail.com', N'2347', CAST(N'2026-02-19' AS Date), CAST(N'09:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (14, 16, N'djhkljdh', N'skjlf@gmail.com', N'234', CAST(N'2026-02-26' AS Date), CAST(N'10:30:00' AS Time), 3, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (15, NULL, N'gfkja', N'fdgad@gmail.com', N'768345', CAST(N'2026-02-26' AS Date), CAST(N'10:00:00' AS Time), 2, 5)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (16, NULL, N'gsdfkjh', N'ardg@gmail.com', N'534', CAST(N'2026-02-17' AS Date), CAST(N'10:30:00' AS Time), 3, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (17, NULL, N'kjdgfkuh', N'fhkjh@gmail.com', N'78654', CAST(N'2026-02-19' AS Date), CAST(N'09:30:00' AS Time), 2, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (18, NULL, N'Mustafa Altınkaynak', N'mustafaaltinkaynak5534@gmail.com', N'05346587845', CAST(N'2026-02-17' AS Date), CAST(N'09:30:00' AS Time), 5, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (19, NULL, N'Kerem Çetin', N'cetinkerem60@gmail.com', N'123456789', CAST(N'2026-02-18' AS Date), CAST(N'11:00:00' AS Time), 2, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (20, NULL, N'Kerem Çetin', N'cetinkerem60@gmail.com', N'12345678912', CAST(N'2026-02-19' AS Date), CAST(N'13:00:00' AS Time), 4, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (21, NULL, N'Yusuf Erdoğan', N'erdogannyusuf@hotmail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'10:00:00' AS Time), 2, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (22, NULL, N'gencay çeliker', N'gencayceliker1@gmail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'21:30:00' AS Time), 4, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (23, NULL, N'Sena Yüce', N'senayuce280280@gmail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'13:30:00' AS Time), 2, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (24, NULL, N'Emrah Çapkan', N'emrahcapkan51@gmail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'13:00:00' AS Time), 4, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (25, 17, N'werwerwe', N'qweqwe@mail.com', N'123456678', CAST(N'2026-02-19' AS Date), CAST(N'10:00:00' AS Time), 5, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (26, 13, N'qwqeqwewq', N'qweqweq@mail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'11:00:00' AS Time), 5, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (27, 15, N'qwewqewq', N'qwewqeq@gmail.com', N'123456789', CAST(N'2026-02-19' AS Date), CAST(N'10:30:00' AS Time), 2, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (28, 17, N'qweqweqwe', N'eqweqw@mail.com', N'213122131231', CAST(N'2026-02-26' AS Date), CAST(N'14:00:00' AS Time), 5, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (29, 17, N'qweqwewq', N'qweqweqw@mail.com', N'12345678912', CAST(N'2026-02-18' AS Date), CAST(N'23:00:00' AS Time), 5, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (30, NULL, N'Semih Çalışkan', N'semihcaliskan1907@gmail.com', N'12345678912', CAST(N'2026-02-19' AS Date), CAST(N'10:00:00' AS Time), 2, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (31, 15, N'Gencay Çeliker', N'gencayceliker@gmail.com', N'12345678912', CAST(N'2026-02-20' AS Date), CAST(N'14:00:00' AS Time), 4, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (32, NULL, N'Emrah Çapkan', N'emrah@gmail.com', N'12345678912', CAST(N'2026-02-21' AS Date), CAST(N'11:00:00' AS Time), 8, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (33, NULL, N'Ali Yabacı', N'ali@gmail.com', N'12345678912', CAST(N'2026-02-21' AS Date), CAST(N'12:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (34, NULL, N'Yusuf Erdoğan', N'yusuf@gmail.com', N'12345678912', CAST(N'2026-02-22' AS Date), CAST(N'11:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (35, 14, N'Gencay Çeliker', N'gencayceliker1@gmail.com', N'12345678912', CAST(N'2026-02-25' AS Date), CAST(N'14:30:00' AS Time), 4, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (36, NULL, N'Mustafa Altınkaynak', N'mustafaaltinkaynak5534@gmail.com', N'12345678912', CAST(N'2026-02-24' AS Date), CAST(N'13:30:00' AS Time), 2, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (37, NULL, N'Emrah Çapkan ', N'emrah@mail.com', N'123456789', CAST(N'2026-02-25' AS Date), CAST(N'10:00:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (38, NULL, N'Gencay Çeliker', N'gencay@mail.com', N'12345567891', CAST(N'2026-02-26' AS Date), CAST(N'14:00:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (39, NULL, N'Ahmet Çakmak', N'ahmet@mail.com', N'12345678912', CAST(N'2026-02-26' AS Date), CAST(N'10:30:00' AS Time), 1, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (40, NULL, N'wqewqqw asd', N'asd@mail.com', N'12345678912', CAST(N'2026-02-26' AS Date), CAST(N'11:00:00' AS Time), 4, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (41, NULL, N'qwewqeq', N'wqewq@mail.com', N'12345678912', CAST(N'2026-02-26' AS Date), CAST(N'13:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (42, NULL, N'qewqewqewq', N'qeqew@gmail.com', N'12345678912', CAST(N'2026-02-26' AS Date), CAST(N'12:30:00' AS Time), 1, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (43, NULL, N'QWEWQEQ', N'QWEQWEWQ@mail.com', N'12345678912', CAST(N'2026-02-27' AS Date), CAST(N'10:00:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (44, NULL, N'weqwewq', N'qweqweq@mail.com', N'123456789', CAST(N'2026-02-26' AS Date), CAST(N'10:30:00' AS Time), 2, 1)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (45, 19, N'wqewqewqe', N'qweqwe@mail.com', N'12345678912', CAST(N'2026-02-27' AS Date), CAST(N'10:30:00' AS Time), 2, 4)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (46, 19, N'WQEWQEQ', N'QWEQWE@gmail.com', N'12345678912', CAST(N'2026-02-27' AS Date), CAST(N'10:30:00' AS Time), 2, 5)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (47, NULL, N'Emirhan Boz', N'emirhanboz3455@gmail.com', N'123456789', CAST(N'2026-02-28' AS Date), CAST(N'10:00:00' AS Time), 2, 3)
GO
INSERT [dbo].[REZARVASYONLAR] ([RezervasyonID], [MasaID], [MusteriAdSoyad], [Mail], [MusteriTelefon], [Tarih], [Saat], [KisiSayisi], [DurumID]) VALUES (48, NULL, N'adadasdas', N'asdasd@mail.com', N'12345678912', CAST(N'2026-03-09' AS Date), CAST(N'10:30:00' AS Time), 5, 1)
GO
SET IDENTITY_INSERT [dbo].[REZARVASYONLAR] OFF
GO
SET IDENTITY_INSERT [dbo].[SEFLER] ON 
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (1, N'images/gceo.png', N'Gencay Çeliker', N'CEO, Kurucu Ortak', N'Kurucu İş Kolik', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (2, N'images/yceo.png', N'Yusuf Erdoğan', N'CEO, Kurucu Ortak', N'Kurucu ', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (3, N'images/eceo.png', N'Emrah Çapkan', N'CEO, Kurucu Ortak', N'Operasyon Müdürü', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (4, N'images/chef-1.jpg', N'Buğrahan Yılmaz', N'Baş Aşçı', N'Izgara ve et pişirme teknikleri ustası', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (5, N'images/chef-4.jpg', N'Lena Valo', N'Sous Chef', N'Mutfak koordinasyonu ve tatlı yönetimi sorumlusu.', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (7, N'images/chef-2.jpg', N'Seda Yüce', N'Şef Aşçı', N'Fransız mutfağı ve sunum sanatında uzman.', 1)
GO
INSERT [dbo].[SEFLER] ([SefID], [Resim], [SefAdSoyad], [Uzmanlik], [Aciklama], [Durum]) VALUES (10, N'images/chef-3.jpg', N'qweqwe', N'wqewqe', N'qweqw', 0)
GO
SET IDENTITY_INSERT [dbo].[SEFLER] OFF
GO
SET IDENTITY_INSERT [dbo].[SITE_AYARLARI] ON 
GO
INSERT [dbo].[SITE_AYARLARI] ([AyarID], [Logo], [SiteAd]) VALUES (1, N'/images/logo.png', N'MolyRS')
GO
SET IDENTITY_INSERT [dbo].[SITE_AYARLARI] OFF
GO
SET IDENTITY_INSERT [dbo].[URUNLER] ON 
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (1, N'Soslu Dana Rosto', CAST(290.00 AS Decimal(18, 2)), N'Dana Eti, Patates, Pirinç, Domates', N'images/breakfast-1.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (2, N'Çikolatalı Sufle', CAST(180.00 AS Decimal(18, 2)), N'Bitter Çikolata, Yumurta, Şeker', N'images/dessert-1.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (3, N'Taze Portakal Suyu', CAST(85.00 AS Decimal(18, 2)), N'Doğal Portakal, Vitaminli, Buzlu', N'images/drink-1.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (4, N'Meyveli Cheesecake', CAST(165.00 AS Decimal(18, 2)), N'Labne, Bisküvi, Mevsim Meyveleri', N'images/dessert-2.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (5, N'Izgara Köfte', CAST(240.00 AS Decimal(18, 2)), N'Dana Kıyma, Baharatlar, Köz Biber', N'images/lunch-1.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (6, N'Serpme Kahvaltı', CAST(200.00 AS Decimal(18, 2)), N'Domates,Yumurta,Patates Kızartması', N'images/breakfast-4.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (12, N'Serpme Kahvaltı', CAST(200.00 AS Decimal(18, 2)), N'Domates,Yumurta,Patates Kızartması', N'images/breakfast-4.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (13, N'Serpme Kahvaltı', CAST(200.00 AS Decimal(18, 2)), N'Domates,Yumurta,Patates Kızarması', N'images/breakfast-4.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (15, N'Soslu Dana Rosto', CAST(290.00 AS Decimal(18, 2)), N'Dana Eti, Patates, Pirinç, Domates', N'images/breakfast-1.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (16, N'Soslu Dana Roso', CAST(290.00 AS Decimal(18, 2)), N'Dana Eti, Patates, Pirinç, Domates', N'images/breakfast-1.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (22, N'Çikolatalı Sufle', CAST(180.00 AS Decimal(18, 2)), N'Bitter Çikolata, Yumurta, Şeker', N'images/dessert-1.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (23, N'Çikolatalı Sufle', CAST(180.00 AS Decimal(18, 2)), N'Bitter Çikolata, Yumurta, Şeker', N'images/dessert-1.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (25, N'Taze Portakal Suyu', CAST(85.00 AS Decimal(18, 2)), N'Doğal Portakal, Vitaminli, Buzlu', N'images/drink-1.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (26, N'Taze Portakal Suyu', CAST(85.00 AS Decimal(18, 2)), N'Doğal Portakal, Vitaminli, Buzlu', N'images/drink-1.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (28, N'Izgara Köfte', CAST(240.00 AS Decimal(18, 2)), N'Dana Kıyma, Baharatlar, Köz Biber', N'images/lunch-1.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (29, N'Izgara Köfte', CAST(240.00 AS Decimal(18, 2)), N'Dana Kıyma, Baharatlar, Köz Biber', N'images/lunch-1.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (30, N'Test Kahvaltı 1', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (31, N'Test Kahvaltı 2', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (32, N'Test Kahvaltı 3', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (33, N'Test Kahvaltı 4', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (34, N'Test Kahvaltı 5', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (35, N'Test Kahvaltı 6', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (36, N'Test Kahvaltı 7', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (37, N'Test Kahvaltı 8', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (38, N'Test Kahvaltı 9', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (39, N'Test Kahvaltı 10', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (40, N'Test Kahvaltı 11', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (41, N'Test Kahvaltı 12', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (42, N'Test Kahvaltı 13', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (43, N'Test Kahvaltı 14', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (44, N'Test Kahvaltı 15', CAST(45.00 AS Decimal(18, 2)), N'Peynir, Zeytin, Test Malzemesi', N'images/menu/default-food.jpg', 1, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (45, N'Test Başlangıç 1', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (46, N'Test Başlangıç 2', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (47, N'Test Başlangıç 3', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (48, N'Test Başlangıç 4', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (49, N'Test Başlangıç 5', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (50, N'Test Başlangıç 6', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (51, N'Test Başlangıç 7', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (52, N'Test Başlangıç 8', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (53, N'Test Başlangıç 9', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (54, N'Test Başlangıç 10', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (55, N'Test Başlangıç 11', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (56, N'Test Başlangıç 12', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (57, N'Test Başlangıç 13', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (58, N'Test Başlangıç 14', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (59, N'Test Başlangıç 15', CAST(35.00 AS Decimal(18, 2)), N'Soslar, Atıştırmalık, Test', N'images/menu/default-food.jpg', 2, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (60, N'Test Ana Yemek 1', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (61, N'Test Ana Yemek 2', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (62, N'Test Ana Yemek 3', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (63, N'Test Ana Yemek 4', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (64, N'Test Ana Yemek 5', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (65, N'Test Ana Yemek 6', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (66, N'Test Ana Yemek 7', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (67, N'Test Ana Yemek 8', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (68, N'Test Ana Yemek 9', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (69, N'Test Ana Yemek 10', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (70, N'Test Ana Yemek 11', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (71, N'Test Ana Yemek 12', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (72, N'Test Ana Yemek 13', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (73, N'Test Ana Yemek 14', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (74, N'Test Ana Yemek 15', CAST(125.00 AS Decimal(18, 2)), N'Et, Pilav, Sebze, Test', N'images/menu/default-food.jpg', 3, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (75, N'Test İçecek 1', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (76, N'Test İçecek 2', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (77, N'Test İçecek 3', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (78, N'Test İçecek 4', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (79, N'Test İçecek 5', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (80, N'Test İçecek 6', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (81, N'Test İçecek 7', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (82, N'Test İçecek 8', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (83, N'Test İçecek 9', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (84, N'Test İçecek 10', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (85, N'Test İçecek 11', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (86, N'Test İçecek 12', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (87, N'Test İçecek 13', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (88, N'Test İçecek 14', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (89, N'Test İçecek 15', CAST(20.00 AS Decimal(18, 2)), N'Soğuk/Sıcak, Test Karışım', N'images/menu/default-food.jpg', 4, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (90, N'Test Tatlı 1', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (91, N'Test Tatlı 2', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (92, N'Test Tatlı 3', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (93, N'Test Tatlı 4', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (94, N'Test Tatlı 5', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (95, N'Test Tatlı 6', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (96, N'Test Tatlı 7', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (97, N'Test Tatlı 8', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (98, N'Test Tatlı 9', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (99, N'Test Tatlı 10', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (100, N'Test Tatlı 11', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (101, N'Test Tatlı 12', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (102, N'Test Tatlı 13', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (103, N'Test Tatlı 14', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
INSERT [dbo].[URUNLER] ([UrunID], [UrunAd], [Fiyat], [Icindekiler], [Resim], [KategoriID], [Durum]) VALUES (104, N'Test Tatlı 15', CAST(60.00 AS Decimal(18, 2)), N'Şeker, Çikolata, Meyve, Test', N'images/menu/default-food.jpg', 5, 1)
GO
SET IDENTITY_INSERT [dbo].[URUNLER] OFF
GO
SET IDENTITY_INSERT [dbo].[USTILETISIM] ON 
GO
INSERT [dbo].[USTILETISIM] ([UstID], [Telefon], [Mail], [AcilisKapanis], [Facebook], [Instagram], [Twitter], [Linkedin], [Durum]) VALUES (1, N'+90 538 452 57 50', N'gencayceliker@gmail.com', N'Pzt - Cum / 9:00-21:00, Cmt - Paz / 10:00-20:00', N'fb.com/tasteit', N'ig.com/tasteit', N'tw.com/tasteit', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[USTILETISIM] OFF
GO
SET IDENTITY_INSERT [dbo].[UYELER] ON 
GO
INSERT [dbo].[UYELER] ([UyeID], [AdSoyad], [Mail], [Sifre], [Yetki], [SozlesmeOnay], [KayitTarihi], [Durum]) VALUES (1, N'Gencay Çeliker', N'gencayceliker@gmail.com', N'1234', N'Admin', 1, CAST(N'2026-03-05' AS Date), 1)
GO
INSERT [dbo].[UYELER] ([UyeID], [AdSoyad], [Mail], [Sifre], [Yetki], [SozlesmeOnay], [KayitTarihi], [Durum]) VALUES (2, N'Ali Veli', N'veliali@mail.com', N'4321', N'Uye', 1, CAST(N'2026-03-05' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[UYELER] OFF
GO
SET IDENTITY_INSERT [dbo].[YORUMLAR] ON 
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (1, N'John Gustavo', N'john@mail.com', CAST(N'2026-02-15' AS Date), N'Çok uzaklarda, kelime dağlarının arkasında kör metinler yaşar.', 0)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (2, N'Sena Yüce', N'sena@mail.com', CAST(N'2026-02-15' AS Date), N'Hizmet ve yemekler harikaydı, herkese tavsiye ederim.', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (3, N'Ali Vural', N'ali@mail.com', CAST(N'2026-02-15' AS Date), N'Mekan çok şık, özellikle bahçe kısmına bayıldım.', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (4, N'Merve Tekin', N'merve@mail.com', CAST(N'2026-02-15' AS Date), N'Fiyat performans olarak bölgedeki en iyi restoran.', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (5, N'Bora Işık', N'bora@mail.com', CAST(N'2026-02-15' AS Date), N'Tatlılar gerçekten efsane, özellikle sufleyi denemelisiniz.', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (8, N'Emrah Çpkan', N'emrah@mail.com', CAST(N'2026-02-20' AS Date), N'Tatlılar Çok Güzeldi.', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (9, N'Ahmet Çakar', N'qwewqeqw@mail.com', CAST(N'2026-02-24' AS Date), N'wqeqweqweqwewqewq', 1)
GO
INSERT [dbo].[YORUMLAR] ([YorumID], [MusteriAdSoyad], [Mail], [Tarih], [YorumMetni], [Durum]) VALUES (11, N'wewqewqeq', N'qweqwe@mail.com', CAST(N'2026-02-26' AS Date), N'qwewqeqw', 1)
GO
SET IDENTITY_INSERT [dbo].[YORUMLAR] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UYELER__2724B2D1F73DE3CB]    Script Date: 25.03.2026 18:54:24 ******/
ALTER TABLE [dbo].[UYELER] ADD UNIQUE NONCLUSTERED 
(
	[Mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ANASAYFA] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] ADD  CONSTRAINT [DF__DUYURUBLO__Tarih__6C190EBB]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[DUYURUBLOGYORUMLARI] ADD  CONSTRAINT [DF__DUYURUBLO__Durum__6D0D32F4]  DEFAULT ((0)) FOR [Durum]
GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] ADD  CONSTRAINT [DF__DUYURULAB__Tarih__619B8048]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[DUYURULABLOGLAR] ADD  CONSTRAINT [DF__DUYURULAB__Durum__628FA481]  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[ICERIKLER] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[ICERIKLER] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[NAVBAR] ADD  DEFAULT ((0)) FOR [Sira]
GO
ALTER TABLE [dbo].[NAVBAR] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT (getdate()) FOR [Saat]
GO
ALTER TABLE [dbo].[REZARVASYONLAR] ADD  DEFAULT ((1)) FOR [DurumID]
GO
ALTER TABLE [dbo].[SEFLER] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] ADD  DEFAULT (getdate()) FOR [OlusturmaTarihi]
GO
ALTER TABLE [dbo].[SIFRE_SIFIRLAMA] ADD  DEFAULT ((0)) FOR [KullanildiMi]
GO
ALTER TABLE [dbo].[URUNLER] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[USTILETISIM] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ('Uye') FOR [Yetki]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ((1)) FOR [SozlesmeOnay]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT (getdate()) FOR [KayitTarihi]
GO
ALTER TABLE [dbo].[UYELER] ADD  DEFAULT ((1)) FOR [Durum]
GO
ALTER TABLE [dbo].[YORUMLAR] ADD  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[YORUMLAR] ADD  DEFAULT ((0)) FOR [Durum]
GO
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
