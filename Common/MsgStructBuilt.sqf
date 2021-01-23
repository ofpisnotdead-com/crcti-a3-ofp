_pvStructBuilt = _this select 0;

waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!isNull mhqWest && !isNull mhqEast};

if ( isServer ) then
{
	StructInitList = StructInitList + [_pvStructBuilt];
};

if ( !isNull player ) then
{
	waitUntil {!isNil "crcti_kb_initPlayerDone"};
	waitUntil {crcti_kb_initPlayerDone};

	_object = _pvStructBuilt select 0;
	_type = _pvStructBuilt select 1;
	_si = _pvStructBuilt select 2;
	_gi = _pvStructBuilt select 3;
	_new = _pvStructBuilt select 4;
	_objects = _pvStructBuilt select 5;

	if( (alive _object) && !(isnull _object)) then
	{
		_initialized = _object getVariable ["initialized", false];

		if( !_initialized ) then
		{
			_object setVariable ["initialized", true];
			_SiGi = [_si,_gi,_type,true];
			{
				_x setVariable["SQU_SI_GI", _SiGi, true];
			}forEach _objects;

			//player sidechat format ["_object= %1|||_type= %2|||_si= %3|||(isNull gunner _object)= %4",_object,_type,_si,(isNull gunner _object)];
			if ( _new ) then {(structsBuilt select _si) set [ _type, 1 + ((structsBuilt select _si) select _type) ]};

			if (_si == playerSideIndex) then
			{
				_desc = structDefs select _type;
				_scripts = _desc select sdScriptsPlayer;

				{
					_script = format ["Player\%1", _x];
					[_object, _type, _si, _gi, _objects] execVM _script
				}foreach _scripts;
			};
		};
	};
};

