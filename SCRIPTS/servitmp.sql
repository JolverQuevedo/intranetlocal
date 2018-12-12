USE MODELADOR 
GO

--EXEC SP_DESPACHO_PARTIDAS_po '00001', '00006', '035' , 'BLUEROSE683', '219-333 ' 

drop table servitmp
go
	CREATE TABLE SERVITMP(
	 [NUMORD]	char(12) NOT NULL ,
	 [PO]		CHAR(20) NOT NULL DEFAULT '',
	 [combin]	varchar(50) NOT NULL DEFAULT 1,
	 [TELA]		CHAR(20)  NOT NULL DEFAULT '',
	 [KGS]		NUMERIC(18,3)  NOT NULL DEFAULT 0,
	 CONSTRAINT [PK_SRVTMP] PRIMARY KEY CLUSTERED 
(	[NUMORD]	ASC,
	[PO]		ASC,
	[combin]		asc,
	[TELA]		ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

select * from SERVITMP