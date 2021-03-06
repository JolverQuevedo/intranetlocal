USE [KAYSER]
GO
/****** Objeto:  Table [dbo].[TIPODETALLE]    Fecha de la secuencia de comandos: 05/04/2011 14:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIPODETALLE](
	[TIPODETALLE] [char](2) NOT NULL primary key,
	[PRIORIDAD] [char](2)  NULL,
	[DESCRIPCION] [char](100)  NULL,
	[TABLA] [char](50)  NULL,
	[USUARIO] [char](10)  NULL,
	[FECHA] [smalldatetime] NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1)  NOT NULL  DEFAULT ('A'),
 
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF