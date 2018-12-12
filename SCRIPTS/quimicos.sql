drop table quimicos
CREATE TABLE [dbo].[QUIMICOS](
	[CODIGO] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL PRIMARY KEY,
	[FAMUTI] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AI NULL REFERENCES [FAMqui](CODIGO),
	[DESCRIPCION] [char](100) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
	[UNIDAD] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
	[MONEDA] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
	[COSTO] [float] NULL,
	[USUARIO] [char](10) NOT NULL default 'sistemas',
	[FECHA] [smalldatetime] NOT NULL DEFAULT (getdate()),
	[ESTADO] [char](1)  NOT NULL DEFAULT ('A'),
) ON [PRIMARY]

