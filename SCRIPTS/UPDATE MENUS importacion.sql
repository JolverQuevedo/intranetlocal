INSERT INTO [MODELADOR].[dbo].SUBMENU SELECT '13', '12', '3 PE IMPORTACIONES', 'atencionIMP.ASP', NULL, 'A'
INSERT INTO [MODELADOR].[dbo].[USR-OPC] SELECT 'SISTEMAS', 13,12,1
INSERT INTO [MODELADOR].[dbo].[USR-OPC] SELECT 'RBENAVENte', 13,12,1
INSERT INTO [MODELADOR].[dbo].[USR-OPC] SELECT 'MHINOJO', 13,12,1




SELECT * FROM MENU
SELECT * FROM SUBMENU WHERE MENU = 13 order by descripcion



update  [MODELADOR].[dbo].[SUBMENU] set descripcion = '11 Deta Costo OC' WHERE MENU = 13 AND SUBMENU = 11
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = '10 Claves PE' WHERE MENU = 13 AND SUBMENU = 10
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 9 DESBLOQUEA LA OC' WHERE MENU = 13 AND SUBMENU = 9
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 8 CAMBIA USR RHIN' WHERE MENU = 13 AND SUBMENU = 8
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 7 PRN PE' WHERE MENU = 13 AND SUBMENU = 7
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 6 OC LIQUIDADAS' WHERE MENU = 13 AND SUBMENU = 6
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 5 OC FINALIZADAS' WHERE MENU = 13 AND SUBMENU = 5
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 4 OC PARCIALES' WHERE MENU = 13 AND SUBMENU = 4
update  [MODELADOR].[dbo].[SUBMENU] set descripcion = ' 3 PE IMPORTACIONES' WHERE MENU = 13 AND SUBMENU = 12

