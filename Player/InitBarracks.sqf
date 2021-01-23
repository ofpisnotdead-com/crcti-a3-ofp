_dist = 2 + ((structDefs select (_this select 1)) select sdMaxRadius);

_nul = [_this, ["Buy Infantry", "Buy Equipment"], _dist] execVM "Player\UpdateFarStructureActions.sqf";
