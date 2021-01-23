// args: [vehicle, type, si]

(_this select 0) addAction ["Attach/Detach Center Vehicle", "Player\ActionAttachDetachVehicle.sqf",[tsCenter, ttBoat], 3, false, false, "", "vehicle _this == _target"];
(_this select 0) addAction ["Attach/Detach Right Vehicle", "Player\ActionAttachDetachVehicle.sqf", [tsRight, ttBoat], 3, false, false, "", "vehicle _this == _target"];
(_this select 0) addAction ["Attach/Detach Left Vehicle", "Player\ActionAttachDetachVehicle.sqf", [tsLeft, ttBoat], 3, false, false, "", "vehicle _this == _target"];

