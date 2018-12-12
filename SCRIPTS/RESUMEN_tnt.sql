select * from EXPLOSION_TELA
select * from ORDENCOMPRA




SELECT tela, descripcion, sum(_xs) as XS, sum(_s) as _s, sum(_m) as _m, sum(_l) as _l, sum(_xxl) as _xl,
sum(_xxl) as _xxl, sum(_3xl) as _3xl, sum(_4xl) as _4xl, sum(_5xl) as _5xl, sum(_6xl) as _6xl, sum(_7xl) as _7xl, sum(_8xl) as _8xl
FROM VIEW_RECTILINEOS_OFI
group by tela, descripcion


ISNULL(CASE WHEN T0 = 'XS'  THEN CEILING(CAN0*1.05) WHEN T1 = 'XS' THEN CEILING(CAN1*1.05) WHEN T2 = 'XS' THEN CEILING(CAN2*1.05) 
			WHEN T3 = 'XS'  THEN CEILING(CAN3*1.05) WHEN T4 = 'XS' THEN CEILING(CAN4*1.05) WHEN T5 = 'XS' THEN CEILING(CAN5*1.05) 
			WHEN T6 = 'XS'  THEN CEILING(CAN6*1.05) WHEN T7 = 'XS' THEN CEILING(CAN7*1.05) WHEN T8 = 'XS' THEN CEILING(CAN8*1.05) 
			WHEN T9 = 'XS'  THEN CEILING(CAN9*1.05) END, 0) AS XS, 
ISNULL(CASE WHEN T0 = 'S'   THEN CEILING(CAN0*1.05) WHEN T1 = 'S' THEN CEILING(CAN1*1.05)	  WHEN T2 = 'S' THEN CEILING(CAN2*1.05) 
			WHEN T3 = 'S'   THEN CEILING(CAN3*1.05) WHEN T4 = 'S' THEN CEILING(CAN4*1.05) WHEN T5 = 'S' THEN CEILING(CAN5*1.05) 
			WHEN T6 = 'S'   THEN CEILING(CAN6*1.05) WHEN T7 = 'S' THEN CEILING(CAN7*1.05) WHEN T8 = 'S' THEN CEILING(CAN8*1.05) 
			WHEN T9 = 'S'   THEN CEILING(CAN9*1.05) END, '0') AS S, 
ISNULL(CASE WHEN T0 = 'M'   THEN CEILING(CAN0*1.05) WHEN T1 = 'M' THEN CEILING(CAN1*1.05) WHEN T2 = 'M' THEN CEILING(CAN2*1.05) 
			WHEN T3 = 'M'   THEN CEILING(CAN3*1.05) WHEN T4 = 'M' THEN CEILING(CAN4*1.05) WHEN T5 = 'M' THEN CEILING(CAN5*1.05) 
			WHEN T6 = 'M'   THEN CEILING(CAN6*1.05) WHEN T7 = 'M' THEN CEILING(CAN7*1.05) WHEN T8 = 'M' THEN CEILING(CAN8*1.05) 
			WHEN T9 = 'M'   THEN CEILING(CAN9*1.05) END, 0) AS M, 
ISNULL(CASE WHEN T0 = 'L'   THEN CEILING(CAN0*1.05) WHEN T1 = 'L' THEN CEILING(CAN1*1.05) WHEN T2 = 'L'   THEN CEILING(CAN2*1.05) 
			WHEN T3 = 'L'   THEN CEILING(CAN3*1.05) WHEN T4 = 'L' THEN CEILING(CAN4*1.05) WHEN T5 = 'L'   THEN CEILING(CAN5*1.05) 
			WHEN T6 = 'L'   THEN CEILING(CAN6*1.05) WHEN T7 = 'L'   THEN CEILING(CAN7*1.05) WHEN T8 = 'L'   THEN CEILING(CAN8*1.05) WHEN T9 = 'L'   THEN CEILING(CAN9*1.05) END, 0) AS L, 
ISNULL(CASE WHEN T0 = 'XL'  THEN CEILING(CAN0*1.05) WHEN T1 = 'XL'  THEN CEILING(CAN1*1.05) WHEN T2 = 'XL'  THEN CEILING(CAN2*1.05) WHEN T3 = 'XL'  THEN CEILING(CAN3*1.05) WHEN T4 = 'XL'  THEN CEILING(CAN4*1.05) 
			WHEN T5 = 'XL'  THEN CEILING(CAN5*1.05) WHEN T6 = 'XL'  THEN CEILING(CAN6*1.05) WHEN T7 = 'XL'  THEN CEILING(CAN7*1.05) WHEN T8 = 'XL'  THEN CEILING(CAN8*1.05) WHEN T9 = 'XL'  THEN CEILING(CAN9*1.05) END, 0) AS XL, 
