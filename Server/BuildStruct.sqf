// args: [type, si, gi, pos, dir]
// return: objects

private [
"_type", "_si", "_gi", "_pos", "_dir", "_objects", "_desc", "_parts", "_i", "_c",
"_part", "_posPartRel", "_posPartX", "_posPartY", "_posPart", "_dirPart", "_obj",
"_group", "_x"
];

_type = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_pos = _this select 3;
_dir = _this select 4;

_objects = [];

_desc = structDefs select _type;

if(_type in structsFloat)then
{
	_group = (groupMatrix select _si) select _gi;
	_unit = leader _group; _posUnit = _unit modelToWorld [0,0,0];
	_posStruct set [2, (_posUnit select 2)]
} else {
	_posStruct set [2, 0]
};

_pos set [2, 0];

_parts = _desc select ([sdObjectsWest, sdObjectsEast] select (_si == sieast));

_i = 0;
_c = count _parts;
while {_i<_c}do
{
	_part = _parts select _i;
	_posPartRel = _part select 2;
	if (count _posPartRel == 0) then {_posPartRel = [0,0,0]};
	_posPartX = (_pos select 0) + (_posPartRel select 0)*(cos _dir) + (_posPartRel select 1)*(sin _dir);
	_posPartY = (_pos select 1) + (_posPartRel select 1)*(cos _dir) - (_posPartRel select 0)*(sin _dir);
	_posPart = [ _posPartX, _posPartY, (_pos select 2) + (_posPartRel select 2) ];
	_dirPart = (_dir + (_part select 1)) % 360;

	_obj = createVehicle [(_part select 0) , [_posPart select 0, _posPart select 1, 10000], [], 0, "None"];
	_obj setDir _dirPart;
	_obj setPos _posPart;
	
	if ( count(_part) > 3 ) then
	{
		_upVec = _part select 3;
		_obj setVectorUp _upVec;
	};

	if (isNull gunner _obj) then {(gunMatrix select _si) set [count (gunMatrix select _si), _obj]};
	
	_objects set [count _objects, _obj];

	_i=_i+1;
};

(structTimes select _si) set [_type, time + (_desc select sdBuildLimitTime)];
publicVariable "structTimes";

_i = count ((structMatrix select _si) select _type);
((structMatrix select _si) select _type) set [_i, _objects select 0];
publicVariable "structMatrix";

_i = count structuresServer;
structuresServer set [_i, [_objects, _type] ];

primStructsPlaced = primStructsPlaced + [_objects select 0];

{	_script = format["Server\%1", _x]; [_type, _si, _objects] execVM _script}foreach (_desc select sdScriptsServer);

[_si, _gi, _type, _objects] execVM "Server\InsertIntoUndoList.sqf";

{	_group = _x; {_group reveal _x}foreach _objects}foreach (groupAiMatrix select _si);

pvStructBuilt = [_objects select 0, _type, _si, _gi, true, _objects];
_nul = [pvStructBuilt] spawn MsgStructBuilt;
publicVariable "pvStructBuilt";

_cost = _desc select sdCost;

[_si, _gi, _cost] call funcMoneySpend;

_objects
