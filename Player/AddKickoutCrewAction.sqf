_name = getText(configFile >> "CfgVehicles" >> typeOf(_this select 0) >> "displayName");
_str = format["Kick crew out of %1", _name];
_nul = (_this select 0) addAction [_str, "Player\ActionKickoutCrew.sqf", [], 2, false, false, "", "(count(crew _target) > 0)  && (vehicle _this != _target)"];
