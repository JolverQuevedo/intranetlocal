select et.OFI, PO, UBI, COMBO, QTY, KGS, TELA,DESTEM AS TEMPORADA, ESTCLI, OSCORTE, OSCOSTU, OSACABA, OSBORDA, OSESTAM, OSLAVAD,tempo ,  *
from  explosion_tela as et
inner join view_ofis as vo on vo.ofi = et.ofi
WHERE
et.OFI ='00009507'
/*
 REPLACE(DESTEM, ' ' , '') = REPLACE('MID    SEASON FALL  18', ' ' , '') AND REPLACE(ESTCLI,' ' , '') = REPLACE('UW2025',' ' ,'')
AND REPLACE(ET.PO,' ' ,'') = REPLACE('218-716- BB',' ' , '')
*/