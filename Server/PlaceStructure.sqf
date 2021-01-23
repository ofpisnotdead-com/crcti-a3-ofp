// args: [_type, _si, _gi, _pos, _dir]

_type = _this select 0;
_si = _this select 1;
_gi = _this select 2;
_pos = _this select 3;
_dir = _this select 4;
_FloatObj = _this select 5;

_structDesc = structDefs select _type;

_posStruct = _pos;

if ( _FloatObj && (_type in structsFloat) ) then
{
	_group = (groupMatrix select _si) select _gi;
	_unit = leader _group;
	_posUnit = _unit modelToWorld [0,0,0];
	_posStruct set [2, (_posUnit select 2)];
}
else
{
	_posStruct set [2, 0];
};

_parts = _structDesc select ([sdObjectsWest, sdObjectsEast] select (_si == siEast));
_objects = [];

{

	_part = _x;
	_posPartRel = _part select 2;

	if (count _posPartRel == 0) then {_posPartRel = [0,0,0];};

	_posPartX = (_posStruct select 0) + (_posPartRel select 0)*(cos _dir) + (_posPartRel select 1)*(sin _dir);
	_posPartY = (_posStruct select 1) + (_posPartRel select 1)*(cos _dir) - (_posPartRel select 0)*(sin _dir);
	_posPart = [ _posPartX, _posPartY, (_posStruct select 2) + (_posPartRel select 2) ];
	_dirPart = (_dir + (_part select 1)) % 360;

	_object = createVehicle [(_part select 0) , [_posPart select 0, _posPart select 1, 10000], [],0,"NONE"];
	_object setDir _dirPart;
	_object setPosATL _posPart;
	
	if ( count(_part) > 3 ) then
	{
		_upVec = _part select 3;
		_object setVectorUp _upVec;
	};

	if(_type in structsRespawn || _FloatObj)then {_object setVectorUp [0,0,1];};

	if (isNull gunner _object) then {(gunMatrix select _si) set [count (gunMatrix select _si), _object];};

	_objects set [count _objects, _object];

}forEach _parts;

(structTimes select _si) set [_type, time + (_structDesc select sdBuildLimitTime)];
publicVariable "structTimes";

_index = count ((structMatrix select _si) select _type);
((structMatrix select _si) select _type) set [_index, _objects select 0];
publicVariable "structMatrix";

_index = count structuresServer;
structuresServer set [_index, [_objects, _type] ];

primStructsPlaced = primStructsPlaced + [_objects select 0];

_scriptsServer = _structDesc select sdScriptsServer;
{
	_script = format["Server\%1", _x];
	[_type, _si, _objects] execVM _script;
}foreach _scriptsServer;

[_si, _gi,_type, _objects] execVM "Server\InsertIntoUndoList.sqf";

{
	_group = _x;
	{
		_group reveal _x;
	}foreach _objects;
}foreach (groupAiMatrix select _si);

pvStructBuilt = [_objects select 0, _type, _si, _gi, true, _objects];
_nul = [pvStructBuilt] spawn MsgStructBuilt;
publicVariable "pvStructBuilt";
