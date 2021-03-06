USE [master]
GO
/****** Object:  Database [DirectorioCreativo_Cultura]    Script Date: 15/06/2021 11:23:48 ******/
CREATE DATABASE [DirectorioCreativo_Cultura]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DirectorioCreativo_Cultura', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENTS\MSSQL\DATA\DirectorioCreativo_Cultura.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DirectorioCreativo_Cultura_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENTS\MSSQL\DATA\DirectorioCreativo_Cultura_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DirectorioCreativo_Cultura].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ARITHABORT OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET RECOVERY FULL 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET  MULTI_USER 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DirectorioCreativo_Cultura', N'ON'
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET QUERY_STORE = OFF
GO
USE [DirectorioCreativo_Cultura]
GO
/****** Object:  User [directorio_creativo]    Script Date: 15/06/2021 11:23:49 ******/
CREATE USER [directorio_creativo] FOR LOGIN [directorio_creativo] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [directorio_creativo]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [directorio_creativo]
GO
/****** Object:  Table [dbo].[detalle_mensaje]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_mensaje](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_mensaje] [int] NOT NULL,
	[mensaje] [text] NOT NULL,
	[leido] [bit] NOT NULL,
	[fecha] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mensajes]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mensajes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_emisor] [int] NOT NULL,
	[id_receptor] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obra]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obra](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_perfil] [int] NULL,
	[img_obra] [varchar](555) NOT NULL,
	[nombre_obra] [varchar](95) NOT NULL,
	[descripcion_obra] [varchar](555) NOT NULL,
	[ubicacion] [varchar](95) NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[visitas] [int] NOT NULL,
	[valoraciones] [int] NOT NULL,
	[estado_obra] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[perfil_usuario]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[perfil_usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[img_perfil] [varchar](95) NULL,
	[visitas] [int] NULL,
	[valoraciones] [int] NULL,
	[instagram] [varchar](95) NULL,
	[facebook] [varchar](95) NULL,
	[youtbe] [varchar](95) NULL,
	[img_banner] [varchar](95) NULL,
 CONSTRAINT [PK__perfil_u__3213E83FBA6F9BB2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permisos]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permisos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](95) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](95) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles_permiso]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles_permiso](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_roles] [int] NOT NULL,
	[id_permiso] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solicitud_perfil_usuario]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_perfil_usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[nombre] [varchar](95) NULL,
	[apellido] [varchar](95) NULL,
	[profesion] [varchar](95) NULL,
	[descripcion] [varchar](95) NULL,
	[img_perfil] [varchar](95) NULL,
	[email] [varchar](95) NULL,
	[telefono] [varchar](95) NULL,
	[estado_solicitud] [bit] NULL,
	[fecha_solicitud] [datetime] NULL,
	[visitas] [int] NULL,
	[valoraciones] [int] NULL,
	[instagram] [varchar](95) NULL,
	[facebook] [varchar](95) NULL,
	[youtbe] [varchar](95) NULL,
	[img_banner] [varchar](95) NULL,
 CONSTRAINT [PK__solicitu__3213E83FD9E019E2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[token_log]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[token_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[token] [varchar](255) NOT NULL,
	[fecha_expiracion] [datetime] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_provincia] [int] NULL,
	[nombre] [varchar](95) NOT NULL,
	[apellido] [varchar](95) NOT NULL,
	[profesion] [varchar](190) NULL,
	[descripcion_general] [text] NULL,
	[telefono] [varchar](20) NOT NULL,
	[email] [varchar](95) NOT NULL,
	[clave] [varchar](255) NOT NULL,
	[salt_clave] [varchar](95) NOT NULL,
	[fecha_ingreso] [datetime] NOT NULL,
	[habilitado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario_rol]    Script Date: 15/06/2021 11:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario_rol](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_rol] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[obra] ON 

INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (15, 1, N'Prueba1-05-20-2021.png', N'sadasd', N'asdasdsad', N'1', CAST(N'2021-05-21T11:27:29.467' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (17, 1, N'Prueba1-05-20-2021.png', N'Prueba url', N'asdasdasd', N'2', CAST(N'2021-05-22T12:49:55.340' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (18, 1, N'Prueba2URL-05-20-2021.png', N'Prueba2 URL', N'Descripcion URL 2', N'3', CAST(N'2021-03-20T13:00:31.873' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (19, 1, N'Prueba4URL-05-20-2021.png', N'Prueba 4 URL', N'Prueba 4 URL', N'3', CAST(N'2021-05-20T13:10:34.760' AS DateTime), 0, 0, 0)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (20, 1, N'prueba5url-05-20-2021.png', N'prueba 5 url', N'prueba 5 url', N'3', CAST(N'2021-05-20T13:11:30.157' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (21, 1, N'prueba6url-05-20-2021.png', N'prueba 6 url', N'prueba 6 url', N'3', CAST(N'2021-05-20T13:13:31.623' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (22, 1, N'Prueba10URL-05-20-2021.png', N'Prueba 10 URL', N'Prueba 10 URL', N'3', CAST(N'2021-05-20T13:23:00.530' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (23, 1, N'sadadasdasd-05-20-2021.png', N'sadadasdasd', N'asdasdasd', N'3', CAST(N'2021-05-20T13:47:45.680' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (24, 1, N'ghdhd-05-20-2021.png', N'ghdhd', N'ghgdhdghd', N'1', CAST(N'2021-05-20T14:38:34.497' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (25, 1, N'xzczxc-05-20-2021.png', N'xzczxc', N'xzczxcxzczxc', N'2', CAST(N'2021-05-20T15:58:35.070' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (26, 1, N'ssssss-05-20-2021.png', N'ssssss', N'ssssssssssss', N'2', CAST(N'2021-05-20T16:01:41.210' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (27, 1, N'ChevyCamaro-05-24-2021.png', N'Chevy Camaro', N'2017 Chevrolet Camaro SS Limited Edition', N'1', CAST(N'2021-05-24T08:36:48.657' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (28, 1, N'ChevyCamaro-05-24-2021.png', N'Chevy Camaro', N'2017 Chevrolet Camaro SS Limited Edition', N'1', CAST(N'2021-05-24T08:37:01.910' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (29, 1, N'BRZ-05-24-2021.png', N'BRZ', N'afi9g30gn', N'1', CAST(N'2021-05-24T08:38:30.150' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (30, 1, N'ToyotaSupra-05-24-2021.png', N'Toyota Supra', N'Vehiculo Deportivo Japones', N'1', CAST(N'2021-05-24T09:07:52.390' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (31, 1, N'SupraMKV-05-24-2021.png', N'Supra MKV', N'Japones Deportivo', N'1', CAST(N'2021-05-24T09:10:32.530' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (32, 1, N'Supra-05-24-2021.png', N'Supra', N'Supra', N'1', CAST(N'2021-05-24T09:11:31.713' AS DateTime), 0, 0, 0)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (33, 1, N'Supra3-05-24-2021.png', N'Supra 3', N'Supra 3', N'1', CAST(N'2021-05-24T09:14:08.470' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (34, 1, N'NissanGTR-05-24-2021.png', N'Nissan GTR', N'Nissan GTR', N'1', CAST(N'2021-05-24T09:16:50.400' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (35, 5, N'NissanGTR2-05-24-2021.png', N'Nissan GTR 2', N'Nissan GTR 2', N'1', CAST(N'2021-05-24T09:17:28.527' AS DateTime), 0, 0, NULL)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (36, 1, N'Nissan-05-24-2021.png', N'Nissan', N'Nissan', N'1', CAST(N'2021-05-24T09:18:39.057' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (37, 1, N'supra5-05-24-2021.png', N'supra 5', N'supra 5', N'1', CAST(N'2021-05-24T09:22:57.887' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (38, 1, N'asa-05-24-2021.png', N'asa', N'asdsadasd', N'1', CAST(N'2021-05-24T09:23:11.940' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (39, 1, N'Supra555-05-24-2021.png', N'Supra 555', N'Supra 555', N'1', CAST(N'2021-05-24T09:26:33.893' AS DateTime), 0, 0, 0)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (40, 1, N'asdsadasd-05-24-2021.png', N'asdsadasd', N'asdsadasd', N'2', CAST(N'2021-05-24T09:37:12.583' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (41, 1, N'MercedesAMGGLE63-05-28-2021.png', N'Mercedes AMG GLE63', N'Vehículo deportivo todo terreno', N'1', CAST(N'2021-05-28T14:11:33.610' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (42, 1, N'Mercedes-05-28-2021.png', N'Mercedes', N'Mercedes todo terreno', N'1', CAST(N'2021-05-28T14:17:33.743' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (43, 1, N'AlfaRomeo-05-31-2021.png', N'Alfa Romeo', N'giulia quadrifoglio', N'2', CAST(N'2021-05-31T09:12:43.067' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (44, 1, N'huracanevo-05-31-2021.png', N'huracan evo', N'Deportivo Italiano', N'2', CAST(N'2021-05-31T09:15:15.137' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (45, 1, N'ferrari-05-31-2021.png', N'ferrari', N'mi ferrari', N'1', CAST(N'2021-05-31T09:47:10.873' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (46, 1, N'Lasmulasdesalcedo-05-31-2021.png', N'Las mulas de salcedo', N'"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', N'2', CAST(N'2021-05-31T09:55:05.743' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (47, 6, N'Supra2021-05-31-2021.png', N'Supra 2021', N'Toyota Supra GR 2021', N'2', CAST(N'2021-05-31T10:30:41.803' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (48, 1, N'Subaru-05-31-2021.png', N'Subaru', N'asdnoasind', N'1', CAST(N'2021-05-31T14:22:57.840' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (49, 7, N'Boda-06-01-2021.png', N'Boda', N'Boda de lucas', N'1', CAST(N'2021-06-01T10:12:00.513' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (50, 6, N'AudiR8-06-01-2021.png', N'Audi R8', N'Vehiculo deportivo', N'1', CAST(N'2021-06-01T13:29:13.760' AS DateTime), 0, 0, NULL)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (51, 7, N'Undiaenelcampo-06-01-2021.png', N'Un dia en el campo', N'Un dia en el campo en familia', N'1', CAST(N'2021-06-01T14:20:25.043' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (52, 7, N'sdsduf-06-01-2021.png', N'sdsduf', N'sdfsdfsdf', N'3', CAST(N'2021-06-01T14:22:27.160' AS DateTime), 0, 0, 0)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (53, 7, N'camaro-06-01-2021.png', N'camaro', N'2019', N'1', CAST(N'2021-06-01T15:42:17.020' AS DateTime), 0, 0, 1)
INSERT [dbo].[obra] ([id], [id_perfil], [img_obra], [nombre_obra], [descripcion_obra], [ubicacion], [fecha_registro], [visitas], [valoraciones], [estado_obra]) VALUES (54, 9, N'ferrari-06-01-2021.png', N'ferrari', N'asfnoasnfo', N'2', CAST(N'2021-06-01T15:46:12.237' AS DateTime), 0, 0, 0)
SET IDENTITY_INSERT [dbo].[obra] OFF
GO
SET IDENTITY_INSERT [dbo].[perfil_usuario] ON 

INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (1, 1, NULL, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (5, 5, NULL, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (6, 10, NULL, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (7, 11, NULL, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (8, 12, NULL, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[perfil_usuario] ([id], [id_usuario], [img_perfil], [visitas], [valoraciones], [instagram], [facebook], [youtbe], [img_banner]) VALUES (9, 13, NULL, 0, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[perfil_usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [nombre]) VALUES (1, N'Administrador')
INSERT [dbo].[roles] ([id], [nombre]) VALUES (2, N'Usuario')
INSERT [dbo].[roles] ([id], [nombre]) VALUES (3, N'Mantenimiento')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (1, 1, N'Sys', N'Admin', N'Pintora', N'Soy una pintora dominicana', N'809-000-0000', N'admin@gmail.com', N'vjekyvfdKpH+7ynZ8FoPGQ==', N'JC+Oh/+VuKYw1c3zBQEQKg==', CAST(N'2021-05-19T08:56:09.907' AS DateTime), NULL)
INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (5, 1, N'luis eduardo', N'Mañan Beltre', N'', N'', N'8498682891', N'compaq_eduardo@hotmail.com', N'HtgNWF3BLmYVtr96XVWm8A==', N'ywPIO7d+9bXim+7SGpr7UQ==', CAST(N'2021-05-31T10:19:46.920' AS DateTime), 1)
INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (10, 1, N'Martin Josue', N'Perez Perez', N'', N'Fotografo dominicano', N'809-599-0000', N'josue@gmail.com', N'20YbQzD9JKnDLBUpulSFCQ==', N'3AK/OOhkgYXNZSrV+mbMmw==', CAST(N'2021-05-31T10:29:30.457' AS DateTime), 1)
INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (11, 1, N'Bryan', N'Campos', N'', N'', N'0000000000', N'bryan@mail.com', N'y9sIBgRht8J2eUoqh7q/UQ==', N'5zId89/o3PwoPrVDITA0Yg==', CAST(N'2021-05-31T15:03:33.847' AS DateTime), 1)
INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (12, 1, N'Luis', N'Manan', N'', N'', N'0000000000', N'luis2@gmail.com', N'q7AFykR+ljLm+RSatMHHtg==', N'PozlD0eHp70w93/zwnYc/Q==', CAST(N'2021-06-01T14:24:44.340' AS DateTime), NULL)
INSERT [dbo].[usuario] ([id], [id_provincia], [nombre], [apellido], [profesion], [descripcion_general], [telefono], [email], [clave], [salt_clave], [fecha_ingreso], [habilitado]) VALUES (13, 1, N'Josue', N'Perez', N'', N'', N'0000000000', N'josue2@gmail.com', N'chbZaBswSLOe5q8B5z4AkA==', N'/NNfLJ4aZxrM88m4NwMjzQ==', CAST(N'2021-06-01T15:45:05.120' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[usuario_rol] ON 

INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (1, 5, 1)
INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (2, 1, 1)
INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (3, 10, 2)
INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (4, 11, 2)
INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (5, 12, 2)
INSERT [dbo].[usuario_rol] ([id], [id_usuario], [id_rol]) VALUES (6, 13, 2)
SET IDENTITY_INSERT [dbo].[usuario_rol] OFF
GO
ALTER TABLE [dbo].[detalle_mensaje]  WITH CHECK ADD  CONSTRAINT [FK_DetalleMensaje_MENSAJES] FOREIGN KEY([id_mensaje])
REFERENCES [dbo].[mensajes] ([id])
GO
ALTER TABLE [dbo].[detalle_mensaje] CHECK CONSTRAINT [FK_DetalleMensaje_MENSAJES]
GO
ALTER TABLE [dbo].[mensajes]  WITH CHECK ADD  CONSTRAINT [FK_MENSAJES_USUARIO_Emisor] FOREIGN KEY([id_emisor])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[mensajes] CHECK CONSTRAINT [FK_MENSAJES_USUARIO_Emisor]
GO
ALTER TABLE [dbo].[mensajes]  WITH CHECK ADD  CONSTRAINT [FK_MENSAJES_USUARIO_Receptor] FOREIGN KEY([id_receptor])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[mensajes] CHECK CONSTRAINT [FK_MENSAJES_USUARIO_Receptor]
GO
ALTER TABLE [dbo].[roles_permiso]  WITH CHECK ADD  CONSTRAINT [FK_RolesPermiso_PERMISOS] FOREIGN KEY([id_permiso])
REFERENCES [dbo].[permisos] ([id])
GO
ALTER TABLE [dbo].[roles_permiso] CHECK CONSTRAINT [FK_RolesPermiso_PERMISOS]
GO
ALTER TABLE [dbo].[roles_permiso]  WITH CHECK ADD  CONSTRAINT [FK_RolesPermiso_ROLES] FOREIGN KEY([id_roles])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[roles_permiso] CHECK CONSTRAINT [FK_RolesPermiso_ROLES]
GO
ALTER TABLE [dbo].[solicitud_perfil_usuario]  WITH CHECK ADD  CONSTRAINT [FK_SOLICITUD_PerfilUSUARIO] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[solicitud_perfil_usuario] CHECK CONSTRAINT [FK_SOLICITUD_PerfilUSUARIO]
GO
ALTER TABLE [dbo].[token_log]  WITH CHECK ADD  CONSTRAINT [FK_TokenLogs_USUARIO] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[token_log] CHECK CONSTRAINT [FK_TokenLogs_USUARIO]
GO
ALTER TABLE [dbo].[usuario_rol]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioRol_ROLES] FOREIGN KEY([id_rol])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[usuario_rol] CHECK CONSTRAINT [FK_UsuarioRol_ROLES]
GO
ALTER TABLE [dbo].[usuario_rol]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioRol_USUARIO] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[usuario_rol] CHECK CONSTRAINT [FK_UsuarioRol_USUARIO]
GO
USE [master]
GO
ALTER DATABASE [DirectorioCreativo_Cultura] SET  READ_WRITE 
GO
