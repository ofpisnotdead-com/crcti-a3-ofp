// args:  [vehicle, unit, type, align, dist]

_vehicle = _this select 0;
_unit = _this select 1;
_si = _this select 2;
_type = _this select 3;
_align = _this select 4;
_float = _this select 5;
_distMax = _this select 6;

_timeout = 20;

player groupchat format ["You have %1 seconds to place structure", _timeout];

_timeStart = time;

bBuildPlaced = false;
bCancelPlaced = false;

_actionBuild = _unit addAction ["Build", "Player\ActionBuildPlaced.sqf"];
_actionCancel = _unit addAction ["Cancel Build", "Player\ActionCancelPlaced.sqf"];

_structDesc = structDefs select _type;
_radius = _structDesc select sdMaxRadius;
_posUnit = getPos _unit;
_dirUnit = getDir _unit;
_dist = _structDesc select sdDist;
_posStruct = [(_posUnit Select 0) + _dist*(sin _dirUnit), (_posUnit Select 1) + _dist*(cos _dirUnit), 0];

_parts = _structDesc select ([sdObjectsWest, sdObjectsEast] select (playerSideIndex == siEast));

_object = objNull;
_objects = [];

{
	_part = _x;
	_posPartRel = _part select 2;
	if (count _posPartRel == 0) then {_posPartRel = [0,0,0];};
	_posPartX = (_posStruct select 0) + (_posPartRel select 0)*(cos _dirUnit) + (_posPartRel select 1)*(sin _dirUnit);
	_posPartY = (_posStruct select 1) + (_posPartRel select 1)*(cos _dirUnit) - (_posPartRel select 0)*(sin _dirUnit);
	_posPart = [ _posPartX, _posPartY, (_posStruct select 2) + (_posPartRel select 2)+ (_posUnit select 2)];
	_dirPart = (_dirUnit + (_part select 1)) % 360;

	_object = (_part select 0) createVehicleLocal _posPart;
	_object setDir _dirPart;
	_object setPos _posPart;
	_objects set [count _objects, _object];
}forEach _parts;

_state = "update";
while {_state != "finished"}do
{
	if ( !(alive _vehicle) || !(alive _unit) ) exitWith {_state = "finished";};
	if (_unit distance _vehicle > _distMax) exitWith {_state = "finished";};
	if (time > (_timeStart + _timeout)) exitWith {player groupchat "Build canceled (timeout)"; _state = "finished";};

	_dirUnit = getDir _unit;
	if ( _float ) then {_posUnit = _unit modelToWorld [0,0,0];} else {_posUnit = getPos _unit;};

	_dirStruct = _dirUnit;
	_posStruct = [(_posUnit Select 0) + _dist*(sin _dirStruct), (_posUnit Select 1) + _dist*(cos _dirStruct), 0];

	if (_align) then
	{
		_res = [playerSideIndex, _type, _posStruct, _dirStruct] call funcCalcAlignPosDir;
		_posStruct = _res select 0;
		_dirStruct = _res select 1;
	};

// CHECK NEAREST STRUCTURE
	if( _type in structsCritical ) then
	{
		_res = [_posStruct] call funcGetNearestStructure;
		_ts = _res select 1;
		_MapBuildings = nearestObjects [_posStruct, ["house"], 15];
		{
			if ( isObjectHidden _x ) then {_MapBuildings set[_forEachIndex, 0];};
		}forEach _MapBuildings;
		_MapBuildings = _MapBuildings - [0];

		{
			if(not((count _MapBuildings) == 0)&&(!(_x in _objects))) then
			{
				["Build pos blocked by House.", true, true, htBuildStructError, true] call funcHint;
				playsound "track1";
			}
		}foreach _MapBuildings;

		if ( _ts != -1 ) then
		{
			if ((_res select 2) < 0.5*(_radius + ((structDefs select _ts) select sdMaxRadius))) then
			{
				["Build pos blocked by structure.", true, true, htBuildStructError, true] call funcHint;
				playsound "track1";
			};
		};

	};

//CheckMHQ

	_pos = getPos mhq;
	_distance = _posStruct distance mhq;

	if (_distance < _radius) then
	{
		["Can't place structure here.\nToo close to MHQ", true, true, htBuildStructError, true] call funcHint;
		playsound "track1";
	};

	{
		_part = _x;

		_posPartRel = _part select 2;
		if (count _posPartRel == 0) then {_posPartRel = [0,0,0];};
		_posPartX = (_posStruct select 0) + (_posPartRel select 0)*(cos _dirStruct) + (_posPartRel select 1)*(sin _dirStruct);
		_posPartY = (_posStruct select 1) + (_posPartRel select 1)*(cos _dirStruct) - (_posPartRel select 0)*(sin _dirStruct);
		_posPart = [ _posPartX, _posPartY, ((_posStruct select 2) + (_posPartRel select 2)+ (_posUnit select 2))];
		_dirPart = (_dirStruct + (_part select 1)) % 360;

		_object = _objects select _forEachIndex;
		_object setDir _dirPart;
		_object setPos _posPart;
		if(_float)then {_object setVectorUp [0,0,1];};

	}forEach _parts;

	_NumberOfBases = (count (BaseMatrix select playerSideIndex));
	if (_NumberOfBases == 0) then
	{
		[format["No More Than %1 meters\nfrom MHQ\n\nYou are %2 meters\naway from MHQ",_distmax, _object distance (getPos mhq)], true, true, htBuildStruct, true] call funcHint;
	};
	if (_NumberOfBases == 1) then
	{
		[format["No More Than %1 meters\nfrom Base Center\n\nYou are %2 meters\naway from Base center",_distmax, _object distance ((BaseMatrix select playerSideIndex) select 0)], true, true, htBuildStruct, true] call funcHint;
	};
	if (_NumberOfBases == 2) then
	{
		[format["No More Than %1 meters\nfrom Base Center\n\nYou are %2 meters\naway from Base1 center\n\nYou are %3 meters\naway from Base2 center",_distmax,_object distance ((BaseMatrix select playerSideIndex) select 0),_object distance ((BaseMatrix select playerSideIndex) select 1)], true, true, htBuildStruct, true] call funcHint;
	};

	if (bBuildPlaced) exitWith
	{
		_nul = [_unit, _si, _type, _posStruct , _dirStruct, _align, _float] execVM "Player\BuildStructure.sqf";
		_state = "finished";
	};
	if (bCancelPlaced) exitWith
	{
		["Build canceled", true, true, htBuildStructError, true] call funcHint;
		_state = "finished";
	};
};

_unit removeAction _actionBuild;
_unit removeAction _actionCancel;
{	deleteVehicle _x}foreach _objects;
