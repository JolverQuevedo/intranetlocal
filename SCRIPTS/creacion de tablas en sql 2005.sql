/*=============================================================
SCRIPT HEADER

VERSION:   TABLAS INICIALES PARA ICRESIL
DATE:      03-10-2008
SERVER:    67.19.166.82

BACK UP COMPLETO DE OBJETOS Y DATOS

=============================================================*/

SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_WARNINGS ON
SET NOCOUNT ON
SET XACT_ABORT ON
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
	EXEC [icresil].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO
ALTER DATABASE [icresil] SET RECOVERY SIMPLE
GO
ALTER DATABASE [icresil] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [icresil] SET ANSI_NULLS OFF
GO
ALTER DATABASE [icresil] SET ANSI_PADDING OFF
GO
ALTER DATABASE [icresil] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [icresil] SET ARITHABORT OFF
GO
ALTER DATABASE [icresil] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [icresil] SET AUTO_CREATE_STATISTICS OFF
GO
ALTER DATABASE [icresil] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [icresil] SET AUTO_UPDATE_STATISTICS OFF
GO
ALTER DATABASE [icresil] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [icresil] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [icresil] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [icresil] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [icresil] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [icresil] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [icresil] SET TORN_PAGE_DETECTION OFF
GO
ALTER DATABASE [icresil] SET READ_WRITE
GO
ALTER DATABASE [icresil] SET MULTI_USER
GO

USE [icresil]
GO

-- Create Table PROPORCIONES
Print 'Create Table PROPORCIONES'
GO
CREATE TABLE [PROPORCIONES] (
		[PROPORCION]     char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROP0]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP1]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP2]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP3]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP4]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP5]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP6]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP7]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP8]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROP9]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]          AS (getdate()),
		[ESTADO]         AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROPORCIONES to PROPORCIONES
Print 'Add Primary Key PK_PROPORCIONES to PROPORCIONES'
GO
ALTER TABLE [PROPORCIONES]
	ADD
	CONSTRAINT [PK_PROPORCIONES]
	PRIMARY KEY
	([PROPORCION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PROTO-DETALLES
Print 'Create Table PROTO-DETALLES'
GO
CREATE TABLE [PROTO-DETALLES] (
		[PROTO]           char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]         char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPODETALLE]     char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ID]              int NOT NULL,
		[CODIGO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ADICIONAL]       varchar(700) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CONSUMO]         float NULL,
		[MERMA]           float NULL,
		[PESO]            float NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[COSTO]           float NULL,
		[TIPO]            char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RENDIMIENTO]     char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UBI]             int NULL,
		[RUTA]            char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROTO-DETALLES to PROTO-DETALLES
Print 'Add Primary Key PK_PROTO-DETALLES to PROTO-DETALLES'
GO
ALTER TABLE [PROTO-DETALLES]
	ADD
	CONSTRAINT [PK_PROTO-DETALLES]
	PRIMARY KEY
	([PROTO], [VERSION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table USUARIOS
Print 'Create Table USUARIOS'
GO
CREATE TABLE [USUARIOS] (
		[USUARIO]     char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLAVE]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NOMBRES]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_USUARIOS to USUARIOS
Print 'Add Primary Key PK_USUARIOS to USUARIOS'
GO
ALTER TABLE [USUARIOS]
	ADD
	CONSTRAINT [PK_USUARIOS]
	PRIMARY KEY
	([USUARIO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPOCLI
Print 'Create Table TIPOCLI'
GO
CREATE TABLE [TIPOCLI] (
		[TIPO]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TIPOCLI to TIPOCLI
Print 'Add Primary Key PK_TIPOCLI to TIPOCLI'
GO
ALTER TABLE [TIPOCLI]
	ADD
	CONSTRAINT [PK_TIPOCLI]
	PRIMARY KEY
	([TIPO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPPRENDA
Print 'Create Table TIPPRENDA'
GO
CREATE TABLE [TIPPRENDA] (
		[TIPO]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__TIPPRENDA__4F47C5E3 to TIPPRENDA
Print 'Add Primary Key PK__TIPPRENDA__4F47C5E3 to TIPPRENDA'
GO
ALTER TABLE [TIPPRENDA]
	ADD
	CONSTRAINT [PK__TIPPRENDA__4F47C5E3]
	PRIMARY KEY
	([TIPO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PERFILES
Print 'Create Table PERFILES'
GO
CREATE TABLE [PERFILES] (
		[ID]         char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERFIL]     nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PERFILES to PERFILES
Print 'Add Primary Key PK_PERFILES to PERFILES'
GO
ALTER TABLE [PERFILES]
	ADD
	CONSTRAINT [PK_PERFILES]
	PRIMARY KEY
	([ID])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPOSERVICIO
Print 'Create Table TIPOSERVICIO'
GO
CREATE TABLE [TIPOSERVICIO] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__TIPOSERVICIO__793DFFAF to TIPOSERVICIO
Print 'Add Primary Key PK__TIPOSERVICIO__793DFFAF to TIPOSERVICIO'
GO
ALTER TABLE [TIPOSERVICIO]
	ADD
	CONSTRAINT [PK__TIPOSERVICIO__793DFFAF]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PO-OBS
Print 'Create Table PO-OBS'
GO
CREATE TABLE [PO-OBS] (
		[PO]          char(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATO]        varchar(8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PO-OBS to PO-OBS
Print 'Add Primary Key PK_PO-OBS to PO-OBS'
GO
ALTER TABLE [PO-OBS]
	ADD
	CONSTRAINT [PK_PO-OBS]
	PRIMARY KEY
	([PO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table RECTILINEOS
Print 'Create Table RECTILINEOS'
GO
CREATE TABLE [RECTILINEOS] (
		[CODIGO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TELA]            char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TOLERANCIA]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR0]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR1]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR2]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR3]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR4]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR5]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR6]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR7]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR8]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LAR9]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC0]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC1]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC2]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC3]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC4]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC5]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC6]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC7]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC8]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANC9]            char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA]           char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FACTOR]          int NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[PESO]            float NOT NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_RECTILINEOS to RECTILINEOS
Print 'Add Primary Key PK_RECTILINEOS to RECTILINEOS'
GO
ALTER TABLE [RECTILINEOS]
	ADD
	CONSTRAINT [PK_RECTILINEOS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPREND
Print 'Create Table TIPREND'
GO
CREATE TABLE [TIPREND] (
		[CODIGO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TIPREND to TIPREND
Print 'Add Primary Key PK_TIPREND to TIPREND'
GO
ALTER TABLE [TIPREND]
	ADD
	CONSTRAINT [PK_TIPREND]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPTEL
Print 'Create Table TIPTEL'
GO
CREATE TABLE [TIPTEL] (
		[CODIGO]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__TIPTEL__13F1F5EB to TIPTEL
Print 'Add Primary Key PK__TIPTEL__13F1F5EB to TIPTEL'
GO
ALTER TABLE [TIPTEL]
	ADD
	CONSTRAINT [PK__TIPTEL__13F1F5EB]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPAVI
Print 'Create Table TIPAVI'
GO
CREATE TABLE [TIPAVI] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__TIPAVI__4B7734FF to TIPAVI
Print 'Add Primary Key PK__TIPAVI__4B7734FF to TIPAVI'
GO
ALTER TABLE [TIPAVI]
	ADD
	CONSTRAINT [PK__TIPAVI__4B7734FF]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TENIDO
Print 'Create Table TENIDO'
GO
CREATE TABLE [TENIDO] (
		[TENIDO]        char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESTENIDO]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]         AS (getdate()),
		[ESTADO]        AS ('A'),
		[MERMA]         float NULL,
		[COSTOKG]       float NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TENIDO to TENIDO
Print 'Add Primary Key PK_TENIDO to TENIDO'
GO
ALTER TABLE [TENIDO]
	ADD
	CONSTRAINT [PK_TENIDO]
	PRIMARY KEY
	([TENIDO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TALLAS
Print 'Create Table TALLAS'
GO
CREATE TABLE [TALLAS] (
		[TALLAS]      char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TALLA0]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA1]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA2]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA3]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA4]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA5]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA6]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA7]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA8]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLA9]      char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TALLAS to TALLAS
Print 'Add Primary Key PK_TALLAS to TALLAS'
GO
ALTER TABLE [TALLAS]
	ADD
	CONSTRAINT [PK_TALLAS]
	PRIMARY KEY
	([TALLAS])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TIPEXPLO
Print 'Create Table TIPEXPLO'
GO
CREATE TABLE [TIPEXPLO] (
		[CODIGO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TIPEXPLO to TIPEXPLO
Print 'Add Primary Key PK_TIPEXPLO to TIPEXPLO'
GO
ALTER TABLE [TIPEXPLO]
	ADD
	CONSTRAINT [PK_TIPEXPLO]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TONOS
Print 'Create Table TONOS'
GO
CREATE TABLE [TONOS] (
		[TONO]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESTONO]      char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]        AS (getdate()),
		[ESTADO]       AS ('A'),
		[HEXCOLOR]     char(7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TONOS to TONOS
Print 'Add Primary Key PK_TONOS to TONOS'
GO
ALTER TABLE [TONOS]
	ADD
	CONSTRAINT [PK_TONOS]
	PRIMARY KEY
	([TONO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table UNIDADES
Print 'Create Table UNIDADES'
GO
CREATE TABLE [UNIDADES] (
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_UNIDADES to UNIDADES
Print 'Add Primary Key PK_UNIDADES to UNIDADES'
GO
ALTER TABLE [UNIDADES]
	ADD
	CONSTRAINT [PK_UNIDADES]
	PRIMARY KEY
	([UNIDAD])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PARAMETROS
Print 'Create Table PARAMETROS'
GO
CREATE TABLE [PARAMETROS] (
		[ADMIN]             char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IGV]               int NULL,
		[CAL1]              int NULL,
		[CAL2]              int NULL,
		[MINORISTA]         int NULL,
		[HITEPIMA]          char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLAVEINGE]         char(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OPERCORTE]         char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OPERCOSTURA]       char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLAVETEJE]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OPERTEJE]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLAVEACABADO]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[COTIZA]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CODTEJIDO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VISA]              float NULL,
		[DCTOEMP]           float NULL,
		[UTILIDAD]          float NULL,
		[TIPCAM]            float NULL,
		[FAL]               float NULL,
		[TOPEEMP]           float NULL,
		[TOPEOBR]           float NULL,
		[TOPEEJE]           float NULL,
		[bordado]           char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[estampado]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[lavado]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[tenido]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BLOQUE_ACABAD]     char(9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BLOQUE_ZURCID]     char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BLOQUE_DESMAN]     char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BLOQUE_DESCON]     char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BLOQUE_SEGUN]      char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RUC]               char(11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SALIDAS]           char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[utilidad2]         float NULL
)
ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table GRUPOPRENDA
Print 'Create Table GRUPOPRENDA'
GO
CREATE TABLE [GRUPOPRENDA] (
		[CODIGO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_GRUPOPRENDA to GRUPOPRENDA
Print 'Add Primary Key PK_GRUPOPRENDA to GRUPOPRENDA'
GO
ALTER TABLE [GRUPOPRENDA]
	ADD
	CONSTRAINT [PK_GRUPOPRENDA]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table GENEROS
Print 'Create Table GENEROS'
GO
CREATE TABLE [GENEROS] (
		[GENERO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__GENEROS__531856C7 to GENEROS
Print 'Add Primary Key PK__GENEROS__531856C7 to GENEROS'
GO
ALTER TABLE [GENEROS]
	ADD
	CONSTRAINT [PK__GENEROS__531856C7]
	PRIMARY KEY
	([GENERO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MATERIA-PRIMA
Print 'Create Table MATERIA-PRIMA'
GO
CREATE TABLE [MATERIA-PRIMA] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_MATERIA-PRIMA to MATERIA-PRIMA
Print 'Add Primary Key PK_MATERIA-PRIMA to MATERIA-PRIMA'
GO
ALTER TABLE [MATERIA-PRIMA]
	ADD
	CONSTRAINT [PK_MATERIA-PRIMA]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table LINEAPRENDAS
Print 'Create Table LINEAPRENDAS'
GO
CREATE TABLE [LINEAPRENDAS] (
		[CODLINEA]        char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_LINEAPRENDAS to LINEAPRENDAS
Print 'Add Primary Key PK_LINEAPRENDAS to LINEAPRENDAS'
GO
ALTER TABLE [LINEAPRENDAS]
	ADD
	CONSTRAINT [PK_LINEAPRENDAS]
	PRIMARY KEY
	([CODLINEA])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table FAMTELAS
Print 'Create Table FAMTELAS'
GO
CREATE TABLE [FAMTELAS] (
		[FAMTELA]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CORREL]          decimal(18, 0) NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[COSTO]           float NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_FAMTELAS to FAMTELAS
Print 'Add Primary Key PK_FAMTELAS to FAMTELAS'
GO
ALTER TABLE [FAMTELAS]
	ADD
	CONSTRAINT [PK_FAMTELAS]
	PRIMARY KEY
	([FAMTELA])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table DESTINATARIOS
Print 'Create Table DESTINATARIOS'
GO
CREATE TABLE [DESTINATARIOS] (
		[CODIGO]      varchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESTINO]     varchar(152) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AREA]        varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_DESTINATARIOS to DESTINATARIOS
Print 'Add Primary Key PK_DESTINATARIOS to DESTINATARIOS'
GO
ALTER TABLE [DESTINATARIOS]
	ADD
	CONSTRAINT [PK_DESTINATARIOS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table COTIZACION
Print 'Create Table COTIZACION'
GO
CREATE TABLE [COTIZACION] (
		[COTIZACION]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INDIRECTOS]         float NOT NULL,
		[ENERGIA]            float NOT NULL,
		[ADMINISTRACION]     float NOT NULL,
		[VENTAS]             float NOT NULL,
		[FINANCIEROS]        float NOT NULL,
		[MINUTO]             float NOT NULL,
		[COMISION]           float NULL,
		[PRECIO]             float NOT NULL,
		[INICIAL]            float NOT NULL,
		[TARGET]             float NULL,
		[USUARIO]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]              AS (getdate()),
		[ESTADO]             AS ('A'),
		[CNETO]              float NULL,
		[SERVICIOS]          float NULL,
		[TIPOCAMBIO]         float NULL,
		[CTODIRECTO]         float NULL,
		[MINUTOCORTE]        float NULL,
		[MINUTOACABADOS]     float NULL,
		[UTILIDAD]           AS ((0))
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_COTIZACION to COTIZACION
Print 'Add Primary Key PK_COTIZACION to COTIZACION'
GO
ALTER TABLE [COTIZACION]
	ADD
	CONSTRAINT [PK_COTIZACION]
	PRIMARY KEY
	([COTIZACION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table FAMAVIOS
Print 'Create Table FAMAVIOS'
GO
CREATE TABLE [FAMAVIOS] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PORMER]          float NULL,
		[CORREL]          float NULL,
		[TIPOAVIO]        char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           smalldatetime NULL,
		[ESTADO]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CUENTA]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_FAMAVIOS to FAMAVIOS
Print 'Add Primary Key PK_FAMAVIOS to FAMAVIOS'
GO
ALTER TABLE [FAMAVIOS]
	ADD
	CONSTRAINT [PK_FAMAVIOS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table ESPECIFICACIONES
Print 'Create Table ESPECIFICACIONES'
GO
CREATE TABLE [ESPECIFICACIONES] (
		[ESPECIFICACION]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROTO]              char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]            char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MINCORTE]           float NULL,
		[MINCOSTURA]         float NULL,
		[MINACABADO]         float NULL,
		[MINVARIOS]          float NULL,
		[EFICORTE]           int NULL,
		[EFICOSTURA]         int NULL,
		[EFIACABADO]         int NULL,
		[EFIVARIOS]          int NULL,
		[USUARIO]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]              AS (getdate()),
		[ESTADO]             AS ('A'),
		[VARIOS]             varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PORA]               float NULL,
		[PORB]               float NULL,
		[PORC]               float NULL,
		[COBERTURA]          float NULL,
		[STAT]               char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_ESPECIFICACIONES to ESPECIFICACIONES
Print 'Add Primary Key PK_ESPECIFICACIONES to ESPECIFICACIONES'
GO
ALTER TABLE [ESPECIFICACIONES]
	ADD
	CONSTRAINT [PK_ESPECIFICACIONES]
	PRIMARY KEY
	([ESPECIFICACION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MATRIZ_PROTO
Print 'Create Table MATRIZ_PROTO'
GO
CREATE TABLE [MATRIZ_PROTO] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_MATRIZ_PROTO to MATRIZ_PROTO
Print 'Add Primary Key PK_MATRIZ_PROTO to MATRIZ_PROTO'
GO
ALTER TABLE [MATRIZ_PROTO]
	ADD
	CONSTRAINT [PK_MATRIZ_PROTO]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MERCADOS
Print 'Create Table MERCADOS'
GO
CREATE TABLE [MERCADOS] (
		[CODIGO]          char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__MERCADOS__6EC0713C to MERCADOS
Print 'Add Primary Key PK__MERCADOS__6EC0713C to MERCADOS'
GO
ALTER TABLE [MERCADOS]
	ADD
	CONSTRAINT [PK__MERCADOS__6EC0713C]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MENU
Print 'Create Table MENU'
GO
CREATE TABLE [MENU] (
		[MENU]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERFIL]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DESMENU]      varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROGRAMA]     varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FOTO]         varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESTADO]       char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_MENU to MENU
Print 'Add Primary Key PK_MENU to MENU'
GO
ALTER TABLE [MENU]
	ADD
	CONSTRAINT [PK_MENU]
	PRIMARY KEY
	([MENU])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MERMAS
Print 'Create Table MERMAS'
GO
CREATE TABLE [MERMAS] (
		[SERVICIOS]     float NULL,
		[TELAS]         float NULL,
		[AVIOS]         float NULL,
		[HILO]          float NULL,
		[TEJIDO]        float NULL,
		[TENIDO]        float NULL,
		[USUARIO]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]         smalldatetime NULL,
		[ESTADO]        char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CORTE]         float NULL,
		[ACABADO]       float NULL,
		[COSTURA]       float NULL,
		[EMBALAJE]      float NULL,
		[ENCONADO]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PAISES
Print 'Create Table PAISES'
GO
CREATE TABLE [PAISES] (
		[CODIGO]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PAISES to PAISES
Print 'Add Primary Key PK_PAISES to PAISES'
GO
ALTER TABLE [PAISES]
	ADD
	CONSTRAINT [PK_PAISES]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MONEDAS
Print 'Create Table MONEDAS'
GO
CREATE TABLE [MONEDAS] (
		[CODIGO]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_MONEDAS to MONEDAS
Print 'Add Primary Key PK_MONEDAS to MONEDAS'
GO
ALTER TABLE [MONEDAS]
	ADD
	CONSTRAINT [PK_MONEDAS]
	PRIMARY KEY
	NONCLUSTERED
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table MEDIDAS
Print 'Create Table MEDIDAS'
GO
CREATE TABLE [MEDIDAS] (
		[CODIGO]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_MEDIDAS to MEDIDAS
Print 'Add Primary Key PK_MEDIDAS to MEDIDAS'
GO
ALTER TABLE [MEDIDAS]
	ADD
	CONSTRAINT [PK_MEDIDAS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


GO
-- Create Procedure FICHAPROTO
Print 'Create Procedure FICHAPROTO'
GO
CREATE procedure  [FICHAPROTO]  @pro char(10), @ver char(3) as


DECLARE  @n int

set @n= (select count(*) from protos where proto = @PRO and version =@VER)

if @pro = '' OR @pro is null OR @n<=0

	select  	'' as proto, '' as version, 	'' as tip, 	'' as des, '' as codcli, '' as codtem, '' as codgen, 	'' as codtel, '' as codtal,   '' as codtip,
	'' as fot, 	'' as tel, 	'' as cli, 	'' as tem, '' as gen, '' as tal,'' as rat, '' as est,'' as codrat, '' as codest, '' as cotizacion,'' as solicita, '' as ddp

else

	select p.proto,p.version,p.cotizacion,p.tipprenda as codtip,  p.descripcion as des,p.cliente as codcli,p.temporada as codtem, 
	p.genero as codgen,p.tela as codtel,p.tallas as codtal,  p.proporcion as codrat,p.estilo as codest,p.foto as fot, 
	te.descripcion as tel,e.nombre as cli, t.descripcion as tem, g.descripcion as gen, tl.tallas as tal,pr.proporcion as rat, 
	es.descripcion as est,tp.descripcion as tip,po.solicita,po.ddp
	from protos p
	inner join telas te on te.tela = p.tela
	inner join empresas e on e.cliente = p.cliente
	inner join temporadas t on t.codigo = p.temporada  
	inner join generos g on g.genero = p.genero 
	inner join tipprenda tp on tp.tipo = p.tipprenda
	inner join estilos es on es.estilo = p.estilo and es.cliente = p.cliente
	inner join [proto-obs]po on po.proto=p.proto and po.version=p.version
	left outer join tallas tl on tl.tallas = p.tallas 
	left outer join proporciones pr	on pr.proporcion = p.proporcion 
	where p.proto = @PRO and p.version =@VER
GO


GO


SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table AVIOS
Print 'Create Table AVIOS'
GO
CREATE TABLE [AVIOS] (
		[CODIGO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MONEDA]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[COSTO]           float NULL,
		[FAMAVI]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[TIPEXPLO]        char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[STAT]            char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TIPAVI]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_AVIOS to AVIOS
Print 'Add Primary Key PK_AVIOS to AVIOS'
GO
ALTER TABLE [AVIOS]
	ADD
	CONSTRAINT [PK_AVIOS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table EMPRESAS
Print 'Create Table EMPRESAS'
GO
CREATE TABLE [EMPRESAS] (
		[CLIENTE]       char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RUC]           char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NOMBRE]        varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DIRECCION]     varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CIUDAD]        varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZONA]          char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PAIS]          char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TIPO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FAX]           char(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TELEFONO]      char(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]         AS (getdate()),
		[USUARIO]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESTADO]        AS ('A'),
		[CELULAR]       char(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GRUPO]         char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LISTA]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VENDEDOR]      char(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SIGLA]         char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_EMPRESAS to EMPRESAS
Print 'Add Primary Key PK_EMPRESAS to EMPRESAS'
GO
ALTER TABLE [EMPRESAS]
	ADD
	CONSTRAINT [PK_EMPRESAS]
	PRIMARY KEY
	([CLIENTE])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table POS
Print 'Create Table POS'
GO
CREATE TABLE [POS] (
		[PO]             char(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROTO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]        char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLIENTE]        char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESTINO]        char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EMBARQUE]       smalldatetime NULL,
		[TIPOEMB]        char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[REFERENCIA]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OP]             char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CANTIDAD]       int NULL,
		[NUMCOL]         int NULL,
		[TALLA]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CREACION]       smalldatetime NULL,
		[USUARIO]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]          AS (getdate()),
		[ESTADO]         AS ('A'),
		[CLAVE]          char(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OFISIS]         char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FOB]            float NULL,
		[CARTACOLOR]     varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_POS to POS
Print 'Add Primary Key PK_POS to POS'
GO
ALTER TABLE [POS]
	ADD
	CONSTRAINT [PK_POS]
	PRIMARY KEY
	([PO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table SERVICIOS
Print 'Create Table SERVICIOS'
GO
CREATE TABLE [SERVICIOS] (
		[CODIGO]          char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPO]            char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COSTO]           float NOT NULL,
		[MONEDA]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[MERMA]           float NOT NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__SERVICIOS__7D0E9093 to SERVICIOS
Print 'Add Primary Key PK__SERVICIOS__7D0E9093 to SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD
	CONSTRAINT [PK__SERVICIOS__7D0E9093]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO
-- Add Default Constraint DF__SERVICIOS__COSTO__7EF6D905 to SERVICIOS
Print 'Add Default Constraint DF__SERVICIOS__COSTO__7EF6D905 to SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD
	CONSTRAINT [DF__SERVICIOS__COSTO__7EF6D905]
	DEFAULT ((0)) FOR [COSTO]
GO


GO
-- Add Default Constraint DF__SERVICIOS__MERMA__03BB8E22 to SERVICIOS
Print 'Add Default Constraint DF__SERVICIOS__MERMA__03BB8E22 to SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD
	CONSTRAINT [DF__SERVICIOS__MERMA__03BB8E22]
	DEFAULT ((0)) FOR [MERMA]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PROTO-MEDIDA
Print 'Create Table PROTO-MEDIDA'
GO
CREATE TABLE [PROTO-MEDIDA] (
		[PROTO]       char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]     char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SEC]         int NOT NULL,
		[MEDIDA]      char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VAL0]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL1]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL2]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL3]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL4]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL5]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL6]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL7]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL8]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VAL9]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TOLMIN]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TOLMAX]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROTO-MEDIDA to PROTO-MEDIDA
Print 'Add Primary Key PK_PROTO-MEDIDA to PROTO-MEDIDA'
GO
ALTER TABLE [PROTO-MEDIDA]
	ADD
	CONSTRAINT [PK_PROTO-MEDIDA]
	PRIMARY KEY
	([PROTO], [VERSION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table SUBMENU
Print 'Create Table SUBMENU'
GO
CREATE TABLE [SUBMENU] (
		[MENU]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SUBMENU]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROGRAMA]        varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PARAMETROS]      varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESTADO]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_SUBMENU to SUBMENU
Print 'Add Primary Key PK_SUBMENU to SUBMENU'
GO
ALTER TABLE [SUBMENU]
	ADD
	CONSTRAINT [PK_SUBMENU]
	PRIMARY KEY
	([MENU], [SUBMENU])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PRENDAS
Print 'Create Table PRENDAS'
GO
CREATE TABLE [PRENDAS] (
		[CODIGO]          char(13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROTO]           char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VERSION]         char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DESCRIPCION]     char(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MINUTAJE]        float NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GENERO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPPRENDA]       char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLIENTE]         char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FOB]             float NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[MONEDA]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TALLA]           char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FOTO]            char(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GRUPO]           char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LINEA]           char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PRENDAS to PRENDAS
Print 'Add Primary Key PK_PRENDAS to PRENDAS'
GO
ALTER TABLE [PRENDAS]
	ADD
	CONSTRAINT [PK_PRENDAS]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table HILADO
Print 'Create Table HILADO'
GO
CREATE TABLE [HILADO] (
		[HILO]            char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MONEDA]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COSTO]           float NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__HILADO__671F4F74 to HILADO
Print 'Add Primary Key PK__HILADO__671F4F74 to HILADO'
GO
ALTER TABLE [HILADO]
	ADD
	CONSTRAINT [PK__HILADO__671F4F74]
	PRIMARY KEY
	([HILO])
	ON [PRIMARY]
GO


GO
-- Add Default Constraint DF__HILADO__COSTO__69FBBC1F to HILADO
Print 'Add Default Constraint DF__HILADO__COSTO__69FBBC1F to HILADO'
GO
ALTER TABLE [HILADO]
	ADD
	CONSTRAINT [DF__HILADO__COSTO__69FBBC1F]
	DEFAULT ((0)) FOR [COSTO]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table USR-OPC
