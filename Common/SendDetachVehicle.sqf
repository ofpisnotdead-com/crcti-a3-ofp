// args: [tug, tugslot]

_tug = _this select 0;
_slot = _this select 1;

_value = _slot;

pvDetachVehicle = [_tug, _slot];
_nul = [pvDetachVehicle] spawn MsgDetachVehicle;
publicVariable "pvDetachVehicle";
