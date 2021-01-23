_dist = 2 + ((structDefs select (_this select 1)) select sdMaxRadius);

_nul = [_this, ["Buy Aircraft"], _dist] execVM "Player\UpdateFarStructureActions.sqf";