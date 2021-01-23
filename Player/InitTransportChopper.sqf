// args: [vehicle, type, si]

(_this select 0) addAction ["Attach/Detach Vehicle", "Player\ActionAttachDetachVehicle.sqf", [tsCenter, ttHeli], 3, false, false, "", "vehicle _this == _target"];

