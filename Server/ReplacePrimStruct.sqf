// args: [_objectDestroyed, _type, _si]

_objectDestroyed = _this select 0;
_type = _this select 1;
_si = _this select 2;
_gi = _this select 3;

if (!isNull _objectDestroyed ) then
{

	_model = typeOf _objectDestroyed;
	_posStruct = getPos _objectDestroyed;
	_posStruct set [2, 0];
	_dir = getDir _objectDestroyed;

	_structDesc = structDefs select _type;
	_parts = _structDesc select ([sdObjectsWest, sdObjectsEast] select (_si == siEast));

	_objects = [];

	_part = _parts select 0;
	_object = createVehicle [(_part select 0), [_posStruct select 0, _posStruct select 1, 10000], [],0,"NONE"];
	_object setDir _dir;
	_object setPos _posStruct;
	
	if ( count(_part) > 3 ) then
	{
		_upVec = _part select 3;
		_object setVectorUp _upVec;
	};

	if (isNull gunner _object) then {(gunMatrix select _si) set [count (gunMatrix select _si), _object];};

	_objects set [count _objects, _object];

	_index = count ((structMatrix select _si) select _type);
	((structMatrix select _si) select _type) set [_index, _objects select 0];
	publicVariable "structMatrix";

	_index = count structuresServer;
	structuresServer set [_index, [_objects, _type] ];

	_scriptsServer = _structDesc select sdScriptsServer;

	{
		_script = format["Server\%1", _x];
		[_type, _si, _objects, "Repaired"] execVM _script;
	}foreach _scriptsServer;

	{
		_group = _x;
		{
			_group reveal _x;
		}foreach _objects;
	}foreach (groupAiMatrix select _si);

	pvStructBuilt = [_objects select 0, _type, _si, _gi, false, _objects];
	_nul = [pvStructBuilt] spawn MsgStructBuilt;
	publicVariable "pvStructBuilt";

	sleep 2;
	_objectDestroyed setPos [0,0,0];
	deleteVehicle _objectDestroyed;
};