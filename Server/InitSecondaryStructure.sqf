// args: [_type, _si, _objects]

_type = _this select 0;
_si = _this select 1;
_objects = _this select 2;

if (_si == siWest) then
{
	{
		_x addEventHandler ["killed", {_nul = [_this, siWest] spawn EventStructSecDestroyed}];
	}foreach _objects;
};

if (_si == siEast) then
{
	{
		_x addEventHandler ["killed", {_nul = [_this, siEast] spawn EventStructSecDestroyed}];
	}foreach _objects;
};

{
	_nul = [_x, _si, (structDefs select _type) select sdCost] execVM "Server\EventAddStructHit.sqf";
	_x addEventHandler ["fired", {(_this select 0) spawn {_this setVariable ["HasBeenFired", true, false];}}];

	if(getNumber(configFile >> "CfgVehicles" >> typeof _x >> "isUav")==1) then
	{
		createVehicleCrew _x;
	};

}forEach _objects;

