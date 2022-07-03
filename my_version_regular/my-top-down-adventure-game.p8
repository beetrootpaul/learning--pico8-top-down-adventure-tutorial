pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- my implementation of dylan bennett's
-- top-down adventure game tutorial

#include utils.lua
#include main.lua
#include gameplay.lua
#include viewport.lua
#include audio.lua
#include level.lua
#include player.lua
#include inventory.lua

-- test area 
-- (add/remove a hyphen to uncomment)
--[[

…∧░➡️⧗▤⬆️☉🅾️◆
█★⬇️✽●♥웃⌂⬅️
▥❎🐱ˇ▒♪😐

map
btnp(⬅️)
btnp(➡️)
btnp(⬆️)
btnp(⬇️)
⬅️➡️⬆️⬇️

puny font:
ASDAFDSDSFDS
ADQWEFCSS
asdadq
sddsa

--]]
__gfx__
00000000002220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000025552200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700025c55520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000025556620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000265555520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700025556200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000025552000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000025252000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333334a4444a433333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333b333333333333333999334a4444a44944449437333733333333330000000000000000000000000000000000000000000000000000000000000000
3333333333b3333333566333339939934944449421111112067506750dd50dd50000000000000000000000000000000000000000000000000000000000000000
3333333333b33b333556663333399933494444944111111430033003300330030000000000000000000000000000000000000000000000000000000000000000
33333333333333333155563333339333222aa222411aa11433333333333333330000000000000000000000000000000000000000000000000000000000000000
333333333333b3333315553333399333444994444449944437333733333333330000000000000000000000000000000000000000000000000000000000000000
3333333333b33b3333333333333393332444444224444442067506750dd50dd50000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333399333322222233222222330033003300330030000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111111111c77cc1111ccc11100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111c566c1100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111c55666c100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111111111111c7111c5556c100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cc77711111ccc5c100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111c777c111111c1cc100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665566655500000000000000006688886600000000000000000000000000000000000000000000000000000000000000000000000000000000
6666666666666646555556650044440000666600666ff66600000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666664666666666555504444440046666608666666800000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555509444440096666608f6886f800000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666664665666566604444940046666608f6886f800000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555504444940046666608666666800000000000000000000000000000000000000000000000000000000000000000000000000000000
6666666666646666665666560944444009666660666ff66600000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555504444440046666606688886600000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33566333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
35566633333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
31555633333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33155533333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333b33333333333333333333333333333333333333333333
3333333333333333335663333333333333333333335663333333333333333333333333333333333333b333333333333333566333333333333333333333333333
3333333333333333355666333333333333333333355666333333333333333333333333333333333333b33b333333333335566633333333333333333333333333
33333333333333333155563333333333333333333155563333333333333333333333333333333333333333333333333331555633333333333333333333333333
333333333333333333155533333333333333333333155533333333333333333333333333333333333333b3333333333333155533333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333b33b333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333b3333
333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333b33333
333333333333333333333333333333333333333333333333333333333333333333b33b3333333333333333333333333333333333333333333333333333b33b33
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333b333
333333333333333333333333333333333333333333333333333333333333333333b33b3333333333333333333333333333333333333333333333333333b33b33
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333222333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333b3333333333333255522333333333333b333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333b3333333333333325c55523333333333b3333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333b33b3333333333325556623333333333b33b3333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333326555552333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333b3333333333332555623333333333333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333b33b3333333333325552333333333333b33b3333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333332525233333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333335663333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333355666333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333315556333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333331555333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111
333333333333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333335663333333333333b33333333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333355666333333333333b33b33333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333315556333333333333333333333333333333333333333333111111111111111111111111
3333333333333333333333333333333333333333333333333333333333155533333333333333b333333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333b33b33333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333331111111111111111111111111111111111111111
33333333333333333333333333333333333b33333333333333333333373337333733373337333733373337331111111111111111111111111111111111111111
3333333333333333333333333333333333b333333333333333333333067506750675067506750675067506751111111111111111111111111111111111111111
3333333333333333333333333333333333b33b333333333333333333300330033003300330033003300330031111111111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333331111111111111111111111111111111111111111
333333333333333333333333333333333333b3333333333333333333373337333733373337333733373337331111111111111111111111111111111111111111
3333333333333333333333333333333333b33b333333333333333333067506750675067506750675067506751111111111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333300330033003300330033003300330031111111111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333336666666666666666111111111111111111111111111111111111111111111111
333333333333333333333333333333333333333333333333333333333733373366666666666666661111111111111111111111111111111111ccc11111111111
33333333333333333333333333566333333333333333333333333333067506756666666666666666111111111111111111111111111111111c566c1111111111
3333333333333333333333333556663333333333333333333333333330033003666666666666666611111111111111111111111111111111c55666c111111111
33333333333333333333333331555633333333333333333333333333333333336666666666666666111111111111111111111111111111111c5556c111111111
333333333333333333333333331555333333333333333333333333333733373366666666666666661111111111111111111111111111111111ccc5c111111111
3333333333333333333333333333333333333333333333333333333306750675666666666666666611111111111111111111111111111111111c1cc111111111
33333333333333333333333333333333333333333333333333333333300330036666666666666666111111111111111111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111111111111111111111111111
33333333333b333333333333333333333333333333333333333333333733373333333333333333331111111111ccc11111111111111111111111111111111111
3333333333b333333333333333333333333333333333333333333333067506750dd50dd50dd50dd5111111111c566c1111111111111111111111111111111111
3333333333b33b33333333333333333333333333333333333333333330033003300330033003300311111111c55666c111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333111111111c5556c111111111111111111111111111111111
333333333333b33333333333333333333333333333333333333333333733373333333333333333331111111111ccc5c111111111111111111111111111111111
3333333333b33b333333333333333333333333333333333333333333067506750dd50dd50dd50dd511111111111c1cc111111111111111111111111111111111
33333333333333333333333333333333333333333333333333333333300330033003300330033003111111111111111111111111111111111111111111111111
33333333333333333333333311111111111111111111111111111111111111116666666666666666111111111111111111111111111111111111111133333333
333333333333333333333333111111111111111111111111111111111111111166666646666666461111111111111111111111111c77cc1111111111333b3333
33333333333333333333333311111111111111111111111111111111111111116646666666466666111111111111111111111111111111111111111133b33333
33333333333333333333333311111111111111111111111111111111111111116666666666666666111111111111111111111111111111111111111133b33b33
333333333333333333333333111111111111111111111111111111111111111166666466666664661111111111111111111111111111c7111111111133333333
33333333333333333333333311111111111111111111111111111111111111116666666666666666111111111111111111111111cc777111111111113333b333
33333333333333333333333311111111111111111111111111111111111111116664666666646666111111111111111111111111c777c1111111111133b33b33
33333333333333333333333311111111111111111111111111111111111111116666666666666666111111111111111111111111111111111111111133333333
33333333111111111111111111111111111111111111111111111111111111116666666666666666333333333333333333333333333333333333333333333333
3333333311111111111111111c77cc111111111111ccc11111ccc111111111116666666666666646333b3333333b3333333b3333333b3333333b3333333b3333
33333333111111111111111111111111111111111c566c111c566c1111111111666666666646666633b3333333b3333333b3333333b3333333b3333333b33333
3333333311111111111111111111111111111111c55666c1c55666c111111111666666666666666633b33b3333b33b3333b33b3333b33b3333b33b3333b33b33
3333333311111111111111111111c711111111111c5556c11c5556c1111111116666666666666466333333333333333333333333333333333333333333333333
333333331111111111111111cc7771111111111111ccc5c111ccc5c11111111166666666666666663333b3333333b3333333b3333333b3333333b3333333b333
333333331111111111111111c777c11111111111111c1cc1111c1cc111111111666666666664666633b33b3333b33b3333b33b3333b33b3333b33b3333b33b33
33333333111111111111111111111111111111111111111111111111111111116666666666666666333333333333333333333333333333333333333333333333
11111111111111111111111111111111111111111111111111111111111111116666666666666666333333335566655555666555556665555566655555666555
11111111111111111111111111111111111111111111111111111111111111116666666666666646333b33335555566555555665555556655555566555555665
1111111111111111111111111111111111111111111111111111111111111111666666666646666633b333336666555566665555666655556666555566665555
1111111111111111111111111111111111111111111111111111111111111111666666666666666633b33b335555555555555555555555555555555555555555
11111111111111111111111111111111111111111111111111111111111111116666666666666466333333335666566656665666566656665666566656665666
111111111111111111111111111111111111111111111111111111111111111166666666666666663333b3335555555555555555555555555555555555555555
1111111111111111111111111111111111111111111111111111111111111111666666666664666633b33b336656665666566656665666566656665666566656
11111111111111111111111111111111111111111111111111111111111111116666666666666666333333335555555555555555555555555555555555555555
11111111111111111111111111111111111111111111111111111111333333336666666666666666556665555566655566666666666666666666666655666555
11111111111111111c77cc1111111111111111111111111111111111333333336666664666666666555556655555566566666666666666666666666655555665
11111111111111111111111111111111111111111111111111111111333333336646666666666666666655556666555566666666666666666666666666665555
11111111111111111111111111111111111111111111111111111111333333336666666666666666555555555555555566666666666666666666666655555555
11111111111111111111c71111111111111111111111111111111111333333336666646666666666566656665666566666666666666666666666666656665666
1111111111111111cc77711111111111111111111111111111111111333333336666666666666666555555555555555566666666666666666666666655555555
1111111111111111c777c11111111111111111111111111111111111333333336664666666666666665666566656665666666666666666666666666666566656
11111111111111111111111111111111111111111111111111111111333333336666666666666666555555555555555566666666666666666666666655555555
11111111111111111111111111111111111111113333333333333333333333336666666666666666000000000000000066666666668888666666666655666555
11111111111111111111111111111111111111113333333333333333333333336666666666666666004444000044440066666666666ff6666666666655555665
11111111111111111111111111111111111111113333333333333333333333336666666666666666044444400444444066666666866666686666666666665555
111111111111111111111111111111111111111133333333333333333333333366666666666666660944444009444440666666668f6886f86666666655555555
111111111111111111111111111111111111111133333333333333333333333366666666666666660444494004444940666666668f6886f86666666656665666
11111111111111111111111111111111111111113333333333333333333333336666666666666666044449400444494066666666866666686666666655555555
11111111111111111111111111111111111111113333333333333333333333336666666666666666094444400944444066666666666ff6666666666666566656
11111111111111111111111111111111111111113333333333333333333333336666666666666666044444400444444066666666668888666666666655555555
33333333333333333333333333333333333333333333333333333333333333336666666666666666556665555566655566666666666666666666666655666555
333b3333333b33333333333333333333333333333333333333333333333333336666666666666646555556655555566566666666666666666666666655555665
33b3333333b333333333333333333333333333333333333333333333335663336666666666466666666655556666555566666666666666666666666666665555
33b33b3333b33b333333333333333333333333333333333333333333355666336666666666666666555555555555555566666666666666666666666655555555
33333333333333333333333333333333333333333333333333333333315556336666666666666466566656665666566666666666666666666666666656665666
3333b3333333b3333333333333333333333333333333333333333333331555336666666666666666555555555555555566666666666666666666666655555555
33b33b3333b33b333333333333333333333333333333333333333333333333336666666666646666665666566656665666666666666666666666666666566656
33333333333333333333333333333333333333333333333333333333333333336666666666666666555555555555555566666666666666666666666655555555
33333333333333333333333333333333333333333333333333333333333333333333333366666666666666665566655555666555556665555566655555666555
333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b333366666666666666665555566555555665555556655555566555555665
33b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333366666666666666666666555566665555666655556666555566665555
33b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3366666666666666665555555555555555555555555555555555555555
33333333333333333333333333333333333333333333333333333333333333333333333366666666666666665666566656665666566656665666566656665666
3333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33366666666666666665555555555555555555555555555555555555555
33b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3333b33b3366666666666666666656665666566656665666566656665666566656
33333333333333333333333333333333333333333333333333333333333333333333333366666666666666665555555555555555555555555555555555555555

__gff__
0000000000000000000000000000000000000100010104000000000000000000010101000000000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1210101010101010101010101010101010101111111010101010101420202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010121010121010101011101210101010111111101010202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010111010101010101110101110102020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011101010111010101010101010101010101010202020202020202022202120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1012101010101010101010101010102020202020202220202120222020202010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101012101110101020202020202120202020202020202220201111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101011101017171717202020202020202020202021202020201010101111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101210101017303020202020222021202020101010101010101010111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011101010101017161620222020202020101010101010101011111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010102020202020313120202021201111111010101210101111101111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1020202120222220303111111111111111111010101010101111111110111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020303111323232323212101011111111111111101010111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020212020202010313032323030303211121111111111111110131011111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020101010303033333035303212121010101111111111111111111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111101010101012303132323030303211121211111111111111111111101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111113030323232323212111211111010101111111110101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400001104000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002005038050380503804038040380403803038020380103800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000013050130501b0502305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001064017620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 00424344
00 01424344

