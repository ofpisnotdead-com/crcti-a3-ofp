_veh = _this select 0;
_si = _this select 2;

/*waitUntil {!isNil "ArtyLogic"};
waitUntil {!isNull ArtyLogic};

[_veh] call BIS_ARTY_F_initVehicle;*/

_event = format["[_this, %1] spawn funcTrackShell", _si];
_veh addEventHandler ["fired", _event];