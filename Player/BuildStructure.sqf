// args:  [unit, type, pos, dir, align]

_unit = _this Select 0;
_si = _this select 1;
_type = _this Select 2;
_posStruct = _this select 3;
_dirStruct = _this select 4;
_align = _this select 5;
_float = _this select 6;

_MapBuildings = [];

_desc = structDefs select _type;
_structsOfSameType = [playerSideIndex, _type] call funcGetStructures;

if ( (count _structsOfSameType) >= (_desc select sdLimit)) then
{
	[format["Structure Limit Reached (%1)", _desc select sdLimit], true, false, htGeneral, false] call funcHint;
}
else
{
	_lastTime = (structTimes select playerSideIndex) select _type;
	if (time < _lastTime) then
	{
		[format["Cannot build for another %1 seconds.", round(_lastTime-time)], true, false, htGeneral, false] call funcHint;
	}
	else
	{
		_cost = _desc select sdCost;
		_radius = _desc select sdMaxRadius;

		_posUnit = [];
		if (count _posStruct == 0) then
		{
			if( _float ) then
			{
				_posUnit = _unit modelToWorld [0,0,0];
			}
			else
			{
				_posUnit = getPos _unit;
			};

			_dirUnit = getDir _unit;
			_dist = _desc select sdDist;
			_posStruct = [(_posUnit Select 0) + _dist*(sin _dirUnit), (_posUnit Select 1) + _dist*(cos _dirUnit)];
			_dirStruct = _dirUnit;
		};

		if (_align) then
		{
			_res = [playerSideIndex, _type, _posStruct, _dirStruct] call funcCalcAlignPosDir;
			_posStruct = _res select 0;
			_dirStruct = _res select 1;
		};

		// Near town?
		_isStaticWeapon = false;
		if ( BuildInTownsAllowed == 1 ) then
		{
			_classes = (_desc select sdObjectsWest) + (_desc select sdObjectsEast);
			{
				if ( (_x select 0) isKindof "StaticWeapon" ) then
				{
					_isStaticWeapon = true;
				};
			}forEach _classes;
		};

		_distance = ([_posStruct, [siWest, siEast, siRes],[]] call funcGetClosestTown) select 1;
		if ( (BuildInTownsAllowed < 2) && !_isStaticWeapon && _distance < (_radius+townRadius)) then
		{
			["Can't place structure here.\nToo close to a Town Flag", true, false, htGeneral, false] call funcHint;
		}
		else
		{

			// CHECK NEAREST STRUCTURE
			_blocked = false;
			if( _type in structsCritical ) then
			{

				_neardist = 1000;
				_maxRadius = 0;

				_MapBuildings = nearestObjects [_posStruct, ["house"], 15];

				{
					if ( isObjectHidden _x ) then {_MapBuildings set[_forEachIndex, 0];};
				}forEach _MapBuildings;
				_MapBuildings = _MapBuildings - [0];

				_res = [_posStruct] call funcGetNearestStructure;

				if ( count(_res) > 2) then
				{
					_ts = _res select 1;
					_neardist = _res select 2;
					if ( _ts != -1 ) then {_maxRadius = (structDefs select _ts) select sdMaxRadius;};
				};

				// Check near Object
				if ( (_neardist < 0.5*_maxRadius) || (count(_MapBuildings) > 0) ) then
				{
					["Build pos blocked by structure.", true, false, htGeneral, false] call funcHint;
					_blocked = true;
				};

				// Check MHQ
				_pos = getPos mhq;
				_distance = _posStruct distance mhq;
				if (_distance < _radius) then
				{
					["Can't place structure here.\nToo close to MHQ", true, false, htGeneral, false] call funcHint;
					_blocked = true;
				};
			};

			if ( !_blocked ) then
			{

				_resources = (groupMoneyMatrix select playerSideIndex) select playerGroupIndex;
				_needed = _cost - _resources;

				// If more resources are needed then available report an error to player.
				if (_needed > 0) then
				{
					[Format["Not Enough Money\nNeed: %1\nCost: %2", _needed, _cost], true, false, htGeneral, false] call funcHint;
				}
				else
				{
					if(_float)then {_dirStruct = _dirStruct+500};

					pvBuildStruct = [_posStruct, _dirStruct, _type, playerGroupIndex,playerSideIndex];
					if ( isServer ) then
					{
						_nul = [pvBuildStruct] spawn MsgBuildStructure;
					}
					else
					{
						publicVariable "pvBuildStruct";
					};

					if (_type in structsCritical) then
					{
						if((count (BaseMatrix select _si))== 0 && (_si == siWest))then {pvbase1W = true;publicVariable "pvbase1W";};
						if((count (BaseMatrix select _si))== 0 && (_si == siEast))then {pvbase1E = true;publicVariable "pvbase1E";};

						if((count (BaseMatrix select _si))== 1 &&( mhqWest distance ((BaseMatrix select _si) select 0))>secondBaseDistance && (_si == siWest))then {pvbase2W = true;publicVariable "pvbase2W";};
						if((count (BaseMatrix select _si))== 1 &&( mhqEast distance ((BaseMatrix select _si) select 0))>secondBaseDistance && (_si == siEast))then {pvbase2E = true;publicVariable "pvbase2E";};
					};
				};
			};
		};
	};
};
