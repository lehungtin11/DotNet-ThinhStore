USE [master]
GO
/****** Object:  Database [ThinhStore]    Script Date: 3/16/2024 6:27:57 PM ******/
CREATE DATABASE [ThinhStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ThinhStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ThinhStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ThinhStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ThinhStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ThinhStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ThinhStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ThinhStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ThinhStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ThinhStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ThinhStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ThinhStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [ThinhStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ThinhStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ThinhStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ThinhStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ThinhStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ThinhStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ThinhStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ThinhStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ThinhStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ThinhStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ThinhStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ThinhStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ThinhStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ThinhStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ThinhStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ThinhStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ThinhStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ThinhStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ThinhStore] SET  MULTI_USER 
GO
ALTER DATABASE [ThinhStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ThinhStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ThinhStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ThinhStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ThinhStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ThinhStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ThinhStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [ThinhStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ThinhStore]
GO
/****** Object:  Table [dbo].[invoices]    Script Date: 3/16/2024 6:27:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoices](
	[invoiceId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[paymentStatus] [nvarchar](50) NULL,
	[finalPrice] [decimal](15, 4) NULL,
	[paymentMethod] [nvarchar](50) NULL,
	[paymentDetails] [nvarchar](255) NULL,
	[issuedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[invoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_items]    Script Date: 3/16/2024 6:27:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_items](
	[orderItemId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[productId] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[orderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 3/16/2024 6:27:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[total_price] [decimal](15, 4) NULL,
	[discount] [decimal](10, 2) NULL,
	[orderAddress] [nvarchar](255) NULL,
	[orderEmail] [nvarchar](50) NULL,
	[orderPhone] [nvarchar](20) NULL,
	[orderNote] [nvarchar](255) NULL,
	[purchaseType] [nvarchar](50) NULL,
	[deliveryStatus] [nvarchar](50) NULL,
	[dateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 3/16/2024 6:27:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NULL,
	[name] [nvarchar](255) NULL,
	[image] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[spec_cpu] [nvarchar](255) NULL,
	[spec_os] [nvarchar](255) NULL,
	[spec_ram] [nvarchar](255) NULL,
	[spec_storage] [nvarchar](255) NULL,
	[spec_card_vga] [nvarchar](255) NULL,
	[spec_battery] [nvarchar](255) NULL,
	[spec_display] [nvarchar](255) NULL,
	[dateCreated] [datetime] NULL,
	[price] [int] NULL,
	[discount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 3/16/2024 6:27:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[full_name] [nvarchar](50) NULL,
	[gender] [nvarchar](10) NULL,
	[email] [nvarchar](50) NULL,
	[address] [nvarchar](255) NULL,
	[phone] [nvarchar](20) NULL,
	[salt] [nvarchar](255) NULL,
	[role] [nvarchar](50) NULL,
	[dateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[invoices] ON 

INSERT [dbo].[invoices] ([invoiceId], [orderId], [paymentStatus], [finalPrice], [paymentMethod], [paymentDetails], [issuedDate]) VALUES (4, 1, N'Paid', CAST(116501800.0000 AS Decimal(15, 4)), N'cash', NULL, CAST(N'2024-03-16T16:32:04.290' AS DateTime))
INSERT [dbo].[invoices] ([invoiceId], [orderId], [paymentStatus], [finalPrice], [paymentMethod], [paymentDetails], [issuedDate]) VALUES (5, 3, N'Paid', CAST(3095000.0000 AS Decimal(15, 4)), N'momo', NULL, CAST(N'2024-03-16T16:33:09.967' AS DateTime))
INSERT [dbo].[invoices] ([invoiceId], [orderId], [paymentStatus], [finalPrice], [paymentMethod], [paymentDetails], [issuedDate]) VALUES (6, 4, N'Paid', CAST(79385800.0000 AS Decimal(15, 4)), N'zalopay', NULL, CAST(N'2024-03-16T18:12:38.993' AS DateTime))
SET IDENTITY_INSERT [dbo].[invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[order_items] ON 

INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (17, 1, 13, 2, CAST(21990000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (18, 1, 18, 2, CAST(19990000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (19, 1, 19, 2, CAST(18890000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (20, 1, 14, 1, CAST(18990000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (21, 3, 35, 5, CAST(619000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (22, 4, 41, 2, CAST(490000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (23, 4, 40, 2, CAST(290000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (24, 4, 39, 2, CAST(1390000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_items] ([orderItemId], [orderId], [productId], [quantity], [price]) VALUES (25, 4, 19, 4, CAST(18890000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[order_items] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([orderId], [userId], [total_price], [discount], [orderAddress], [orderEmail], [orderPhone], [orderNote], [purchaseType], [deliveryStatus], [dateCreated]) VALUES (1, 2, CAST(116501800.0000 AS Decimal(15, 4)), CAST(0.00 AS Decimal(10, 2)), N'Địa chỉ giao hàng', N'admin@gmail.com', N'0912345678', N'Ghi chú đơn hàng', NULL, N'Delivered', CAST(N'2024-03-15T13:14:22.400' AS DateTime))
INSERT [dbo].[orders] ([orderId], [userId], [total_price], [discount], [orderAddress], [orderEmail], [orderPhone], [orderNote], [purchaseType], [deliveryStatus], [dateCreated]) VALUES (3, 2, CAST(3095000.0000 AS Decimal(15, 4)), CAST(0.00 AS Decimal(10, 2)), N'Địa chỉ giao hàng', N'admin@gmail.com', N'0912345678', N'Ghi chú đơn hàng', N'Online', N'Delivered', CAST(N'2024-03-16T16:32:43.737' AS DateTime))
INSERT [dbo].[orders] ([orderId], [userId], [total_price], [discount], [orderAddress], [orderEmail], [orderPhone], [orderNote], [purchaseType], [deliveryStatus], [dateCreated]) VALUES (4, 2, CAST(79385800.0000 AS Decimal(15, 4)), CAST(0.00 AS Decimal(10, 2)), N'aaa', N'admin@gmail.com', N'0912345678', N'aaaa', N'Online', N'Delivered', CAST(N'2024-03-16T16:33:50.507' AS DateTime))
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (13, N'acer', N'[New Outlet] Acer Nitro 5 AN515-58-57QW (Core i5-12450H, 16GB, 512GB, RTX 3050Ti, 15.6'' FHD IPS 144Hz)', N'3048_nitro_5_2022_ko_van.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:25:00.830' AS DateTime), 21990000, 20)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (14, N'acer', N'[New Outlet] Laptop Gaming Acer Nitro 5 2021 AN515-57-5700 (Core i5 - 11400H, 16GB, 512GB, RTX3050Ti, 15.6'' FHD IPS 144Hz)', N'hp-240-g9-i5-6l1y2pa-thumb-1-600x600.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:26:47.727' AS DateTime), 18990000, 16)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (15, N'acer', N'[Like New] Acer Nitro 5 AN515-55-50V2 (Core i5-10300H, 16GB, 512GB, GTX1650Ti 4GB DDR6, 15.6'' FHD 144Hz)', N'2896_2277_nitro_5_2020.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:28:24.857' AS DateTime), 19900000, 31)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (16, N'acer', N'[Like New] Acer Nitro 5 AN515-45-R7WA (Ryzen 7 - 5800H, 16GB, 512GB, RTX 3060 6GB, 15.6'' FHD IPS 144Hz)', N'3001_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:30:05.260' AS DateTime), 24990000, 24)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (17, N'acer', N'[Like New] Acer Nitro 5 AN515-57-56Z1 (Core i5 - 11400H, 16GB, 512GB, RTX3060, 15.6'''' FHD IPS 144Hz)', N'2920_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:32:06.553' AS DateTime), 20990000, 20)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (18, N'acer', N'[Like New] Acer Nitro 5 AN515-55-51KR (Core i5-10300H, 16GB, 512GB, GTX1660Ti 6GB DDR6, 15.6'' FHD 144Hz)', N'2930_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:33:55.750' AS DateTime), 19990000, 31)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (19, N'acer', N'[New Outlet] Acer Nitro 5 2022 AN515-58 (Core i5 - 12500H, 16GB, 512GB, RTX 3050Ti, 15.6'' FHD IPS 144Hz)', N'2554_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:34:40.753' AS DateTime), 18890000, 0)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (20, N'asus', N'[New 100%] Asus ROG Strix G15 G513IH-HN015W (Ryzen 7-4800H, 8GB, 512GB, GTX 1650, 15.6'''' FHD 144Hz)', N'2143_laptopaz_asus_rog_strix_g15_g513ih_hn015w_1.jpg', N'iPhone 15 Pro Max 256GB Chính Hãng VN/A Máy mới 100%, nguyên seal hộp, chính hãng Apple Việt Nam. Hộp, Sách hướng dẫn, Cây lấy sim, Cáp Type C - Type C

        Clickbuy là đại lý bán lẻ uỷ quyền iPhone chính hãng của Apple Việt Nam
        
        Bao test 1 ĐỔI 1 trong 30 ngày nếu có lỗi phần cứng nhà sản xuất. Bảo hành 12 tháng tại trung tâm bảo hành chính hãng Apple.', N'Exynos 990', N'Android 10', N'12GB', N'256GB', N'', N'4500mAh', N'6.7 inch, 1440x3200 pixels', CAST(N'2024-03-14T16:44:25.907' AS DateTime), 22890000, 23)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (21, N'asus', N'[New 100%] Asus TUF Gaming F15 FX506HF-HN014W (Core i5-11400H, 8GB, 512GB, RTX 2050, 15.6″ FHD 144Hz)', N'3017_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:45:21.530' AS DateTime), 19990000, 16)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (22, N'asus', N'[Like New] Asus TUF Gaming A15 FA506QM- HN077T (Ryzen 7-5800H, 16GB, 512GB, RTX 3060 6G, 15.6″ FHD IPS 144Hz)', N'3153_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:46:03.143' AS DateTime), 24990000, 28)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (23, N'asus', N'[New 100%] Asus TUF F15 FX507ZC4-HN074W (Core i5-12500H, 8GB, 512GB, RTX 3050 4GB, 15.6” FHD 144Hz IPS)', N'3034_asus_tuf_f15_fx507zc4.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:46:40.097' AS DateTime), 24990000, 20)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (24, N'asus', N'[New 100%] Asus TUF Dash F15 2022 FX517ZC-HN077W (Core i5-12450H, 8GB, 512GB, RTX 3050, 15.6″ FHD 144Hz) Off Black', N'2328_laptopaz_asus_tuf_f15_fx517zc_hn077w_1.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:47:21.063' AS DateTime), 28990000, 31)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (25, N'asus', N'[New 100%] Asus TUF F15 FX507ZC4-HN074W (Core i5-12500H, 8GB, 512GB, RTX 3050 4GB, 15.6” FHD 144Hz IPS)', N'3034_asus_tuf_f15_fx507zc4.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:48:02.880' AS DateTime), 24990000, 20)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (26, N'asus', N'[New 100%] Asus ROG Strix G15 G513IH-HN015W (Ryzen 7-4800H, 8GB, 512GB, GTX 1650, 15.6'''' FHD 144Hz)', N'2143_laptopaz_asus_rog_strix_g15_g513ih_hn015w_1.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:48:31.180' AS DateTime), 22890000, 23)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (27, N'msi', N'[New 100%] MSI Thin GF63 12UCX (Core i5-12450H, 8GB, 1TB, RTX 2050 4GB, 15.6'' FHD 144Hz)', N'3029_msi_thin_gf63_12ucx_tang_ram_8.gif', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:55:04.520' AS DateTime), 19990000, 26)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (28, N'msi', N'[New 100%] MSI Cyborg 15 A12UCX 281VN (Core i5-12450H, 8GB, 512GB, RTX 2050 4GB, 15.6'' FHD 144Hz)', N'2973_44961_laptop_msi_cyborg_15_a12ucx_281vn__7_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:55:51.883' AS DateTime), 21990000, 19)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (29, N'msi', N'[New 100%] MSI Bravo 15 B7ED 010VN (Ryzen 5-7535HS, 16GB, 512GB, Radeon RX6550M 4GB, 15.6'''' FHD 144Hz)', N'3039_msi_bravo_15_b7ed_010vn.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:56:23.963' AS DateTime), 20990000, 19)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (30, N'msi', N'[New 100%] MSI GF63 Thin 11SC 664VN (Core i5-11400H, 8GB, 512GB, GTX 1650 4GB, 15.6'' FHD 144Hz)', N'2811_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:56:57.620' AS DateTime), 19990000, 22)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (31, N'msi', N'[New 100%] MSI Thin GF63 12UCX (Core i5-12450H, 8GB, 1TB, RTX 2050 4GB, 15.6'' FHD 144Hz)', N'3029_msi_thin_gf63_12ucx_tang_ram_8.gif', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:58:02.827' AS DateTime), 19990000, 26)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (32, N'msi', N'[New 100%] MSI Cyborg 15 A12UCX 281VN (Core i5-12450H, 8GB, 512GB, RTX 2050 4GB, 15.6'' FHD 144Hz)', N'2973_44961_laptop_msi_cyborg_15_a12ucx_281vn__7_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:58:35.030' AS DateTime), 21990000, 19)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (33, N'msi', N'[New 100%] MSI Bravo 15 B7ED 010VN (Ryzen 5-7535HS, 16GB, 512GB, Radeon RX6550M 4GB, 15.6'''' FHD 144Hz)', N'3039_msi_bravo_15_b7ed_010vn.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:59:12.870' AS DateTime), 20990000, 19)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (34, N'msi', N'[New 100%] MSI GF63 Thin 11SC 664VN (Core i5-11400H, 8GB, 512GB, GTX 1650 4GB, 15.6'' FHD 144Hz)', N'2811_.jpg', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T16:59:47.270' AS DateTime), 19990000, 22)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (35, N'accessory', N'Pin Dự Phòng PISEN Pro Wireless Magsafe 10000mAh 22.5W  DY04', N'pin-du-phong-pisen-pro-wireless-magsafe-10000mah-225w-dy04_197507.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:01:25.180' AS DateTime), 619000, 0)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (36, N'accessory', N'Pin Dự Phòng Pisen Pro Quick Magsafe 22.5W 10.000 mAh DY19', N'pin-du-phong-pisen-pro-quick-magsafe-225w-10000-mah-dy19_197506.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:02:31.413' AS DateTime), 649000, 27)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (37, N'accessory', N'Pin sạc dự phòng Aukey PB-N83S 20W PD 10.000mAh', N'pin-sac-du-phong-aukey-pb-n83s-20w-pd-10000mah_197501.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:03:24.843' AS DateTime), 349000, 0)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (38, N'accessory', N'Ốp Lưng Trong Linh Hoạt Z Flip5 Chính Hãng', N'ava-oplungflip5-1.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:05:54.070' AS DateTime), 349000, 0)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (39, N'accessory', N'Bút Spen Fold Edition Z Fold5 Chính Hãng', N'but-spen.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:08:22.600' AS DateTime), 1390000, 15)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (40, N'accessory', N'Ốp Lưng Clear Case Galaxy A54 Chính Hãng', N'ava-a54oops.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:09:03.027' AS DateTime), 290000, 10)
INSERT [dbo].[products] ([id], [type], [name], [image], [description], [spec_cpu], [spec_os], [spec_ram], [spec_storage], [spec_card_vga], [spec_battery], [spec_display], [dateCreated], [price], [discount]) VALUES (41, N'accessory', N'Ốp Lưng Thông Minh Galaxy Z Flip5 Chính Hãng', N'ava-oplungflip5-2.webp', N'Chiếc laptop Gaming Nitro 5 AN515-58 được Nitro ra mắt mới đây là chiếc laptop sở hữu cấu hình siêu khủng với với bộ CPU Intel Core i5 12450H Gen 12 mới cùng card rời GeForce RTX 3050Ti 4 GB. Một miền đất đứa đối với các game thủ đúng không nào. Ngay sau đây chúng ta sẽ đi tìm hiểu xem con Nitro 5 có gì đáng được mong chờ nào.
        
        Về mặt thiết kế, vừa nhìn là chúng ta có thể nhận ra Acer Nitro 5 thay đổi 180* so với đàn anh của nó. Mặt A của máy giờ đây được tô điểm bằng các đường họa tiết đa sắc, giúp máy trở nên nổi bật giữa đám đông. Phong cách tối giản nhưng lại vô cùng tinh tế, hiện đại.', N'Core i5 - 12450H 8 nhân/ 12 luồng ( 3,3 Ghz-4,4 Ghz)', N'Windows 11', N'16GB DDR4 3200Mhz ( tối đa 64GB)', N'SSD 512GB NVMe              + 1 Khe SSD M2 Nvme                          + 1 Khe 2,5 inchs Sata', N'NVIDIA® GeForce® RTX 3050Ti 4GB GDDR6', N'4 Cell 57Wh', N'15.6 inch FHD (1920 x 1080) IPS slim bezel LCD 144Hz', CAST(N'2024-03-14T17:09:33.073' AS DateTime), 490000, 4)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([userId], [username], [password], [full_name], [gender], [email], [address], [phone], [salt], [role], [dateCreated]) VALUES (2, N'admin', N'92SM+izUN/57fV2SEdRM/GdL8BCriMA6eNG1hdYv/InHHaFn', N'Administrator', N'Male', N'admin@gmail.com', N'', N'', N'92SM+izUN/57fV2SEdRM/A==', NULL, CAST(N'2024-03-15T12:16:43.767' AS DateTime))
INSERT [dbo].[users] ([userId], [username], [password], [full_name], [gender], [email], [address], [phone], [salt], [role], [dateCreated]) VALUES (3, N'test', N'/2Z6DQBxphr88xieHCQnb1dmJLcd5LWB+DGKPnXz28Ps2aiK', N'Guest', NULL, N'test@gmail.com', NULL, NULL, N'/2Z6DQBxphr88xieHCQnbw==', NULL, CAST(N'2024-03-15T12:45:12.270' AS DateTime))
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164CD975AD3]    Script Date: 3/16/2024 6:27:57 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC572BD42B47C]    Script Date: 3/16/2024 6:27:57 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[invoices] ADD  DEFAULT (getdate()) FOR [issuedDate]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('Processing') FOR [deliveryStatus]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[products] ADD  CONSTRAINT [DF_products_price_temp]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[products] ADD  CONSTRAINT [DF_products_discount_temp]  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_full_name]  DEFAULT (N'Guest') FOR [full_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[invoices]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[orders] ([orderId])
GO
ALTER TABLE [dbo].[order_items]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[orders] ([orderId])
GO
ALTER TABLE [dbo].[order_items]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
USE [master]
GO
ALTER DATABASE [ThinhStore] SET  READ_WRITE 
GO
