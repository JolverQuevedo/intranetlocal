USE [MODELADOR]
GO

/****** Object:  Table [dbo].[CLIENTE_TEMP_EST_TALLA]    Script Date: 24/11/2016 09:30:17 ******/
DROP TABLE [dbo].[CLIENTE_TEMP_EST_TALLA]
GO

/****** Object:  Table [dbo].[CLIENTE_TEMP_EST_TALLA]    Script Date: 24/11/2016 09:30:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CLIENTE_TEMP_EST_TALLA](
	[CLI] [char](5) NOT NULL DEFAULT (''),
	[CODTEM] [char](4) NOT NULL DEFAULT (''),
	[ESTILO] [char](5) NOT NULL DEFAULT (''),
	[T0] [char](5) NULL DEFAULT (''),
	[T1] [char](5) NULL DEFAULT (''),
	[T2] [char](5) NULL DEFAULT (''),
	[T3] [char](5) NULL DEFAULT (''),
	[T4] [char](5) NULL DEFAULT (''),
	[T5] [char](5) NULL DEFAULT (''),
	[T6] [char](5) NULL DEFAULT (''),
	[T7] [char](5) NULL DEFAULT (''),
	[T8] [char](5) NULL DEFAULT (''),
	[T9] [char](5) NULL DEFAULT (''),
	[T10] [char](5) NULL DEFAULT (''),
	[T11] [char](5) NULL DEFAULT (''),
	[T12] [char](5) NULL DEFAULT (''),
	[T13] [char](5) NULL DEFAULT (''),
	[T14] [char](5) NULL DEFAULT (''),
	[T15] [char](5) NULL DEFAULT (''),
	[T16] [char](5) NULL DEFAULT (''),
	[T17] [char](5) NULL DEFAULT (''),
	[T18] [char](5) NULL DEFAULT (''),
	[T19] [char](5) NULL DEFAULT (''),
	[T20] [char](5) NULL DEFAULT (''),
	[T21] [char](5) NULL DEFAULT (''),
	[T22] [char](5) NULL DEFAULT (''),
	[T23] [char](5) NULL DEFAULT (''),
	[T24] [char](5) NULL DEFAULT (''),
	[T25] [char](5) NULL DEFAULT (''),
	[T26] [char](5) NULL DEFAULT (''),
	[T27] [char](5) NULL DEFAULT (''),
	[T28] [char](5) NULL DEFAULT (''),
	[T29] [char](5) NULL DEFAULT (''),
	[T30] [char](5) NULL DEFAULT ('')
CONSTRAINT [PK_POLLAPRI] PRIMARY KEY CLUSTERED 
(	[CLI] ASC,
	[CODTEM]	ASC,
	[ESTILO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

SET ANSI_PADDING OFF
GO