Print 'Create Table USR-OPC'
GO
CREATE TABLE [USR-OPC] (
		[USUARIO]     char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MENU]        char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SUBMENU]     char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERFIL]      char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_USR-OPC to USR-OPC
Print 'Add Primary Key PK_USR-OPC to USR-OPC'
GO
ALTER TABLE [USR-OPC]
	ADD
	CONSTRAINT [PK_USR-OPC]
	PRIMARY KEY
	([USUARIO], [MENU], [SUBMENU])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table EMPRESA-ADICIONALES
Print 'Create Table EMPRESA-ADICIONALES'
GO
CREATE TABLE [EMPRESA-ADICIONALES] (
		[CLIENTE]     char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPODET]     char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ID]          char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATO]        char(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATO2]       char(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A'),
		[nextel]      char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OFISIS]      char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_EMPRESA-ADICIONALES to EMPRESA-ADICIONALES
Print 'Add Primary Key PK_EMPRESA-ADICIONALES to EMPRESA-ADICIONALES'
GO
ALTER TABLE [EMPRESA-ADICIONALES]
	ADD
	CONSTRAINT [PK_EMPRESA-ADICIONALES]
	PRIMARY KEY
	([CLIENTE], [TIPODET], [ID])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table ESTILOS
Print 'Create Table ESTILOS'
GO
CREATE TABLE [ESTILOS] (
		[ESTILO]          char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLIENTE]         char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A'),
		[GENERO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TIPOPRENDA]      char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_ESTILOS to ESTILOS
Print 'Add Primary Key PK_ESTILOS to ESTILOS'
GO
ALTER TABLE [ESTILOS]
	ADD
	CONSTRAINT [PK_ESTILOS]
	PRIMARY KEY
	([ESTILO], [CLIENTE])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PRENDADETA
Print 'Create Table PRENDADETA'
GO
CREATE TABLE [PRENDADETA] (
		[PRENDA]       char(13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TALLA]        char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COLOR]        char(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CALIDAD]      char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MINIMO]       decimal(18, 0) NULL,
		[MAXIMO]       decimal(18, 0) NULL,
		[UNIDADES]     decimal(18, 0) NULL,
		[USUARIO]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]        AS (getdate()),
		[ESTADO]       AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PRENDADETA to PRENDADETA
Print 'Add Primary Key PK_PRENDADETA to PRENDADETA'
GO
ALTER TABLE [PRENDADETA]
	ADD
	CONSTRAINT [PK_PRENDADETA]
	PRIMARY KEY
	([PRENDA], [TALLA], [COLOR])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table COLORES
Print 'Create Table COLORES'
GO
CREATE TABLE [COLORES] (
		[CODIGO]          char(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLIENTE]         char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TENIDO]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TONO]            char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__COLORES__0E391C95 to COLORES
Print 'Add Primary Key PK__COLORES__0E391C95 to COLORES'
GO
ALTER TABLE [COLORES]
	ADD
	CONSTRAINT [PK__COLORES__0E391C95]
	PRIMARY KEY
	([CODIGO])
	ON [PRIMARY]
GO


GO
-- Create Index COL_CLI on COLORES
Print 'Create Index COL_CLI on COLORES'
GO
CREATE INDEX [COL_CLI]
	ON [COLORES] ([CLIENTE], [CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table DIRECCIONES
Print 'Create Table DIRECCIONES'
GO
CREATE TABLE [DIRECCIONES] (
		[CLIENTE]          char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CODIGO]           char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESTINATARIO]     char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CALLE]            char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZIPCODE]          char(70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PAIS]             char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]            AS (getdate()),
		[ESTADO]           AS ('A'),
		[CIUDAD]           char(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_DIRECCIONES to DIRECCIONES
Print 'Add Primary Key PK_DIRECCIONES to DIRECCIONES'
GO
ALTER TABLE [DIRECCIONES]
	ADD
	CONSTRAINT [PK_DIRECCIONES]
	PRIMARY KEY
	([CLIENTE], [CODIGO])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table EMPRESA_TALLA
Print 'Create Table EMPRESA_TALLA'
GO
CREATE TABLE [EMPRESA_TALLA] (
		[CLIENTE]     char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TALLA]       char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_EMPRESA_TALLA to EMPRESA_TALLA
Print 'Add Primary Key PK_EMPRESA_TALLA to EMPRESA_TALLA'
GO
ALTER TABLE [EMPRESA_TALLA]
	ADD
	CONSTRAINT [PK_EMPRESA_TALLA]
	PRIMARY KEY
	([CLIENTE], [TALLA])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TELAS
Print 'Create Table TELAS'
GO
CREATE TABLE [TELAS] (
		[TELA]            char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     char(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPOTELA]        char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FAMILIA]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DIAMETRO]        int NOT NULL,
		[GALGA]           int NOT NULL,
		[PESOCRU]         float NOT NULL,
		[PESOACA]         float NOT NULL,
		[RENDTUB]         float NULL,
		[RENDABI]         float NULL,
		[ANCHTUB]         float NULL,
		[ANCHABI]         float NULL,
		[MONEDA]          char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COSTO]           float NULL,
		[UNIDAD]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HIL1]            char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HIL2]            char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[HIL3]            char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[POR1]            int NOT NULL,
		[POR2]            int NULL,
		[POR3]            int NULL,
		[ANCHCRU]         float NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK__TELAS__251C81ED to TELAS
Print 'Add Primary Key PK__TELAS__251C81ED to TELAS'
GO
ALTER TABLE [TELAS]
	ADD
	CONSTRAINT [PK__TELAS__251C81ED]
	PRIMARY KEY
	([TELA])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TEMPORADAS
Print 'Create Table TEMPORADAS'
GO
CREATE TABLE [TEMPORADAS] (
		[CODIGO]          char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPCION]     varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLIENTE]         char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TEMPORADAS to TEMPORADAS
Print 'Add Primary Key PK_TEMPORADAS to TEMPORADAS'
GO
ALTER TABLE [TEMPORADAS]
	ADD
	CONSTRAINT [PK_TEMPORADAS]
	PRIMARY KEY
	([CODIGO], [CLIENTE])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TELA-OBS
Print 'Create Table TELA-OBS'
GO
CREATE TABLE [TELA-OBS] (
		[TELA]            char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBSERVACION]     nvarchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TELA-OBS to TELA-OBS
Print 'Add Primary Key PK_TELA-OBS to TELA-OBS'
GO
ALTER TABLE [TELA-OBS]
	ADD
	CONSTRAINT [PK_TELA-OBS]
	PRIMARY KEY
	([TELA])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table TELACOLOR
Print 'Create Table TELACOLOR'
GO
CREATE TABLE [TELACOLOR] (
		[TELA]            char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COLOR]           char(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COMBINACION]     char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CALIDAD]         char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STOCK]           float NULL,
		[COSTO]           float NULL,
		[USUARIO]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]           AS (getdate()),
		[ESTADO]          AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_TELACOLOR to TELACOLOR
Print 'Add Primary Key PK_TELACOLOR to TELACOLOR'
GO
ALTER TABLE [TELACOLOR]
	ADD
	CONSTRAINT [PK_TELACOLOR]
	PRIMARY KEY
	([TELA], [COLOR])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PROTOS
Print 'Create Table PROTOS'
GO
CREATE TABLE [PROTOS] (
		[PROTO]              char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]            char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ESPECIFICACION]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TIPPRENDA]          char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DESCRIPCION]        varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLIENTE]            char(6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TEMPORADA]          char(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GENERO]             char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TELA]               char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TALLAS]             char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PROPORCION]         char(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESTILO]             char(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MOTIVO]             varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UNIDAD]             char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FOTO]               varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CREACION]           smalldatetime NULL,
		[USUARIOCREA]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]            char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]              AS (getdate()),
		[ESTADO]             AS ('A'),
		[COTIZACION]         char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CONSUMO]            char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TIEMPOS]            char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UNIMED]             char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROTOS to PROTOS
Print 'Add Primary Key PK_PROTOS to PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD
	CONSTRAINT [PK_PROTOS]
	PRIMARY KEY
	([PROTO], [VERSION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PO-DETA
Print 'Create Table PO-DETA'
GO
CREATE TABLE [PO-DETA] (
		[PO]          char(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COLOR]       char(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UBI]         int NULL,
		[CANT0]       int NULL,
		[CANT1]       int NULL,
		[CANT2]       int NULL,
		[CANT3]       int NULL,
		[CANT4]       int NULL,
		[CANT5]       int NULL,
		[CANT6]       int NULL,
		[CANT7]       int NULL,
		[CANT8]       int NULL,
		[CANT9]       int NULL,
		[USUARIO]     char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PO-DETA to PO-DETA
Print 'Add Primary Key PK_PO-DETA to PO-DETA'
GO
ALTER TABLE [PO-DETA]
	ADD
	CONSTRAINT [PK_PO-DETA]
	PRIMARY KEY
	([PO], [COLOR])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table HILOCOL
Print 'Create Table HILOCOL'
GO
CREATE TABLE [HILOCOL] (
		[HILO]        char(12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COLOR]       char(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CALIDAD]     varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USUARIO]     varchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA]       AS (getdate()),
		[ESTADO]      AS ('A')
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_HILOCOL to HILOCOL
Print 'Add Primary Key PK_HILOCOL to HILOCOL'
GO
ALTER TABLE [HILOCOL]
	ADD
	CONSTRAINT [PK_HILOCOL]
	PRIMARY KEY
	([HILO], [COLOR])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


GO
-- Create Procedure MODELODETA
Print 'Create Procedure MODELODETA'
GO
CREATE PROCEDURE [MODELODETA]  
@COD CHAR(13)
AS
SELECT 
	PP.CODIGO, 
	PP.DESCRIPCION, 
	PP.TALLA AS CODTAL,
	PD.TALLA ,
	PD.COLOR, 
    CC.DESCRIPCION AS DESCOL, 
	UNIDADES =SUM(CASE WHEN PP.UNIDAD = 'DD' THEN PD.UNIDADES/12 ELSE PD.UNIDADES END),	
	PP.CLIENTE,
	PD.USUARIO, 
    	MIN(PD.FECHA) AS FECHA, 
	PD.ESTADO, PP.UNIDAD
FROM 	PRENDADETA 	PD 
	FULL    OUTER JOIN 	COLORES 	CC 	ON  PD.COLOR 	= CC.CODIGO 
	FULL OUTER   JOIN 	PRENDAS 	PP 	ON 	PD.PRENDA 	= PP.CODIGO
WHERE PP.CODIGO = @COD AND PP.ESTADO = 'A'  AND PD.CALIDAD='0' 
      AND PD.ESTADO = 'A'
GROUP BY PP.CODIGO, PP.DESCRIPCION, PP.TALLA,
	PD.COLOR, CC.DESCRIPCION, PP.CLIENTE,PD.ESTADO,
    PP.UNIDAD, PD.USUARIO, PD.ESTADO , PD.TALLA

ORDER BY CC.DESCRIPCION
GO


GO


SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PROTO-OBS
Print 'Create Table PROTO-OBS'
GO
CREATE TABLE [PROTO-OBS] (
		[PROTO]        char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]      char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DDP]          text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ING]          varchar(6000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SOLICITA]     varchar(6000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USUARIO]      char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FECHA]        AS (getdate()),
		[ESTADO]       AS ('A')
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROTO-OBS to PROTO-OBS
Print 'Add Primary Key PK_PROTO-OBS to PROTO-OBS'
GO
ALTER TABLE [PROTO-OBS]
	ADD
	CONSTRAINT [PK_PROTO-OBS]
	PRIMARY KEY
	([PROTO], [VERSION])
	ON [PRIMARY]
GO


GO



SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO


GO
-- Create Table PROTO-TENIDO
Print 'Create Table PROTO-TENIDO'
GO
CREATE TABLE [PROTO-TENIDO] (
		[PROTO]          char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]        char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TENIDO]         char(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROPORCION]     float NULL,
		[COSTO]          float NULL
)
ON [PRIMARY]
GO


GO
-- Add Primary Key PK_PROTO-TENIDO to PROTO-TENIDO
Print 'Add Primary Key PK_PROTO-TENIDO to PROTO-TENIDO'
GO
ALTER TABLE [PROTO-TENIDO]
	ADD
	CONSTRAINT [PK_PROTO-TENIDO]
	PRIMARY KEY
	([PROTO], [VERSION])
	ON [PRIMARY]
GO


GO


-- Create Extended Property microsoft_database_tools_support on sysdiagrams
Print 'Create Extended Property microsoft_database_tools_support on sysdiagrams'
GO
EXEC sp_addextendedproperty N'microsoft_database_tools_support', 1, 'SCHEMA', N'dbo', 'TABLE', N'sysdiagrams', NULL, NULL
GO


GO

-- Create Foreign Key FK_AVIOS_FAMAVIOS on AVIOS
Print 'Create Foreign Key FK_AVIOS_FAMAVIOS on AVIOS'
GO
ALTER TABLE [AVIOS]
	ADD CONSTRAINT [FK_AVIOS_FAMAVIOS]
	FOREIGN KEY ([FAMAVI]) REFERENCES [FAMAVIOS] ([CODIGO])
GO


GO
-- Create Foreign Key FK_AVIOS_TIPAVI on AVIOS
Print 'Create Foreign Key FK_AVIOS_TIPAVI on AVIOS'
GO
ALTER TABLE [AVIOS]
	ADD CONSTRAINT [FK_AVIOS_TIPAVI]
	FOREIGN KEY ([TIPAVI]) REFERENCES [TIPAVI] ([CODIGO])
GO


GO
-- Create Foreign Key FK_AVIOS_TIPEXPLO on AVIOS
Print 'Create Foreign Key FK_AVIOS_TIPEXPLO on AVIOS'
GO
ALTER TABLE [AVIOS]
	ADD CONSTRAINT [FK_AVIOS_TIPEXPLO]
	FOREIGN KEY ([TIPEXPLO]) REFERENCES [TIPEXPLO] ([CODIGO])
