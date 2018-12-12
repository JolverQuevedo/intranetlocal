CREATE TABLE [dbo].[TIPODEFECTOS](
	[CODIGO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL PRIMARY KEY,
	[DESCRIPCION] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[USUARIO] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL DEFAULT 'A'
) ON [PRIMARY]

CREATE TABLE [dbo].[DEFECTOSTELA](
	[CODIGO] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL PRIMARY KEY,
	[DESCRIPCION] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[TIPO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL REFERENCES [TIPODEFECTOS](CODIGO),
	[USUARIO] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL DEFAULT 'A'
) ON [PRIMARY]

CREATE TABLE [dbo].[CCTELA](
	[CCT] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL PRIMARY KEY,
	[TELA] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [TELAS](TELA),
	[PARTIDA] [char](15) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
	[COLOR] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [COLORES](CODIGO),
	[CLIENTE] [char](5) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [CLIENTE](CODIGO),
	[FECHAEMISION] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[PEDIDO] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[PESOTOTAL] [float] NULL,
	[TOTALROLLOS] [int] NULL,
	[NROGUIA] [char](20) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[PROVEEDOR] [char](12) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[LAVEL] [float] NULL,
	[LAVEA] [float] NULL,
	[LAVREV] [float] NULL,
	[VAPEL] [float] NULL,
	[VAPEA] [float] NULL,
	[VAPREV] [float] NULL,
	[DENSIDAD] [float] NULL,
	[ANCHOREAL] [float] NULL,
	[TONO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[MATCHING] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[LAVADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FROTE] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[ANCHOMAX] [float] NULL,
	[ANCHOMIN] [float] NULL,
	[CALIDAD] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[REPROCES] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[LIQUIDACION] [char](5) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[CONDICION] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL DEFAULT 'A',
	[USUARIO] [char](15) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NULL,
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[CCTDEFECTOS](
	[CCT] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [CCTELA](CCT),
	[DEFECTO] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [DEFECTOSTELA](CODIGO) ,
	[USUARIO] [char](15) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL DEFAULT 'A',
 CONSTRAINT [PK_CCTDEFECTOS] PRIMARY KEY NONCLUSTERED 
(
	[CCT] ASC,
	[DEFECTO] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[CCTOBSERVACIONES](
	[CCT] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [CCTELA](CCT),
	[OBSERVACIONES] [varchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[USUARIO] [char](15) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT 'A',
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL DEFAULT 'A'
 ) ON [PRIMARY]

CREATE TABLE [dbo].[CCTROLLOS](
	[CCT] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL REFERENCES [CCTELA](CCT),
	[ROLLO] [int] NOT NULL,
	[ANCHO] [float] NULL,
	[PESO] [float] NULL,
	[CALIDAD] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[USUARIO] [char](15) COLLATE SQL_Latin1_General_CP1_CI_AI NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL DEFAULT 'A'
 CONSTRAINT [PK_CCTROLLOS] PRIMARY KEY NONCLUSTERED 
(
	[CCT] ASC,
	[ROLLO] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]