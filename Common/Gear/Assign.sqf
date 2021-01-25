params ["_unit", "_side", "_loadout"];

_unit call funcGearClear;

if(_side == 0) then { // WEST
  switch (_loadout) do {
    case "Default": { _unit call funcGearWestDefault; };
  };
};

if(_side == 1) then { // EAST
  switch (_loadout) do {
    case "Default": { _unit call funcGearEastDefault; };
  };
};
