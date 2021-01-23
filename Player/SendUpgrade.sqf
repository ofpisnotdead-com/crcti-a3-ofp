// args: [upgrade]

pvUpgrade = [_this select 0, playerSideIndex];
_nul = [pvUpgrade] execVM "Server\MsgUpgrade.sqf"; 
publicVariable "pvUpgrade";
