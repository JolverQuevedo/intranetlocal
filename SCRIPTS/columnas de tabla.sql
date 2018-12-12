DECLARE @TABLA VARCHAR(200)


SET @TABLA = 'AL0001MOVC'


SELECT 
        COL.name AS columna, 
        TYP.name AS Tipo, 
        --Por algun motivo los nvarchar dan el doble de la longitud
        Longitud = CASE TYP.name 
            WHEN 'nvarchar' THEN COL.LENGTH/2
            WHEN 'varchar' THEN COL.LENGTH/2
            ELSE COL.LENGTH
            END,
        COL.xprec AS PRECISION, 
        COL.isnullable AS Isnullable, 
        FK.constid AS id_fk, 
        OBJ2.name AS table_derecha, 
        COL2.name 
    FROM dbo.syscolumns COL
    JOIN dbo.sysobjects OBJ ON OBJ.id = COL.id
    JOIN dbo.systypes TYP ON TYP.xusertype = COL.xtype
    --left join dbo.sysconstraints CON on CON.colid = COL.colid
    LEFT JOIN dbo.sysforeignkeys FK ON FK.fkey = COL.colid AND FK.fkeyid=OBJ.id
    LEFT JOIN dbo.sysobjects OBJ2 ON OBJ2.id = FK.rkeyid
    LEFT JOIN dbo.syscolumns COL2 ON COL2.colid = FK.rkey AND COL2.id = OBJ2.id
    WHERE OBJ.name = @tabla AND (OBJ.xtype='U' OR OBJ.xtype='V')-- AND COL.name  LIKE '%DUA%'


	-- C5_CNUMLIQ