GO


GO

-- Create Foreign Key FK_EMPRESAS_MERCADOS on EMPRESAS
Print 'Create Foreign Key FK_EMPRESAS_MERCADOS on EMPRESAS'
GO
ALTER TABLE [EMPRESAS]
	ADD CONSTRAINT [FK_EMPRESAS_MERCADOS]
	FOREIGN KEY ([ZONA]) REFERENCES [MERCADOS] ([CODIGO])
GO


GO
-- Create Foreign Key FK_EMPRESAS_PAISES on EMPRESAS
Print 'Create Foreign Key FK_EMPRESAS_PAISES on EMPRESAS'
GO
ALTER TABLE [EMPRESAS]
	ADD CONSTRAINT [FK_EMPRESAS_PAISES]
	FOREIGN KEY ([PAIS]) REFERENCES [PAISES] ([CODIGO])
GO


GO
-- Create Foreign Key FK_EMPRESAS_TIPOCLI on EMPRESAS
Print 'Create Foreign Key FK_EMPRESAS_TIPOCLI on EMPRESAS'
GO
ALTER TABLE [EMPRESAS]
	ADD CONSTRAINT [FK_EMPRESAS_TIPOCLI]
	FOREIGN KEY ([TIPO]) REFERENCES [TIPOCLI] ([TIPO])
GO


GO

-- Create Foreign Key FK_POS_PO-OBS on POS
Print 'Create Foreign Key FK_POS_PO-OBS on POS'
GO
ALTER TABLE [POS]
	ADD CONSTRAINT [FK_POS_PO-OBS]
	FOREIGN KEY ([PO]) REFERENCES [PO-OBS] ([PO])
GO


GO

-- Create Foreign Key FK__SERVICIOS__MONED__7FEAFD3E on SERVICIOS
Print 'Create Foreign Key FK__SERVICIOS__MONED__7FEAFD3E on SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD CONSTRAINT [FK__SERVICIOS__MONED__7FEAFD3E]
	FOREIGN KEY ([MONEDA]) REFERENCES [MONEDAS] ([CODIGO])
GO


GO
-- Create Foreign Key FK__SERVICIOS__TIPO__7E02B4CC on SERVICIOS
Print 'Create Foreign Key FK__SERVICIOS__TIPO__7E02B4CC on SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD CONSTRAINT [FK__SERVICIOS__TIPO__7E02B4CC]
	FOREIGN KEY ([TIPO]) REFERENCES [TIPOSERVICIO] ([CODIGO])
GO


GO
-- Create Foreign Key FK__SERVICIOS__UNIDA__00DF2177 on SERVICIOS
Print 'Create Foreign Key FK__SERVICIOS__UNIDA__00DF2177 on SERVICIOS'
GO
ALTER TABLE [SERVICIOS]
	ADD CONSTRAINT [FK__SERVICIOS__UNIDA__00DF2177]
	FOREIGN KEY ([UNIDAD]) REFERENCES [UNIDADES] ([UNIDAD])
GO


GO

-- Create Foreign Key FK_PROTO-MEDIDA_MEDIDAS on PROTO-MEDIDA
Print 'Create Foreign Key FK_PROTO-MEDIDA_MEDIDAS on PROTO-MEDIDA'
GO
ALTER TABLE [PROTO-MEDIDA]
	ADD CONSTRAINT [FK_PROTO-MEDIDA_MEDIDAS]
	FOREIGN KEY ([MEDIDA]) REFERENCES [MEDIDAS] ([CODIGO])
GO


GO
-- Create Foreign Key FK_PROTO-MEDIDA_PROTO-DETALLES on PROTO-MEDIDA
Print 'Create Foreign Key FK_PROTO-MEDIDA_PROTO-DETALLES on PROTO-MEDIDA'
GO
ALTER TABLE [PROTO-MEDIDA]
	ADD CONSTRAINT [FK_PROTO-MEDIDA_PROTO-DETALLES]
	FOREIGN KEY ([PROTO], [VERSION]) REFERENCES [PROTO-DETALLES] ([PROTO], [VERSION])
GO


GO

-- Create Foreign Key FK_SUBMENU_MENU on SUBMENU
Print 'Create Foreign Key FK_SUBMENU_MENU on SUBMENU'
GO
ALTER TABLE [SUBMENU]
	ADD CONSTRAINT [FK_SUBMENU_MENU]
	FOREIGN KEY ([MENU]) REFERENCES [MENU] ([MENU])
GO


GO

-- Create Foreign Key FK_PRENDAS_GRUPOPRENDA on PRENDAS
Print 'Create Foreign Key FK_PRENDAS_GRUPOPRENDA on PRENDAS'
GO
ALTER TABLE [PRENDAS]
	ADD CONSTRAINT [FK_PRENDAS_GRUPOPRENDA]
	FOREIGN KEY ([GRUPO]) REFERENCES [GRUPOPRENDA] ([CODIGO])
GO


GO
-- Create Foreign Key FK_PRENDAS_LINEAPRENDAS on PRENDAS
Print 'Create Foreign Key FK_PRENDAS_LINEAPRENDAS on PRENDAS'
GO
ALTER TABLE [PRENDAS]
	ADD CONSTRAINT [FK_PRENDAS_LINEAPRENDAS]
	FOREIGN KEY ([LINEA]) REFERENCES [LINEAPRENDAS] ([CODLINEA])
GO


GO
-- Create Foreign Key FK_PRENDAS_TIPPRENDA on PRENDAS
Print 'Create Foreign Key FK_PRENDAS_TIPPRENDA on PRENDAS'
GO
ALTER TABLE [PRENDAS]
	ADD CONSTRAINT [FK_PRENDAS_TIPPRENDA]
	FOREIGN KEY ([TIPPRENDA]) REFERENCES [TIPPRENDA] ([TIPO])
GO


GO

-- Create Foreign Key FK__HILADO__MONEDA__690797E6 on HILADO
Print 'Create Foreign Key FK__HILADO__MONEDA__690797E6 on HILADO'
GO
ALTER TABLE [HILADO]
	ADD CONSTRAINT [FK__HILADO__MONEDA__690797E6]
	FOREIGN KEY ([MONEDA]) REFERENCES [MONEDAS] ([CODIGO])
GO


GO
-- Create Foreign Key FK__HILADO__UNIDAD__681373AD on HILADO
Print 'Create Foreign Key FK__HILADO__UNIDAD__681373AD on HILADO'
GO
ALTER TABLE [HILADO]
	ADD CONSTRAINT [FK__HILADO__UNIDAD__681373AD]
	FOREIGN KEY ([UNIDAD]) REFERENCES [UNIDADES] ([UNIDAD])
GO


GO

-- Create Foreign Key FK_USR-OPC_PERFILES on USR-OPC
Print 'Create Foreign Key FK_USR-OPC_PERFILES on USR-OPC'
GO
ALTER TABLE [USR-OPC]
	ADD CONSTRAINT [FK_USR-OPC_PERFILES]
	FOREIGN KEY ([PERFIL]) REFERENCES [PERFILES] ([ID])
GO


GO
-- Create Foreign Key FK_USR-OPC_SUBMENU on USR-OPC
Print 'Create Foreign Key FK_USR-OPC_SUBMENU on USR-OPC'
GO
ALTER TABLE [USR-OPC]
	ADD CONSTRAINT [FK_USR-OPC_SUBMENU]
	FOREIGN KEY ([MENU], [SUBMENU]) REFERENCES [SUBMENU] ([MENU], [SUBMENU])
GO


GO
-- Create Foreign Key FK_USR-OPC_USUARIOS on USR-OPC
Print 'Create Foreign Key FK_USR-OPC_USUARIOS on USR-OPC'
GO
ALTER TABLE [USR-OPC]
	ADD CONSTRAINT [FK_USR-OPC_USUARIOS]
	FOREIGN KEY ([USUARIO]) REFERENCES [USUARIOS] ([USUARIO])
GO


GO