ISNULL(CASE WHEN T0 = 'XXL' THEN CEILING(CAN0*1.05) WHEN T1 = 'XXL' THEN CEILING(CAN1*1.05) WHEN T2 = 'XXL' THEN CEILING(CAN2*1.05) WHEN T3 = 'XXL' THEN CEILING(CAN3*1.05) WHEN T4 = 'XXL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = 'XXL' THEN CEILING(CAN5*1.05) WHEN T6 = 'XXL' THEN CEILING(CAN6*1.05) WHEN T7 = 'XXL' THEN CEILING(CAN7*1.05) WHEN T8 = 'XXL' THEN CEILING(CAN8*1.05) WHEN T9 = 'XXL' THEN CEILING(CAN9*1.05) END, 0) AS XXL, 
ISNULL(CASE WHEN T0 = '3XL' THEN CEILING(CAN0*1.05) WHEN T1 = '3XL' THEN CEILING(CAN1*1.05) WHEN T2 = '3XL' THEN CEILING(CAN2*1.05) WHEN T3 = '3XL' THEN CEILING(CAN3*1.05) WHEN T4 = '3XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '3XL' THEN CEILING(CAN5*1.05) WHEN T6 = '3XL' THEN CEILING(CAN6*1.05) WHEN T7 = '3XL' THEN CEILING(CAN7*1.05) WHEN T8 = '3XL' THEN CEILING(CAN8*1.05) WHEN T9 = '3XL' THEN CEILING(CAN9*1.05) END, 0) AS [3XL], 
ISNULL(CASE WHEN T0 = '4XL' THEN CEILING(CAN0*1.05) WHEN T1 = '4XL' THEN CEILING(CAN1*1.05) WHEN T2 = '4XL' THEN CEILING(CAN2*1.05) WHEN T3 = '4XL' THEN CEILING(CAN3*1.05) WHEN T4 = '4XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '4XL' THEN CEILING(CAN5*1.05) WHEN T6 = '4XL' THEN CEILING(CAN6*1.05) WHEN T7 = '4XL' THEN CEILING(CAN7*1.05) WHEN T8 = '4XL' THEN CEILING(CAN8*1.05) WHEN T9 = '4XL' THEN CEILING(CAN9*1.05) END, 0) AS [4XL], 
ISNULL(CASE WHEN T0 = '5XL' THEN CEILING(CAN0*1.05) WHEN T1 = '5XL' THEN CEILING(CAN1*1.05) WHEN T2 = '5XL' THEN CEILING(CAN2*1.05) WHEN T3 = '5XL' THEN CEILING(CAN3*1.05) WHEN T4 = '5XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '5XL' THEN CEILING(CAN5*1.05) WHEN T6 = '5XL' THEN CEILING(CAN6*1.05) WHEN T7 = '5XL' THEN CEILING(CAN7*1.05) WHEN T8 = '5XL' THEN CEILING(CAN8*1.05) WHEN T9 = '5XL' THEN CEILING(CAN9*1.05) END, 0) AS [5XL], 
ISNULL(CASE WHEN T0 = '6XL' THEN CEILING(CAN0*1.05) WHEN T1 = '6XL' THEN CEILING(CAN1*1.05) WHEN T2 = '6XL' THEN CEILING(CAN2*1.05) WHEN T3 = '6XL' THEN CEILING(CAN3*1.05) WHEN T4 = '6XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '6XL' THEN CEILING(CAN5*1.05) WHEN T6 = '6XL' THEN CEILING(CAN6*1.05) WHEN T7 = '6XL' THEN CEILING(CAN7*1.05) WHEN T8 = '6XL' THEN CEILING(CAN8*1.05) WHEN T9 = '6XL' THEN CEILING(CAN9*1.05) END, 0) AS [6XL], 
ISNULL(CASE WHEN T0 = '7XL' THEN CEILING(CAN0*1.05) WHEN T1 = '7XL' THEN CEILING(CAN1*1.05) WHEN T2 = '7XL' THEN CEILING(CAN2*1.05) WHEN T3 = '7XL' THEN CEILING(CAN3*1.05) WHEN T4 = '7XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '7XL' THEN CEILING(CAN5*1.05) WHEN T6 = '7XL' THEN CEILING(CAN6*1.05) WHEN T7 = '7XL' THEN CEILING(CAN7*1.05) WHEN T8 = '7XL' THEN CEILING(CAN8*1.05) WHEN T9 = '7XL' THEN CEILING(CAN9*1.05) END, 0) AS [7XL], 
ISNULL(CASE WHEN T0 = '8XL' THEN CEILING(CAN0*1.05) WHEN T1 = '8XL' THEN CEILING(CAN1*1.05) WHEN T2 = '8XL' THEN CEILING(CAN2*1.05) WHEN T3 = '8XL' THEN CEILING(CAN3*1.05) WHEN T4 = '8XL' THEN CEILING(CAN4*1.05) 
			WHEN T5 = '8XL' THEN CEILING(CAN5*1.05) WHEN T6 = '8XL' THEN CEILING(CAN6*1.05) WHEN T7 = '8XL' THEN CEILING(CAN7*1.05) WHEN T8 = '8XL' THEN CEILING(CAN8*1.05) WHEN T9 = '8XL' THEN CEILING(CAN9*1.05) END, 0) AS [8XL], 
    PD.CAN0 + PD.CAN1 + PD.CAN2 + PD.CAN3 + PD.CAN4 + PD.CAN5 + PD.CAN6 + PD.CAN7 + PD.CAN8 + PD.CAN9 AS TOTAL, 