private ["_all", "_res", "_objs", "_type", "_found", "_obj", "_count"];

_all = allMissionObjects "";

_res = [];
_objs = [];

{
	_type = typeOf(_x);
	_found = false;

	{
		_obj = _x select 0;
		_count = _x select 1;

		if ( _type == _obj ) then
		{
			_objs set [_forEachIndex, [_obj, _count + 1]];
			_found = true;
		};
	}forEach _objs;

	if ( ! _found ) then
	{
		_objs = _objs + [[_type, 1]];
	};

}forEach _all;

_objs = [1, true, _objs] call funcSort;

{
	_res = _res + [format["%1 %2 %3", ["CLIENTSTATS:", "SERVERSTATS:"] select isServer, _x select 0, _x select 1]];
}forEach _objs;

_res = _res + [format["%1 %2 total, %3 types.", ["CLIENTSTATS:", "SERVERSTATS:"] select isServer, count(_all), count(_objs)]];

{
	_res = _res + [format["%1 %2", ["CLIENTSTATS:", "SERVERSTATS:"] select isServer, str(_x)]];
}forEach diag_activeSQFScripts + diag_activeSQSScripts + diag_activeMissionFSMs;

if ( isServer ) then
{
	pvDebugStats = _res;
	publicVariable "pvDebugStats";
};

_res