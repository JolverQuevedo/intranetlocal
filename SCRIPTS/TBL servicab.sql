USE MODELADOR
GO

/*
--DROP TABLE  TIPSERV
GO

CREATE TABLE [dbo].[TIPSERV](
	[CODIGO]		char(3) NOT NULL  PRIMARY KEY,
	[DESCRIPCION]	VARCHAR(50)  NOT NULL DEFAULT '',
	[CORREL]		INT  NOT NULL DEFAULT 0,
	[USUARIO]	CHAR(10),
	[FECHA]		[SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO]	CHAR(1) DEFAULT 'A') ON [PRIMARY]


GO

insert into [modelador].[dbo].[tipserv] select 'APR','ACABADO EN PRENDA   ',2 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'BPR','BORDADO EN PRENDA   ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'BPZ','BORDADO EN PIEZA    ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'CPZ','CONFECCION DE PIEZAS',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'CTL','CORTE DE TELA       ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'DPR','DESMANCHE EN  PRENDA',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'DPZ','DESMANCHE EN PIEZA  ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'EPR','ESTAMPADO EN PRENDA ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'EPZ','ESTAMPADO EN PIEZA  ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'LPR','LAVADO DE PRENDAS   ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'LPZ','LAVADO DE PIEZAS    ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'RPR','REEMPAQUE EN PRENDA ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'TPR','TEÑIDO EN PRENDA    ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'ZPR','ZURCIDO EN PRENDA   ',0 ,'SISTEMAS',getdate(),'a'
insert into [modelador].[dbo].[tipserv] select 'ZPZ','ZURCIDO EN PIEZA    ',0 ,'SISTEMAS',getdate(),'a'

*/


DROP TABLE [SERVICAB]
GO
CREATE TABLE [dbo].[SERVICAB](
	[NUMORD]	char(14) NOT NULL  PRIMARY KEY,
	[TIPSER]	CHAR(5)  NOT NULL DEFAULT '',
	[RUC]		CHAR(11) NOT NULL DEFAULT '',
	[ATT]		VARCHAR(100)  NOT NULL DEFAULT '',
	[TIPPAG]	CHAR(2)  NOT NULL DEFAULT '',
	[CLIENTE]	CHAR(5)  NOT NULL DEFAULT '',
	[CODMON]	CHAR(2) NOT NULL DEFAULT '',
	[CLASE]		CHAR(1)  NOT NULL DEFAULT '1',   -- 1 = PLANTA, 2 = SERVICIOS EXTERNOS
	[TIPCAM]	NUMERIC(10,4) NOT NULL DEFAULT 1,
	[PREUNI]	MONEY NOT NULL DEFAULT 0,
	[IMPMN]		MONEY NOT NULL DEFAULT 0,
	[IMPUS]		MONEY NOT NULL DEFAULT 0,
	[SITORD]	CHAR(1)NOT NULL DEFAULT '1',
	[ENTREGA]	VARCHAR(100) NOT NULL DEFAULT '',
	[PRENDAS]	INT	NOT NULL DEFAULT 0,
	[GLOSA]		VARCHAR(200) NOT NULL DEFAULT '',
	[USUARIO]	CHAR(10),
	[FECDOC]	[SMALLdatetime] DEFAULT GETDATE(),
	[FECENT]	[SMALLdatetime] DEFAULT GETDATE(),
	[FECHA]		[SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO]	CHAR(1) DEFAULT 'A'
) ON [PRIMARY]