( This file was created automatically using CamBam )
( http://www.brusselsprout.org/CAMBAM )
( 5/15/2019 3:14:46 PM )
( T0 : 0.5 )
G21
G90
G64
G00 Z1.5
( MOPDrill_2 )
( T0 : 0.5 )
M06 T0
M03
G81 X0 Y0 Z3 R1.5 F30
( MOPEngrave_3 )
G00 Z1.5
G00 X10 Y30
G01 Z-0.2
G01 F300 Y-30
G00 Z1.5
G00 X-30
G01 F30 Z-0.2
G01 F300 X30
G01 Y30
G01 X-30
G01 Y-30
G00 Z1.5
G00 Y-10
G01 F30 Z-0.2
G01 F300 X30
G00 Z1.5
G00 X-20 Y30
G01 F30 Z-0.2
G01 F300 Y-30
G00 Z1.5
G00 X-30 Y20
G01 F30 Z-0.2
G01 F300 X30
G00 Z1.5
M05
M30
