USE MODELADOR
GO
--DROP TABLE [RSV_TELA]
GO
CREATE TABLE [dbo].[RSV_TELA](
	[OFI]		char(8) NOT NULL ,
	[PO]		CHAR(20) NOT NULL DEFAULT '',
	[ALM]		CHAR(4) NOT NULL DEFAULT '',
	[CODIGO]	CHAR(16) NOT NULL DEFAULT '',
	[TIPO]		CHAR(1) NOT NULL DEFAULT '',
	[KGS]		NUMERIC (18,3)	NOT NULL DEFAULT 0,
	[QTY]		NUMERIC (18,0)	NOT NULL DEFAULT 0,
	[USUARIO]	CHAR(10),
	[FECHA]		[SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO]	CHAR(1) DEFAULT 'A',
	 CONSTRAINT [PK_RESER] PRIMARY KEY CLUSTERED 
(	[OFI]	ASC,
	[PO]	ASC,
	[ALM]	ASC,
	[CODIGO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[RSV_TALLA](
	[OFI]		char(8) NOT NULL ,
	[PO]		CHAR(20) NOT NULL DEFAULT '',
	[ALM]		CHAR(4)  NOT NULL DEFAULT '',
	[CODIGO]	CHAR(16) NOT NULL DEFAULT '',
	[LIN]		CHAR(2)  NOT NULL DEFAULT '',
	[TALLA]		CHAR(5)  NOT NULL DEFAULT 0,
	[QTY]		NUMERIC (18,0)	NOT NULL DEFAULT 0,
	[USUARIO]	CHAR(10),
	[FECHA]		[SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO]	CHAR(1) DEFAULT 'A',
	 CONSTRAINT [PK_RSV_TALLA] PRIMARY KEY CLUSTERED 
(	[OFI]	ASC,
	[PO]	ASC,
	[ALM]	ASC,
	[CODIGO] ASC,
	[LIN]  ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



select TOP 3 * from ORDENCOMPRA
SELECT TOP 3 * FROM EXPLOSION_TELA
select TOP 3 * from RSV_TELA