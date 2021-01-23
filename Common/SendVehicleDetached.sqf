// args: [vehicle, gi, si]

_vehicle = _this select 0;
_gi = _this select 1;
_si = _this select 2;

pvVehicleDetached = [_vehicle, _gi,_si];
_nul = [pvVehicleDetached] spawn MsgVehicleDetached;
publicVariable "pvVehicleDetached";