-- Create Foreign Key FK_EMPRESA-ADICIONALES_EMPRESAS on EMPRESA-ADICIONALES
Print 'Create Foreign Key FK_EMPRESA-ADICIONALES_EMPRESAS on EMPRESA-ADICIONALES'
GO
ALTER TABLE [EMPRESA-ADICIONALES]
	ADD CONSTRAINT [FK_EMPRESA-ADICIONALES_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO

-- Create Foreign Key FK_ESTILOS_EMPRESAS on ESTILOS
Print 'Create Foreign Key FK_ESTILOS_EMPRESAS on ESTILOS'
GO
ALTER TABLE [ESTILOS]
	ADD CONSTRAINT [FK_ESTILOS_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO

-- Create Foreign Key FK_PRENDADETA_PRENDAS on PRENDADETA
Print 'Create Foreign Key FK_PRENDADETA_PRENDAS on PRENDADETA'
GO
ALTER TABLE [PRENDADETA]
	ADD CONSTRAINT [FK_PRENDADETA_PRENDAS]
	FOREIGN KEY ([PRENDA]) REFERENCES [PRENDAS] ([CODIGO])
GO


GO

-- Create Foreign Key FK__COLORES__CLIENTE__0F2D40CE on COLORES
Print 'Create Foreign Key FK__COLORES__CLIENTE__0F2D40CE on COLORES'
GO
ALTER TABLE [COLORES]
	ADD CONSTRAINT [FK__COLORES__CLIENTE__0F2D40CE]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO
-- Create Foreign Key FK_COLORES_TENIDO on COLORES
Print 'Create Foreign Key FK_COLORES_TENIDO on COLORES'
GO
ALTER TABLE [COLORES]
	ADD CONSTRAINT [FK_COLORES_TENIDO]
	FOREIGN KEY ([TENIDO]) REFERENCES [TENIDO] ([TENIDO])
GO


GO
-- Create Foreign Key FK_COLORES_TONOS on COLORES
Print 'Create Foreign Key FK_COLORES_TONOS on COLORES'
GO
ALTER TABLE [COLORES]
	ADD CONSTRAINT [FK_COLORES_TONOS]
	FOREIGN KEY ([TONO]) REFERENCES [TONOS] ([TONO])
GO


GO

-- Create Foreign Key FK_DIRECCIONES_EMPRESAS on DIRECCIONES
Print 'Create Foreign Key FK_DIRECCIONES_EMPRESAS on DIRECCIONES'
GO
ALTER TABLE [DIRECCIONES]
	ADD CONSTRAINT [FK_DIRECCIONES_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO

-- Create Foreign Key FK_EMPRESA_TALLA_EMPRESAS on EMPRESA_TALLA
Print 'Create Foreign Key FK_EMPRESA_TALLA_EMPRESAS on EMPRESA_TALLA'
GO
ALTER TABLE [EMPRESA_TALLA]
	ADD CONSTRAINT [FK_EMPRESA_TALLA_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO
-- Create Foreign Key FK_EMPRESA_TALLA_TALLAS on EMPRESA_TALLA
Print 'Create Foreign Key FK_EMPRESA_TALLA_TALLAS on EMPRESA_TALLA'
GO
ALTER TABLE [EMPRESA_TALLA]
	ADD CONSTRAINT [FK_EMPRESA_TALLA_TALLAS]
	FOREIGN KEY ([TALLA]) REFERENCES [TALLAS] ([TALLAS])
GO


GO

-- Create Foreign Key FK__TELAS__FAMILIA__2704CA5F on TELAS
Print 'Create Foreign Key FK__TELAS__FAMILIA__2704CA5F on TELAS'
GO
ALTER TABLE [TELAS]
	ADD CONSTRAINT [FK__TELAS__FAMILIA__2704CA5F]
	FOREIGN KEY ([FAMILIA]) REFERENCES [FAMTELAS] ([FAMTELA])
GO


GO
-- Create Foreign Key FK__TELAS__HIL1__29E1370A on TELAS
Print 'Create Foreign Key FK__TELAS__HIL1__29E1370A on TELAS'
GO
ALTER TABLE [TELAS]
	ADD CONSTRAINT [FK__TELAS__HIL1__29E1370A]
	FOREIGN KEY ([HIL1]) REFERENCES [HILADO] ([HILO])
GO


GO
-- Create Foreign Key FK__TELAS__MONEDA__27F8EE98 on TELAS
Print 'Create Foreign Key FK__TELAS__MONEDA__27F8EE98 on TELAS'
GO
ALTER TABLE [TELAS]
	ADD CONSTRAINT [FK__TELAS__MONEDA__27F8EE98]
	FOREIGN KEY ([MONEDA]) REFERENCES [MONEDAS] ([CODIGO])
GO


GO
-- Create Foreign Key FK__TELAS__TIPOTELA__2610A626 on TELAS
Print 'Create Foreign Key FK__TELAS__TIPOTELA__2610A626 on TELAS'
GO
ALTER TABLE [TELAS]
	ADD CONSTRAINT [FK__TELAS__TIPOTELA__2610A626]
	FOREIGN KEY ([TIPOTELA]) REFERENCES [TIPTEL] ([CODIGO])
GO


GO
-- Create Foreign Key FK__TELAS__UNIDAD__28ED12D1 on TELAS
Print 'Create Foreign Key FK__TELAS__UNIDAD__28ED12D1 on TELAS'
GO
ALTER TABLE [TELAS]
	ADD CONSTRAINT [FK__TELAS__UNIDAD__28ED12D1]
	FOREIGN KEY ([UNIDAD]) REFERENCES [UNIDADES] ([UNIDAD])
GO


GO

-- Create Foreign Key FK_TEMPORADAS_EMPRESAS on TEMPORADAS
Print 'Create Foreign Key FK_TEMPORADAS_EMPRESAS on TEMPORADAS'
GO
ALTER TABLE [TEMPORADAS]
	ADD CONSTRAINT [FK_TEMPORADAS_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO

-- Create Foreign Key FK_TELA-OBS_TELAS on TELA-OBS
Print 'Create Foreign Key FK_TELA-OBS_TELAS on TELA-OBS'
GO
ALTER TABLE [TELA-OBS]
	ADD CONSTRAINT [FK_TELA-OBS_TELAS]
	FOREIGN KEY ([TELA]) REFERENCES [TELAS] ([TELA])
GO


GO

-- Create Foreign Key FK_TELACOLOR_COLORES on TELACOLOR
Print 'Create Foreign Key FK_TELACOLOR_COLORES on TELACOLOR'
GO
ALTER TABLE [TELACOLOR]
	ADD CONSTRAINT [FK_TELACOLOR_COLORES]
	FOREIGN KEY ([COLOR]) REFERENCES [COLORES] ([CODIGO])
GO


GO
-- Create Foreign Key FK_TELACOLOR_TELAS on TELACOLOR
Print 'Create Foreign Key FK_TELACOLOR_TELAS on TELACOLOR'
GO
ALTER TABLE [TELACOLOR]
	ADD CONSTRAINT [FK_TELACOLOR_TELAS]
	FOREIGN KEY ([TELA]) REFERENCES [TELAS] ([TELA])
GO


GO

-- Create Foreign Key FK_PROTOS_COTIZACION on PROTOS
Print 'Create Foreign Key FK_PROTOS_COTIZACION on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_COTIZACION]
	FOREIGN KEY ([COTIZACION]) REFERENCES [COTIZACION] ([COTIZACION])
GO


GO
-- Create Foreign Key FK_PROTOS_EMPRESAS on PROTOS
Print 'Create Foreign Key FK_PROTOS_EMPRESAS on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_EMPRESAS]
	FOREIGN KEY ([CLIENTE]) REFERENCES [EMPRESAS] ([CLIENTE])
GO


GO
-- Create Foreign Key FK_PROTOS_ESPECIFICACIONES on PROTOS
Print 'Create Foreign Key FK_PROTOS_ESPECIFICACIONES on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_ESPECIFICACIONES]
	FOREIGN KEY ([ESPECIFICACION]) REFERENCES [ESPECIFICACIONES] ([ESPECIFICACION])
GO


GO
-- Create Foreign Key FK_PROTOS_ESTILOS1 on PROTOS
Print 'Create Foreign Key FK_PROTOS_ESTILOS1 on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_ESTILOS1]
	FOREIGN KEY ([ESTILO], [CLIENTE]) REFERENCES [ESTILOS] ([ESTILO], [CLIENTE])
GO


GO
-- Create Foreign Key FK_PROTOS_GENEROS on PROTOS
Print 'Create Foreign Key FK_PROTOS_GENEROS on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_GENEROS]
	FOREIGN KEY ([GENERO]) REFERENCES [GENEROS] ([GENERO])
GO


GO
-- Create Foreign Key FK_PROTOS_PROPORCIONES on PROTOS
Print 'Create Foreign Key FK_PROTOS_PROPORCIONES on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_PROPORCIONES]
	FOREIGN KEY ([PROPORCION]) REFERENCES [PROPORCIONES] ([PROPORCION])
GO


GO
-- Create Foreign Key FK_PROTOS_PROTO-DETALLES on PROTOS
Print 'Create Foreign Key FK_PROTOS_PROTO-DETALLES on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_PROTO-DETALLES]
	FOREIGN KEY ([PROTO], [VERSION]) REFERENCES [PROTO-DETALLES] ([PROTO], [VERSION])
GO


GO
-- Create Foreign Key FK_PROTOS_TALLAS on PROTOS
Print 'Create Foreign Key FK_PROTOS_TALLAS on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_TALLAS]
	FOREIGN KEY ([TALLAS]) REFERENCES [TALLAS] ([TALLAS])
GO


GO
-- Create Foreign Key FK_PROTOS_TEMPORADAS on PROTOS
Print 'Create Foreign Key FK_PROTOS_TEMPORADAS on PROTOS'
GO
ALTER TABLE [PROTOS]
	ADD CONSTRAINT [FK_PROTOS_TEMPORADAS]
	FOREIGN KEY ([TEMPORADA], [CLIENTE]) REFERENCES [TEMPORADAS] ([CODIGO], [CLIENTE])
GO


GO

-- Create Foreign Key FK_PO-DETA_COLORES on PO-DETA
Print 'Create Foreign Key FK_PO-DETA_COLORES on PO-DETA'
GO
ALTER TABLE [PO-DETA]
	ADD CONSTRAINT [FK_PO-DETA_COLORES]
	FOREIGN KEY ([COLOR]) REFERENCES [COLORES] ([CODIGO])
GO


GO
-- Create Foreign Key FK_PO-DETA_POS on PO-DETA
Print 'Create Foreign Key FK_PO-DETA_POS on PO-DETA'
GO
ALTER TABLE [PO-DETA]
	ADD CONSTRAINT [FK_PO-DETA_POS]
	FOREIGN KEY ([PO]) REFERENCES [POS] ([PO])
GO


GO

-- Create Foreign Key FK_HILOCOL_COLORES on HILOCOL
Print 'Create Foreign Key FK_HILOCOL_COLORES on HILOCOL'
GO
ALTER TABLE [HILOCOL]
	ADD CONSTRAINT [FK_HILOCOL_COLORES]
	FOREIGN KEY ([COLOR]) REFERENCES [COLORES] ([CODIGO])
GO


GO
-- Create Foreign Key FK_HILOCOL_HILADO on HILOCOL
Print 'Create Foreign Key FK_HILOCOL_HILADO on HILOCOL'
GO
ALTER TABLE [HILOCOL]
	ADD CONSTRAINT [FK_HILOCOL_HILADO]
	FOREIGN KEY ([HILO]) REFERENCES [HILADO] ([HILO])
GO


GO

-- Create Foreign Key FK_PROTO-OBS_PROTOS on PROTO-OBS
Print 'Create Foreign Key FK_PROTO-OBS_PROTOS on PROTO-OBS'
GO
ALTER TABLE [PROTO-OBS]
	ADD CONSTRAINT [FK_PROTO-OBS_PROTOS]
	FOREIGN KEY ([PROTO], [VERSION]) REFERENCES [PROTOS] ([PROTO], [VERSION])
GO


GO

-- Create Foreign Key FK_PROTO-TENIDO_PROTOS on PROTO-TENIDO
Print 'Create Foreign Key FK_PROTO-TENIDO_PROTOS on PROTO-TENIDO'
GO
ALTER TABLE [PROTO-TENIDO]
	ADD CONSTRAINT [FK_PROTO-TENIDO_PROTOS]
	FOREIGN KEY ([PROTO], [VERSION]) REFERENCES [PROTOS] ([PROTO], [VERSION])
GO


GO

-- COMMITTING TRANSACTION STRUCTURE
PRINT 'Committing transaction STRUCTURE'
IF @@TRANCOUNT>0
	COMMIT TRANSACTION _STRUCTURE_
GO

SET NOEXEC OFF
GO
-- BEGINNING TRANSACTION DATA
PRINT 'Beginning transaction DATA'
BEGIN TRANSACTION _DATA_
GO
SET NOCOUNT ON
SET ANSI_PADDING ON
GO

-- Disabling all Constraints
Print 'Disabling all Constraints'
exec sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- Disabling all Triggers
Print 'Disabling all Triggers'
exec sp_MSforeachtable 'ALTER TABLE ? DISABLE TRIGGER ALL'

-- Deleting from table: PROTO-OBS
PRINT 'Deleting from table: PROTO-OBS'
DELETE FROM [PROTO-OBS]
-- Deleting from table: PROTO-TENIDO
PRINT 'Deleting from table: PROTO-TENIDO'
DELETE FROM [PROTO-TENIDO]
-- Deleting from table: TELACOLOR
PRINT 'Deleting from table: TELACOLOR'
DELETE FROM [TELACOLOR]
-- Deleting from table: PROTOS
PRINT 'Deleting from table: PROTOS'
DELETE FROM [PROTOS]
-- Deleting from table: TELA-OBS
PRINT 'Deleting from table: TELA-OBS'
DELETE FROM [TELA-OBS]
-- Deleting from table: PO-DETA
PRINT 'Deleting from table: PO-DETA'
DELETE FROM [PO-DETA]
-- Deleting from table: HILOCOL
PRINT 'Deleting from table: HILOCOL'
DELETE FROM [HILOCOL]
-- Deleting from table: USR-OPC
PRINT 'Deleting from table: USR-OPC'
DELETE FROM [USR-OPC]
-- Deleting from table: ESTILOS
PRINT 'Deleting from table: ESTILOS'
DELETE FROM [ESTILOS]
-- Deleting from table: TEMPORADAS
PRINT 'Deleting from table: TEMPORADAS'
DELETE FROM [TEMPORADAS]
-- Deleting from table: TELAS
PRINT 'Deleting from table: TELAS'
DELETE FROM [TELAS]
-- Deleting from table: PRENDADETA
PRINT 'Deleting from table: PRENDADETA'
DELETE FROM [PRENDADETA]
-- Deleting from table: DIRECCIONES
PRINT 'Deleting from table: DIRECCIONES'
DELETE FROM [DIRECCIONES]
-- Deleting from table: EMPRESA_TALLA
PRINT 'Deleting from table: EMPRESA_TALLA'
DELETE FROM [EMPRESA_TALLA]
-- Deleting from table: EMPRESA-ADICIONALES
PRINT 'Deleting from table: EMPRESA-ADICIONALES'
DELETE FROM [EMPRESA-ADICIONALES]
-- Deleting from table: COLORES
PRINT 'Deleting from table: COLORES'
DELETE FROM [COLORES]
-- Deleting from table: POS
PRINT 'Deleting from table: POS'
DELETE FROM [POS]
-- Deleting from table: SUBMENU
PRINT 'Deleting from table: SUBMENU'
DELETE FROM [SUBMENU]
-- Deleting from table: PRENDAS
PRINT 'Deleting from table: PRENDAS'
DELETE FROM [PRENDAS]
-- Deleting from table: AVIOS
PRINT 'Deleting from table: AVIOS'
DELETE FROM [AVIOS]
-- Deleting from table: SERVICIOS
PRINT 'Deleting from table: SERVICIOS'
DELETE FROM [SERVICIOS]
-- Deleting from table: PROTO-MEDIDA
PRINT 'Deleting from table: PROTO-MEDIDA'
DELETE FROM [PROTO-MEDIDA]
-- Deleting from table: HILADO
PRINT 'Deleting from table: HILADO'
DELETE FROM [HILADO]
-- Deleting from table: EMPRESAS
PRINT 'Deleting from table: EMPRESAS'
DELETE FROM [EMPRESAS]
-- Deleting from table: TALLAS
PRINT 'Deleting from table: TALLAS'
DELETE FROM [TALLAS]
-- Deleting from table: TIPAVI
PRINT 'Deleting from table: TIPAVI'
DELETE FROM [TIPAVI]
-- Deleting from table: TENIDO
PRINT 'Deleting from table: TENIDO'
DELETE FROM [TENIDO]
-- Deleting from table: MATERIA-PRIMA
PRINT 'Deleting from table: MATERIA-PRIMA'
DELETE FROM [MATERIA-PRIMA]
-- Deleting from table: FAMAVIOS
PRINT 'Deleting from table: FAMAVIOS'
DELETE FROM [FAMAVIOS]
-- Deleting from table: FAMTELAS
PRINT 'Deleting from table: FAMTELAS'
DELETE FROM [FAMTELAS]
-- Deleting from table: ESPECIFICACIONES
PRINT 'Deleting from table: ESPECIFICACIONES'
DELETE FROM [ESPECIFICACIONES]
-- Deleting from table: RECTILINEOS
PRINT 'Deleting from table: RECTILINEOS'
DELETE FROM [RECTILINEOS]
-- Deleting from table: TONOS
PRINT 'Deleting from table: TONOS'
DELETE FROM [TONOS]
-- Deleting from table: TIPTEL
PRINT 'Deleting from table: TIPTEL'
DELETE FROM [TIPTEL]
-- Deleting from table: USUARIOS
PRINT 'Deleting from table: USUARIOS'
DELETE FROM [USUARIOS]
-- Deleting from table: UNIDADES
PRINT 'Deleting from table: UNIDADES'
DELETE FROM [UNIDADES]
-- Deleting from table: TIPREND
PRINT 'Deleting from table: TIPREND'
DELETE FROM [TIPREND]
-- Deleting from table: TIPOCLI
PRINT 'Deleting from table: TIPOCLI'
DELETE FROM [TIPOCLI]
-- Deleting from table: TIPEXPLO
PRINT 'Deleting from table: TIPEXPLO'
DELETE FROM [TIPEXPLO]
-- Deleting from table: TIPPRENDA
PRINT 'Deleting from table: TIPPRENDA'
DELETE FROM [TIPPRENDA]
-- Deleting from table: TIPOSERVICIO
PRINT 'Deleting from table: TIPOSERVICIO'
DELETE FROM [TIPOSERVICIO]
-- Deleting from table: PAISES
PRINT 'Deleting from table: PAISES'
DELETE FROM [PAISES]
-- Deleting from table: MONEDAS
PRINT 'Deleting from table: MONEDAS'
DELETE FROM [MONEDAS]
-- Deleting from table: PARAMETROS
PRINT 'Deleting from table: PARAMETROS'
DELETE FROM [PARAMETROS]
-- Deleting from table: LINEAPRENDAS
PRINT 'Deleting from table: LINEAPRENDAS'
DELETE FROM [LINEAPRENDAS]
-- Deleting from table: PERFILES
PRINT 'Deleting from table: PERFILES'
DELETE FROM [PERFILES]
-- Deleting from table: MEDIDAS
PRINT 'Deleting from table: MEDIDAS'
DELETE FROM [MEDIDAS]
-- Deleting from table: MATRIZ_PROTO
PRINT 'Deleting from table: MATRIZ_PROTO'
DELETE FROM [MATRIZ_PROTO]
-- Deleting from table: MENU
PRINT 'Deleting from table: MENU'
DELETE FROM [MENU]
-- Deleting from table: MERMAS
PRINT 'Deleting from table: MERMAS'
DELETE FROM [MERMAS]
-- Deleting from table: MERCADOS
PRINT 'Deleting from table: MERCADOS'
DELETE FROM [MERCADOS]
-- Deleting from table: PO-OBS
PRINT 'Deleting from table: PO-OBS'
DELETE FROM [PO-OBS]
-- Deleting from table: PROPORCIONES
PRINT 'Deleting from table: PROPORCIONES'
DELETE FROM [PROPORCIONES]
-- Deleting from table: GRUPOPRENDA
PRINT 'Deleting from table: GRUPOPRENDA'
DELETE FROM [GRUPOPRENDA]
-- Deleting from table: COTIZACION
PRINT 'Deleting from table: COTIZACION'
DELETE FROM [COTIZACION]
-- Deleting from table: PROTO-DETALLES
PRINT 'Deleting from table: PROTO-DETALLES'
DELETE FROM [PROTO-DETALLES]
-- Deleting from table: DESTINATARIOS
PRINT 'Deleting from table: DESTINATARIOS'
DELETE FROM [DESTINATARIOS]
-- Deleting from table: GENEROS
PRINT 'Deleting from table: GENEROS'
DELETE FROM [GENEROS]
-- Deleting from table: sysdiagrams
PRINT 'Deleting from table: sysdiagrams'
DELETE FROM [dbo].[sysdiagrams]

-- Insert scripts for table: sysdiagrams
PRINT 'Inserting rows into table: sysdiagrams'
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON

INSERT INTO [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version]) VALUES (N'SEGURIDAD', 6, 1, 1)
INSERT INTO [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version]) VALUES (N'DIAGRAMA INICIAL', 6, 2, 1)

SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF

-- Insert scripts for table: PROPORCIONES
PRINT 'Inserting rows into table: PROPORCIONES'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [PROPORCIONES] ([PROPORCION], [PROP0], [PROP1], [PROP2], [PROP3], [PROP4], [PROP5], [PROP6], [PROP7], [PROP8], [PROP9], [USUARIO]) VALUES ('000', '1', '2', '1', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [PROPORCIONES] ([PROPORCION], [PROP0], [PROP1], [PROP2], [PROP3], [PROP4], [PROP5], [PROP6], [PROP7], [PROP8], [PROP9], [USUARIO]) VALUES ('001', '2', '2', '1', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [PROPORCIONES] ([PROPORCION], [PROP0], [PROP1], [PROP2], [PROP3], [PROP4], [PROP5], [PROP6], [PROP7], [PROP8], [PROP9], [USUARIO]) VALUES ('002', '1', '', '', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [PROPORCIONES] ([PROPORCION], [PROP0], [PROP1], [PROP2], [PROP3], [PROP4], [PROP5], [PROP6], [PROP7], [PROP8], [PROP9], [USUARIO]) VALUES ('003', '1', '2', '2', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [PROPORCIONES] ([PROPORCION], [PROP0], [PROP1], [PROP2], [PROP3], [PROP4], [PROP5], [PROP6], [PROP7], [PROP8], [PROP9], [USUARIO]) VALUES ('004', '2', '3', '3', '', '', '', '', '', '', '', 'SISTEMAS')

-- No rows are in PROTO-DETALLES
PRINT 'No rows are in PROTO-DETALLES'
-- Insert scripts for table: USUARIOS
PRINT 'Inserting rows into table: USUARIOS'
INSERT INTO [USUARIOS] ([USUARIO], [CLAVE], [NOMBRES]) VALUES ('DEMO', 'DEMO', 'DEMOSTRACION')
INSERT INTO [USUARIOS] ([USUARIO], [CLAVE], [NOMBRES]) VALUES ('SISTEMAS', 'C4R4M3L1T0', 'SISTEMAS')

-- Insert scripts for table: TIPOCLI
PRINT 'Inserting rows into table: TIPOCLI'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPOCLI] ([TIPO], [DESCRIPCION], [USUARIO]) VALUES ('E', 'EXPORTACION', 'SISTEMAS')
INSERT INTO [TIPOCLI] ([TIPO], [DESCRIPCION], [USUARIO]) VALUES ('L', 'LOCAL', 'SISTEMAS')

-- Insert scripts for table: TIPPRENDA
PRINT 'Inserting rows into table: TIPPRENDA'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPPRENDA] ([TIPO], [DESCRIPCION], [USUARIO]) VALUES ('01', 'T-SHIRT', 'SISTEMAS')
INSERT INTO [TIPPRENDA] ([TIPO], [DESCRIPCION], [USUARIO]) VALUES ('02', 'POLO BOX', 'SISTEMAS')
INSERT INTO [TIPPRENDA] ([TIPO], [DESCRIPCION], [USUARIO]) VALUES ('03', 'V NECK', 'SISTEMAS')

-- Insert scripts for table: PERFILES
PRINT 'Inserting rows into table: PERFILES'
INSERT INTO [PERFILES] ([ID], [PERFIL]) VALUES ('1', N'UPDATER')
INSERT INTO [PERFILES] ([ID], [PERFIL]) VALUES ('2', N'READONLY')

-- Insert scripts for table: TIPOSERVICIO
PRINT 'Inserting rows into table: TIPOSERVICIO'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPOSERVICIO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('001', 'PRENDA', 'SISTEMAS')
INSERT INTO [TIPOSERVICIO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('002', 'TELA', 'SISTEMAS')
INSERT INTO [TIPOSERVICIO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('003', 'PIEZA', 'SISTEMAS')
INSERT INTO [TIPOSERVICIO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('004', 'HILO', 'SISTEMAS')

-- Insert scripts for table: TIPTEL
PRINT 'Inserting rows into table: TIPTEL'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPTEL] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('E', 'COLOR ENTERO', 'SISTEMAS')
INSERT INTO [TIPTEL] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('J', 'JACQUARD', 'SISTEMAS')
INSERT INTO [TIPTEL] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('L', 'LISTADO', 'SISTEMAS')

-- Insert scripts for table: TIPAVI
PRINT 'Inserting rows into table: TIPAVI'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPAVI] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('A', 'ACABADOS', 'SISTEMAS')
INSERT INTO [TIPAVI] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('C', 'COSTURA', 'SISTEMAS')
INSERT INTO [TIPAVI] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('K', 'CORTE', 'SISTEMAS')

-- Insert scripts for table: TENIDO
PRINT 'Inserting rows into table: TENIDO'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('01', 'CLARO DIRECTO', 'SISTEMAS', 90.0E-1, 13.6E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('02', 'MEDIO DIRECTO', 'SISTEMAS', 70.0E-1, 20.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('03', 'OSCURO DIRECTO', 'SISTEMAS', 60.0E-1, 28.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('04', 'CLARO REACTIVO', 'SISTEMAS', 80.0E-1, 28.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('05', 'MEDIO REACTIVO', 'SISTEMAS', 70.0E-1, 34.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('06', 'OSCURO REACTIVO', 'SISTEMAS', 60.0E-1, 39.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('07', 'ESPECIALES - TEÑIDO EN PRENDA', 'SISTEMAS', 00.0E+0, 45.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('08', 'DISPERSO CLARO - FIBRA POLIESTER', 'SISTEMAS', 70.0E-1, 30.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('09', 'DOBLE TEÑIDO OSCURO ALGODON POLIESTER', 'SISTEMAS', 40.0E-1, 48.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('10', 'HEATHER MELANGE', 'SISTEMAS', 00.0E+0, 00.0E+0)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('11', 'DISPERSO MEDIO - FIBRA POLIESTER', 'SISTEMAS', 60.0E-1, 35.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('12', 'DISPERSO OSCURO - FIBRA POLIESTER', 'SISTEMAS', 50.0E-1, 40.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('13', 'DOBLE TEÑIDO MEDIO ALGODON POLIESTER', 'SISTEMAS', 50.0E-1, 45.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('14', 'DOBLE TEÑIDO CLARO ALGODON POLIESTER', 'SISTEMAS', 50.0E-1, 42.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('16', 'BLANCO OPTICO', 'SISTEMAS', 80.0E-1, 10.0E-1)
INSERT INTO [TENIDO] ([TENIDO], [DESTENIDO], [USUARIO], [MERMA], [COSTOKG]) VALUES ('88', 'TEÑIDO EN HILO', 'SISTEMAS', 00.0E+0, 00.0E+0)

-- Insert scripts for table: TALLAS
PRINT 'Inserting rows into table: TALLAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TALLAS] ([TALLAS], [TALLA0], [TALLA1], [TALLA2], [TALLA3], [TALLA4], [TALLA5], [TALLA6], [TALLA7], [TALLA8], [TALLA9], [USUARIO]) VALUES ('000', 'S', 'M', 'L', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [TALLAS] ([TALLAS], [TALLA0], [TALLA1], [TALLA2], [TALLA3], [TALLA4], [TALLA5], [TALLA6], [TALLA7], [TALLA8], [TALLA9], [USUARIO]) VALUES ('001', 'XS', 'S', '', '', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [TALLAS] ([TALLAS], [TALLA0], [TALLA1], [TALLA2], [TALLA3], [TALLA4], [TALLA5], [TALLA6], [TALLA7], [TALLA8], [TALLA9], [USUARIO]) VALUES ('002', '36', '38', '40', '42', '', '', '', '', '', '', 'SISTEMAS')
INSERT INTO [TALLAS] ([TALLAS], [TALLA0], [TALLA1], [TALLA2], [TALLA3], [TALLA4], [TALLA5], [TALLA6], [TALLA7], [TALLA8], [TALLA9], [USUARIO]) VALUES ('003', 'TU', '', '', '', '', '', '', '', '', '', 'SISTEMAS')

-- Insert scripts for table: TIPEXPLO
PRINT 'Inserting rows into table: TIPEXPLO'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TIPEXPLO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('C', 'COLOR', 'SISTEMAS')
INSERT INTO [TIPEXPLO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('CT', 'COLOR Y TALLA', 'SISTEMAS')
INSERT INTO [TIPEXPLO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('G', 'GENERAL', 'SISTEMAS')
INSERT INTO [TIPEXPLO] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('T', 'TALLA', 'SISTEMAS')

-- Insert scripts for table: TONOS
PRINT 'Inserting rows into table: TONOS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('00', 'BLANCO', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('01', 'NATURAL BEIGE IVORY', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('02', 'AMARILLO NARANJA', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('03', 'PASTELES', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('04', 'ROJO GUINDA FUCSIA', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('05', 'AZUL TURQUEZA', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('06', 'VIOLETA MORADO LILA', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('07', 'VERDE', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('08', 'MARRON', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('09', 'GRIS', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('10', 'NEGRO', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('11', 'HEATHER - MELANGE', 'SISTEMAS', NULL)
INSERT INTO [TONOS] ([TONO], [DESTONO], [USUARIO], [HEXCOLOR]) VALUES ('88', 'LISTADO', 'SISTEMAS', NULL)

-- Insert scripts for table: UNIDADES
PRINT 'Inserting rows into table: UNIDADES'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('CT', 'CIENTO', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('GR', 'GRUESA', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('JG', 'JUEGO', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('KG', 'KILOS', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('LT', 'LITRO', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('MT', 'METROS', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('PP', 'PAR', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('RL', 'ROLLO', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('UN', 'UNIDAD', 'SISTEMAS')
INSERT INTO [UNIDADES] ([UNIDAD], [DESCRIPCION], [USUARIO]) VALUES ('YD', 'YARDA', 'SISTEMAS')

-- Insert scripts for table: PARAMETROS
PRINT 'Inserting rows into table: PARAMETROS'
INSERT INTO [PARAMETROS] ([ADMIN], [IGV], [CAL1], [CAL2], [MINORISTA], [HITEPIMA], [CLAVEINGE], [OPERCORTE], [OPERCOSTURA], [CLAVETEJE], [OPERTEJE], [CLAVEACABADO], [COTIZA], [CODTEJIDO], [VISA], [DCTOEMP], [UTILIDAD], [TIPCAM], [FAL], [TOPEEMP], [TOPEOBR], [TOPEEJE], [bordado], [estampado], [lavado], [tenido], [BLOQUE_ACABAD], [BLOQUE_ZURCID], [BLOQUE_DESMAN], [BLOQUE_DESCON], [BLOQUE_SEGUN], [RUC], [SALIDAS], [utilidad2]) VALUES ('SISTEMAS', 3, 10, 30, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 50.0E-1, 20.0E+0, 25.0E+0, 30.0E-1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

-- Insert scripts for table: GRUPOPRENDA
PRINT 'Inserting rows into table: GRUPOPRENDA'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [GRUPOPRENDA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('D', 'DESARROLLOS', 'SISTEMAS')
INSERT INTO [GRUPOPRENDA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('E', 'EXPORTACION', 'SISTEMAS')
INSERT INTO [GRUPOPRENDA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('S', 'SALDOS', 'SISTEMAS')

-- Insert scripts for table: GENEROS
PRINT 'Inserting rows into table: GENEROS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [GENEROS] ([GENERO], [DESCRIPCION], [USUARIO]) VALUES ('A', 'MENS', 'SISTEMAS')
INSERT INTO [GENEROS] ([GENERO], [DESCRIPCION], [USUARIO]) VALUES ('C', 'CABALLERO', 'SISTEMAS')
INSERT INTO [GENEROS] ([GENERO], [DESCRIPCION], [USUARIO]) VALUES ('J', 'JUNIOR', 'SISTEMAS')
INSERT INTO [GENEROS] ([GENERO], [DESCRIPCION], [USUARIO]) VALUES ('N', 'NIÑO', 'SISTEMAS')
INSERT INTO [GENEROS] ([GENERO], [DESCRIPCION], [USUARIO]) VALUES ('W', 'WOMEN', 'SISTEMAS')

-- Insert scripts for table: MATERIA-PRIMA
PRINT 'Inserting rows into table: MATERIA-PRIMA'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [MATERIA-PRIMA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('APP', 'ALGODON PIMA PEINADO', 'SISTEMAS')
INSERT INTO [MATERIA-PRIMA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('ATC', 'ALGODON TANGUIS CARDADO', 'SISTEMAS')
INSERT INTO [MATERIA-PRIMA] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('ATP', 'ALGODON TANGUIS PEINADO', 'SISTEMAS')

-- Insert scripts for table: LINEAPRENDAS
PRINT 'Inserting rows into table: LINEAPRENDAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [LINEAPRENDAS] ([CODLINEA], [DESCRIPCION], [USUARIO]) VALUES ('G', 'ARTICULOS DE EXPORTACION', 'SISTEMAS')
INSERT INTO [LINEAPRENDAS] ([CODLINEA], [DESCRIPCION], [USUARIO]) VALUES ('M', 'MUESTRAS', 'SISTEMAS')
INSERT INTO [LINEAPRENDAS] ([CODLINEA], [DESCRIPCION], [USUARIO]) VALUES ('P', 'PROTOTIPOS', 'SISTEMAS')

-- Insert scripts for table: FAMTELAS
PRINT 'Inserting rows into table: FAMTELAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('00', 'DESARROLLOS', 0.0, 'SISTEMAS', 60.0E-2)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('01', 'JERSEY', 10002.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('02', 'POLIESTER', 20000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('03', 'PIQUE', 30000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('04', 'FRANELA', 40000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('05', 'JAQCUARD', 50000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('06', 'INTERLOCK', 60000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('07', 'RIB', 70000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('08', 'OTTOMAN', 80000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('09', 'WAFFLE', 85000.0, 'SISTEMAS', 00.0E+0)
INSERT INTO [FAMTELAS] ([FAMTELA], [DESCRIPCION], [CORREL], [USUARIO], [COSTO]) VALUES ('10', 'RECTILINEOS', 90000.0, 'SISTEMAS', 00.0E+0)


-- Insert scripts for table: FAMAVIOS
PRINT 'Inserting rows into table: FAMAVIOS'
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('.', '.', 00.0E+0, 00.0E+0, 'C', 'SISTEMAS', '20080830 20:18:00.000', 'A', '')
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('10', 'BOTONES', 50.0E-1, 10.00007E+5, 'C', 'SISTEMAS', '20080830 20:23:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('11', 'BROCHE', 50.0E-1, 11.0E+5, 'A', 'SISTEMAS', '20080830 20:23:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('12', 'OJALILLOS', 50.0E-1, 12.0E+5, 'C', 'SISTEMAS', '20080830 20:24:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('13', 'REMACHES', 50.0E-1, 13.0E+5, 'C', 'SISTEMAS', '20080830 20:24:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('14', 'TOPES', 10.0E+0, 14.0E+5, 'C', 'SISTEMAS', '20080830 20:24:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('15', 'APLICACIONES', 50.0E-1, 15.0E+5, 'C', 'SISTEMAS', '20080830 20:25:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('16', 'ETIQUETA M/T/C/C/O', 30.0E-1, 16.0E+5, 'C', 'SISTEMAS', '20080830 20:25:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('17', 'ETIQUETA DE CONTENIDO', 50.0E-1, 17.0E+5, 'C', 'SISTEMAS', '20080830 20:26:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('18', 'COMPLEMENTOS - ADORNOS', 10.0E+0, 18.0E+5, 'C', 'SISTEMAS', '20080830 20:26:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('19', 'ETIQUETA AUTOADHESIVA', 30.0E-1, 19.0E+5, 'C', 'SISTEMAS', '20080830 20:27:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('20', 'BOLSA', 50.0E-1, 20.0E+5, 'A', 'SISTEMAS', '20080830 20:27:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('21', 'PAPEL DE SEDA', 30.0E-1, 21.0E+5, 'A', 'SISTEMAS', '20080830 20:27:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('22', 'ALFILER', 30.0E-1, 22.0E+5, 'A', 'SISTEMAS', '20080830 20:27:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('23', 'CLIP', 30.0E-1, 23.0E+5, 'A', 'SISTEMAS', '20080830 20:27:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('24', 'COLGADOR', 50.0E-1, 24.0E+5, 'A', 'SISTEMAS', '20080830 20:28:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('25', 'ALMA DE CARTON', 50.0E-1, 25.0E+5, 'A', 'SISTEMAS', '20080830 20:28:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('26', 'PRICE TICKETS', 30.0E-1, 26.0E+5, 'A', 'SISTEMAS', '20080830 20:29:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('28', 'CINTA MOBILON', 10.0E-1, 28.0E+5, 'C', 'SISTEMAS', '20080830 20:29:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('29', 'CINTA DE EMBLAJE', 10.0E-1, 29.0E+5, 'A', 'SISTEMAS', '20080830 20:29:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('30', 'CIERRE', 50.0E-1, 30.00002E+5, 'C', 'SISTEMAS', '20080830 00:00:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('32', 'ETIQUETA TAB LABEL', 50.0E-1, 32.0E+5, 'C', 'SISTEMAS', '20080830 20:33:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('33', 'CINTA EN CRUDO', 10.0E+0, 33.0E+5, 'C', 'SISTEMAS', '20080830 20:34:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('34', 'ETIQUETA DE ESTILO', 30.0E-1, 34.0E+5, 'C', 'SISTEMAS', '20080830 20:34:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('35', 'HILO MACRAME', 10.0E+0, 35.0E+5, 'A', 'SISTEMAS', '20080830 20:34:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('36', 'IMPERDIBLES', 20.0E-1, 36.0E+5, 'A', 'SISTEMAS', '20080830 20:35:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('37', 'TELA PLANA ACABADA/LISTADA/ESTAMPADA', 20.0E-1, 37.0E+5, 'C', 'SISTEMAS', '20080830 20:35:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('38', 'TELA PLANA CRUDO', 10.0E+0, 38.0E+5, 'K', 'SISTEMAS', '20080830 20:36:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('39', 'CAJA INDIVIDUAL PARA PRENDA', 50.0E-1, 39.0E+5, 'A', 'SISTEMAS', '20080830 20:36:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('40', 'CORDON CRUDO', 10.0E+0, 40.0E+5, 'A', 'SISTEMAS', '20080830 20:36:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('41', 'LAVADO Y ACABADOS ESPECIALES', 10.0E+0, 41.0E+5, 'C', 'SISTEMAS', '20080830 20:37:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('42', 'TWILL CRUDO', 30.0E+0, 42.0E+5, 'K', 'SISTEMAS', '20080830 20:37:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('43', 'ENTRETELA', 10.0E+0, 43.0E+5, 'K', 'SISTEMAS', '20080830 20:37:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('44', 'TEÑIDOS EN PAÑO', 10.0E+0, 44.0E+5, 'K', 'SISTEMAS', '20080830 20:38:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('50', 'ELASTICO', 10.0E+0, 50.0E+5, 'C', 'SISTEMAS', '20080830 20:38:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('51', 'BORDADOS', 30.0E-1, 51.0E+5, 'K', 'SISTEMAS', '20080830 20:38:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('52', 'ESTAMPADOS', 50.0E-1, 52.0E+5, 'K', 'SISTEMAS', '20080830 20:39:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('60', 'ETIQUETA DE MARCA', 50.0E-1, 60.0E+5, 'C', 'SISTEMAS', '20080830 20:39:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('61', 'ETIQUETA DE TALLA', 50.0E-1, 61.0E+5, 'C', 'SISTEMAS', '20080830 20:39:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('62', 'HILO DE COSTURA EN KILOS', 50.0E-1, 62.0E+5, 'C', 'SISTEMAS', '20080830 20:40:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('70', 'HILO DE COSTURA', 00.0E+0, 70.00001E+5, 'C', 'SISTEMAS', '20080830 20:40:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('71', 'HILO DE BORDAR', 10.0E+0, 71.0E+5, 'C', 'SISTEMAS', '20080830 20:40:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('80', 'HANG TAG', 50.0E-1, 80.0E+5, 'A', 'SISTEMAS', '20080830 20:40:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('81', 'PRICE STICKER', 50.0E-1, 81.0E+5, 'A', 'SISTEMAS', '20080830 20:41:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('82', 'CARATULA', 50.0E-1, 82.0E+5, 'A', 'SISTEMAS', '20080830 20:41:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('83', 'SUJETADOR', 30.0E-1, 83.0E+5, 'A', 'SISTEMAS', '20080830 20:41:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('84', 'BLONDA ELASTICA', 10.0E+0, 84.0E+5, 'C', 'SISTEMAS', '20080830 20:42:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('90', 'CAJA DE EMBALAJE', 30.0E-1, 90.0E+5, 'A', 'SISTEMAS', '20080830 20:42:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('91', 'MANGA PLASTICA', 30.0E-1, 91.0E+5, 'A', 'SISTEMAS', '20080830 20:42:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('92', 'SUNCHO', 30.0E-1, 92.0E+5, 'A', 'SISTEMAS', '20080830 20:43:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('93', 'GRAPA DE METAL', 30.0E-1, 93.0E+5, 'A', 'SISTEMAS', '20080830 20:43:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('94', 'UPC STICKER', 50.0E-1, 94.0E+5, 'A', 'SISTEMAS', '20080830 20:43:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('95', 'MUESTRAS DE AVIOS', 20.0E+0, 95.0E+5, 'A', 'SISTEMAS', '20080830 20:44:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('97', 'STICKER PARA BOLSA', 00.0E+0, 97.0E+5, 'A', 'SISTEMAS', '20080830 20:44:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('98', 'ESTUCHE PLASTICO', 10.0E-1, 98.0E+5, 'A', 'SISTEMAS', '20080830 20:45:00.000', 'A', NULL)
INSERT INTO [FAMAVIOS] ([CODIGO], [DESCRIPCION], [PORMER], [CORREL], [TIPOAVIO], [USUARIO], [FECHA], [ESTADO], [CUENTA]) VALUES ('99', 'AVIOS GENERICOS', 10.0E+0, 99.0E+5, 'C', 'SISTEMAS', '20080830 20:45:00.000', 'A', NULL)


-- Insert scripts for table: MERCADOS
PRINT 'Inserting rows into table: MERCADOS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [MERCADOS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('CAN', 'COMUNIDAD ANDINA', 'SISTEMAS')
INSERT INTO [MERCADOS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('LOC', 'MERCADO LOCAL', 'SISTEMAS')
INSERT INTO [MERCADOS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('MCE', 'MERCADO COMUN EUROPEO', 'SISTEMAS')
INSERT INTO [MERCADOS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('USA', 'NORTE AMERICA', 'SISTEMAS')

-- Insert scripts for table: MENU
PRINT 'Inserting rows into table: MENU'
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('1', '2', 'TABLAS GENERALES', 'SUBMENU.ASP?TIPO=1', NULL, 'A')
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('2', '3', 'DDP', 'SUBMENU.ASP?TIPO=2', NULL, 'A')
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('3', NULL, 'MAESTROS', 'SUBMENU.ASP?TIPO=3', NULL, 'A')
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('4', NULL, 'COMERCIAL', 'SUBMENU.ASP?TIPO=4', NULL, 'A')
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('5', NULL, 'REPORTES', 'SUBMENU.ASP?TIPO=5', NULL, 'A')
INSERT INTO [MENU] ([MENU], [PERFIL], [DESMENU], [PROGRAMA], [FOTO], [ESTADO]) VALUES ('9', '3', 'ADMINISTRACION - SISTEMAS', 'SUBMENU.ASP?TIPO=9', NULL, 'A')

-- Insert scripts for table: MERMAS
PRINT 'Inserting rows into table: MERMAS'
INSERT INTO [MERMAS] ([SERVICIOS], [TELAS], [AVIOS], [HILO], [TEJIDO], [TENIDO], [USUARIO], [FECHA], [ESTADO], [CORTE], [ACABADO], [COSTURA], [EMBALAJE], [ENCONADO]) VALUES (10.0E+0, 50.0E-1, 10.0E+0, 60.0E-1, 20.0E-1, 30.0E-1, 'SISTEMAS', '20080830 23:27:00.000', 'A', 30.0E-1, 10.0E-1, 20.0E-1, 10.0E-1, '2')

-- Insert scripts for table: PAISES
PRINT 'Inserting rows into table: PAISES'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('BRA', 'BRASIL', 'SISTEMAS')
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('CAN', 'CANADA', 'SISTEMAS')
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('CHI', 'CHILE', 'SISTEMAS')
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('GER', 'ALEMANIA', 'SISTEMAS')
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('PER', 'PERU', 'SISTEMAS')
INSERT INTO [PAISES] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('USA', 'ESTADOS UNIDOS DE AMERICA', 'SISTEMAS')

-- Insert scripts for table: MONEDAS
PRINT 'Inserting rows into table: MONEDAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [MONEDAS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('S', 'SOLES', 'SISTEMAS')
INSERT INTO [MONEDAS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('D', 'DOLARES', 'SISTEMAS')
INSERT INTO [MONEDAS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('E', 'EUROS', 'SISTEMAS')

-- Insert scripts for table: MEDIDAS
PRINT 'Inserting rows into table: MEDIDAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [MEDIDAS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('001', 'LARGO BAJO MANGA', 'SISTEMAS')
INSERT INTO [MEDIDAS] ([CODIGO], [DESCRIPCION], [USUARIO]) VALUES ('002', 'ANCHO FALDON', 'SISTEMAS')

-- Insert scripts for table: AVIOS
PRINT 'Inserting rows into table: AVIOS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [AVIOS] ([CODIGO], [DESCRIPCION], [UNIDAD], [MONEDA], [COSTO], [FAMAVI], [USUARIO], [TIPEXPLO], [STAT]) VALUES ('1000001', 'BOTÓN 18L 2H PLASTICO COLOR C/LOGO RGM', 'UN', 'D', 33.0E-4, '10', 'SISTEMAS', 'C', NULL)
INSERT INTO [AVIOS] ([CODIGO], [DESCRIPCION], [UNIDAD], [MONEDA], [COSTO], [FAMAVI], [USUARIO], [TIPEXPLO], [STAT]) VALUES ('3000001', 'CIERRE PLASTICO AJ9 1030 16 CM CMS  PLATA  A/X', 'UN', 'D', 98.0E-2, '30', 'SISTEMAS', 'CT', NULL)
INSERT INTO [AVIOS] ([CODIGO], [DESCRIPCION], [UNIDAD], [MONEDA], [COSTO], [FAMAVI], [USUARIO], [TIPEXPLO], [STAT]) VALUES ('3000002', 'CIERRE PLASTICO AJ9 1030 20 CM CMS  PLATA  A/X', 'UN', 'D', 98.0E-2, '30', 'SISTEMAS', 'CT', NULL)
INSERT INTO [AVIOS] ([CODIGO], [DESCRIPCION], [UNIDAD], [MONEDA], [COSTO], [FAMAVI], [USUARIO], [TIPEXPLO], [STAT]) VALUES ('7000001', 'HILODECOSTURA SPUN 40/1 TREN 5698', 'MT', 'D', 50.0E-4, '70', 'SISTEMAS', 'C', NULL)

-- Insert scripts for table: EMPRESAS
PRINT 'Inserting rows into table: EMPRESAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [EMPRESAS] ([CLIENTE], [RUC], [NOMBRE], [DIRECCION], [CIUDAD], [ZONA], [PAIS], [TIPO], [FAX], [TELEFONO], [USUARIO], [CELULAR], [GRUPO], [LISTA], [VENDEDOR], [SIGLA]) VALUES ('000000', '00000000000', 'RAGMAN TEXTILE RGM', 'KUPFERSCHMIDSTRASSE 84', 'WALDSHUT TIENGEN', 'MCE', 'GER', 'E', '', '', 'SISTEMAS', NULL, NULL, NULL, NULL, NULL)
INSERT INTO [EMPRESAS] ([CLIENTE], [RUC], [NOMBRE], [DIRECCION], [CIUDAD], [ZONA], [PAIS], [TIPO], [FAX], [TELEFONO], [USUARIO], [CELULAR], [GRUPO], [LISTA], [VENDEDOR], [SIGLA]) VALUES ('000001', '00000000000', 'ARMANI EXCHANGE', '41 EAST 11TH STREET 11TH FLOOR NY', 'NEW YORK', 'USA', 'PER', 'E', '001 212 9056002', '001 212 9056003/4/5/10', 'SISTEMAS', NULL, NULL, NULL, NULL, NULL)

-- Insert scripts for table: SERVICIOS
PRINT 'Inserting rows into table: SERVICIOS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [SERVICIOS] ([CODIGO], [DESCRIPCION], [TIPO], [COSTO], [MONEDA], [UNIDAD], [USUARIO], [MERMA]) VALUES ('000000', 'TEJIDO', '004', 15.6E-1, 'D', 'KG', 'SISTEMAS', 20.0E-1)
INSERT INTO [SERVICIOS] ([CODIGO], [DESCRIPCION], [TIPO], [COSTO], [MONEDA], [UNIDAD], [USUARIO], [MERMA]) VALUES ('000001', 'CORTE', '002', 30.0E-1, 'D', 'KG', 'SISTEMAS', 20.0E-1)
INSERT INTO [SERVICIOS] ([CODIGO], [DESCRIPCION], [TIPO], [COSTO], [MONEDA], [UNIDAD], [USUARIO], [MERMA]) VALUES ('000002', 'VAPORIZADO', '001', 00.0E+0, 'D', 'UN', 'SISTEMAS', 00.0E+0)
INSERT INTO [SERVICIOS] ([CODIGO], [DESCRIPCION], [TIPO], [COSTO], [MONEDA], [UNIDAD], [USUARIO], [MERMA]) VALUES ('000003', 'EMBALAJE', '001', 10.0E-2, 'D', 'UN', 'SISTEMAS', 00.0E+0)

-- No rows are in PROTO-MEDIDA
PRINT 'No rows are in PROTO-MEDIDA'
-- Insert scripts for table: SUBMENU
PRINT 'Inserting rows into table: SUBMENU'
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '1', 'MATERIA PRIMA', 'MATERIAPRIMA.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '10', 'MERCADOS', 'MERCADOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '11', 'FAMILIAS DE AVIO', 'FAMAVIOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '12', 'GENEROS', 'GENEROS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '13', 'TALLAS', 'TALLAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '14', 'TIPO DE PRENDA', 'TIPPREN.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '15', 'DESTINOS', 'DESTINOS.ASP', NULL, 'E')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '16', 'TIPOS DE TELA', 'TIPTEL.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '17', 'TIPO DE TONO-COLOR', 'TONOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '18', 'TIPOS DE TEÑIDO', 'TENIDO.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '2', 'AGRUPACION DE PRENDAS', 'GRUPOPRENDA.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '23', 'TABLA DE MEDIDAS', 'MEDIDAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '24', 'PROPORCIONES', 'PROPORCIONES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '25', 'COLORES', 'COLORES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '26', 'ESTILOS', 'ESTILOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '27', 'TEMPORADAS', 'TEMPORADAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '28', 'PARAMETROS GENERALES', 'PARAMETROS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '29', 'MERMAS GENERICAS', 'MERMAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '3', 'TIPOS DE SERVICIOS', 'TIPOSERVICIO.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '30', 'TIPOS DE AVIO', 'TIPOAVIOS.asp', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '31', 'TIPO DE EXPLOSION DE AVIOS', 'TIPEXPLO.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '4', 'LINEA DE PRENDAS', 'LINEAPRENDAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '5', 'MONEDAS', 'MONEDAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '6', 'UNIDADES', 'UNIDADES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '7', 'FAMILIA DE TELAS', 'FAMILIATELAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '8', 'TIPO DE CLIENTE', 'TIPOCLI.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('1', '9', 'PAISES', 'PAISES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('2', '1', 'PROTOTIPOS', 'PROTO.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('2', '2', 'HOJA DE ESPECIFICACIONES', 'ESPECIFICACIONES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('2', '3', 'HOJA DE AJUSTES', 'AJUSTES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('2', '6', 'COTIZADOR', 'COTIZADOR.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '1', 'TELAS', 'TELAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '2', 'AVIOS', 'AVIOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '3', 'CLIENTES', 'CLIENTES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '4', 'PROTOTIPOS', 'ESPECIFICACIONES.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '5', 'SERVICIOS', 'SERVICIOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '6', 'HILADO', 'HILOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('3', '7', 'PRENDAS', 'PRENDAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('4', '1', 'PARAMETROS MENSUALES  COTIZADOR', 'GASTOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('4', '2', 'COTIZADOR', 'COTIZADOR.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('4', '3', 'ORDENES DE COMPRA - CLIENTES', 'POS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('4', '4', 'ORDENES DE PRODUCCION', 'PEDIDOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '1', 'LISTAS DE PRECIO', 'LISTAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '2', 'COTIZACION PROFORMA', 'FICHACOSTOS2.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '3', 'CATALOGO DE PRENDAS', 'REPORCATALOGO.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '4', 'USUARIOS DEL SISTEMA', 'REPORTES/prnUSR.asp', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '5', 'OPCIONES POR USUARIO', '/reportes/prnusr-menu.asp?perfil=1', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '6', 'ESTADISTICA DE COTIZACIONES', 'REPORCOTIZ.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('5', '7', 'PROGRAMA DE PRODUCCION', 'PROGRAMAEMBARQUE.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '1', 'USUARIOS', 'USUARIOS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '10', 'SUBMENUS', 'MANTSUBMENU.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '11', 'OPCION - USUARIO - PERFIL', 'USUARIOS-OPC.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '2', 'REP PROGRAMAS', 'REPORTES/PRNopcMENU.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '4', 'FUNCIONES-PRUEBAS', 'PRUEBAS.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '7', 'MENUS', 'MANTMENU.ASP', NULL, 'A')
INSERT INTO [SUBMENU] ([MENU], [SUBMENU], [DESCRIPCION], [PROGRAMA], [PARAMETROS], [ESTADO]) VALUES ('9', '8', 'OPC-USR', 'opc_usr.ASP', NULL, 'A')

-- Insert scripts for table: PRENDAS
PRINT 'Inserting rows into table: PRENDAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [PRENDAS] ([CODIGO], [PROTO], [VERSION], [DESCRIPCION], [MINUTAJE], [UNIDAD], [GENERO], [TIPPRENDA], [CLIENTE], [FOB], [USUARIO], [MONEDA], [TALLA], [FOTO], [GRUPO]) VALUES ('G00000', '', '', 'POLO MANGA CORTA CON ESTAMPADO EN PECHERA', 56.0E+0, 'UN', 'N', '02', '000001', 12.0E+0, 'SISTEMAS', 'E', '000', NULL, 'E')

-- Insert scripts for table: HILADO
PRINT 'Inserting rows into table: HILADO'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [HILADO] ([HILO], [DESCRIPCION], [UNIDAD], [MONEDA], [COSTO], [USUARIO]) VALUES ('ATC030100000', 'ALGODON TANGUIS CARDADO 30/11 Local Crudo', 'KG', 'D', 49.8E-1, 'SISTEMAS')

-- Insert scripts for table: USR-OPC
PRINT 'Inserting rows into table: USR-OPC'
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '1', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '10', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '11', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '12', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '13', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '14', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '15', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '16', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '17', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '18', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '2', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '23', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '24', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '25', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '26', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '27', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '28', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '29', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '3', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '30', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '31', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '4', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '5', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '6', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '7', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '8', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '1', '9', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '2', '3', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '2', '6', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '1', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '2', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '3', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '4', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '5', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '6', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '3', '7', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '4', '1', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '4', '2', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '4', '3', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '4', '4', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '1', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '2', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '3', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '4', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '5', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '6', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '5', '7', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '1', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '10', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '11', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '2', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '4', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '7', '1')
INSERT INTO [USR-OPC] ([USUARIO], [MENU], [SUBMENU], [PERFIL]) VALUES ('SISTEMAS', '9', '8', '1')

-- Insert scripts for table: TELAS
PRINT 'Inserting rows into table: TELAS'
-- Warning - Computed columns cannot be listed in INSERT statements
INSERT INTO [TELAS] ([TELA], [DESCRIPCION], [TIPOTELA], [FAMILIA], [DIAMETRO], [GALGA], [PESOCRU], [PESOACA], [RENDTUB], [RENDABI], [ANCHTUB], [ANCHABI], [MONEDA], [COSTO], [UNIDAD], [HIL1], [HIL2], [HIL3], [POR1], [POR2], [POR3], [ANCHCRU], [USUARIO]) VALUES ('10000', 'JERSEY 30/1 100 %   COLOR ENTERO', 'E', '01', 23, 28, 20.0E+1, 18.0E+1, 31.2E-1, 38.3E-1, 89.0E-2, 14.5E-1, 'D', 85.2E-1, 'KG', 'ATC030100000', '', '', 100, 0, 0, 15.0E+1, 'SISTEMAS')
INSERT INTO [TELAS] ([TELA], [DESCRIPCION], [TIPOTELA], [FAMILIA], [DIAMETRO], [GALGA], [PESOCRU], [PESOACA], [RENDTUB], [RENDABI], [ANCHTUB], [ANCHABI], [MONEDA], [COSTO], [UNIDAD], [HIL1], [HIL2], [HIL3], [POR1], [POR2], [POR3], [ANCHCRU], [USUARIO]) VALUES ('10001', 'JERSEY 30/1 100 %   COLOR ENTERO', 'E', '01', 30, 23, 15.6E+1, 12.5E+1, 31.2E-1, 34.7E-1, 89.0E-2, 16.0E-1, 'D', 85.2E-1, 'KG', 'ATC030100000', '', '', 100, 0, 0, 12.5E-1, 'SISTEMAS')

-- No rows are in TEMPORADAS
PRINT 'No rows are in TEMPORADAS'
-- Insert scripts for table: TELA-OBS
PRINT 'Inserting rows into table: TELA-OBS'
INSERT INTO [TELA-OBS] ([TELA], [OBSERVACION]) VALUES ('10000', N'observaciones de prueba....')
INSERT INTO [TELA-OBS] ([TELA], [OBSERVACION]) VALUES ('10001', N'Tela desarrollada para Calvin Klein')


-- Enabling all Constraints
Print 'Enabling all Constraints'
exec sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'

-- Enabling all Triggers
Print 'Enabling all Triggers'
exec sp_MSforeachtable 'ALTER TABLE ? ENABLE TRIGGER ALL'


-- COMMITTING TRANSACTION DATA
PRINT 'Committing transaction DATA'
IF @@TRANCOUNT>0
	COMMIT TRANSACTION _DATA_
GO

SET NOEXEC OFF
GO

-- =============================================================
-- SCRIPT FOOTER: MABEL MOLINA
-- =============================================================
