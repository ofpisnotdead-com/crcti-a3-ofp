// args: [_type, _si, _objects, <repaired>]

_type = _this select 0;
_si = _this select 1;
_objects = _this select 2;
_object = _objects select 0;
_timer = 0;

_temp = objnull;
_temp1 = objnull;
_temp2 = objnull;
_temp3 = objnull;

_Building = [];

if ( _si == siWest ) then
{
	_object addEventHandler ["killed", {_nul = [_this, siWest] spawn EventStructPrimDestroyed}];
};

if ( _si == siEast ) then
{
	_object addEventHandler ["killed", {_nul = [_this, siEast] spawn EventStructPrimDestroyed}];
};

_nul = [_object, _si, (structDefs select _type) select sdCost] execVM "Server\EventAddStructHit.sqf";

if (count _this < 4 ) then
{

	_positions = [];
	_dirs = [];
	_upVecs = [];

	{
		_obj = _x;
		_positions set [_forEachIndex, getPos _x];
		_dirs set [_forEachIndex, getDir _x];
		_upVecs set [_forEachIndex, vectorUp _x];
	}forEach _objects;

	_pos = _positions select 0;
	_dir = _dirs select 0;
	_up = _upVecs select 0;

	{
		_opos = getPos _x;
		_x setpos [_opos select 0, _opos select 1, 10000];
		_x setDamage 0.99;
		_x setVariable ["building", true, true];
	}forEach _objects;

	_index = count (repairableStructureMatrix select _si);
	(repairableStructureMatrix select _si) set [_index, [_object, 1, _type] ];

	_temp = createVehicle ["Land_Pallets_F", _pos, [],0,"NONE"];	
	_temp setdir _dir;	
	_temp setPos (getPos _temp);

	_temp1 = createVehicle ["Land_WorkStand_F", _pos, [],0,"NONE"];
	_temp1 setdir _dir;	
	_temp1 setPos (getPos _temp1);

	_temp2 = createVehicle ["RoadBarrier_F", _pos, [],0,"NONE"];
	_temp2 setdir _dir;	
	_temp2 setPos (getPos _temp2);

	_temp3 = createVehicle ["RoadBarrier_F", _pos, [],0,"NONE"];
	_temp3 setdir _dir;	
	_temp3 setPos (getPos _temp3);

	_timer = time;
	waitUntil {sleep 0.1 ; ((damage _object) < 0.1) || ((_timer + structTimeOut) < time)};

	deletevehicle _temp;
	deletevehicle _temp1;
	deletevehicle _temp2;
	deletevehicle _temp3;

	if ( damage _object < 0.1 ) then
	{
		{
			_x setVariable ["building", false, true];
			_pos = _positions select _forEachIndex;			
			_x setDir (_dirs select _forEachIndex);
			_x setpos [_pos select 0, _pos select 1, _pos select 2];
			_x setVectorUp (_upVecs select _forEachIndex);			
			_x setDamage 0;
		}forEach _objects;
	};

};