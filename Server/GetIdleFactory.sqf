// args: [si, structTypes, baselimit] (e.g. [siWest, [stBarracks, stLight] ])
// return: factory

private ["_res", "_si", "_queues", "_types", "_baseLimit", "_dist", "_count", "_index", "_queue", "_object", "_type", "_fac"];

_res = [];
_si = _this select 0;
_queues = factoryQueues select _si;
_types = _this select 1;
_baseLimit = _this select 2;

_dist = 0;
if ( _baseLimit > count(BaseMatrix select _si) ) then {_baseLimit = 0;};

_count = count _queues;
for [ {_index=0}, {_index<_count}, {_index=_index+1}] do
{
	_queue = _queues select _index;
	_object = _queue select 0;
	_type = _queue select 1;

	if ( _baseLimit > 0 ) then
	{
		_dist = (getPos _object) distance ((BaseMatrix select _si) select (_baseLimit -1));
	};

	if ( (_type in _types) && !(isNull _object) && (alive _object) && (damage _object < 0.99) && !(_object in buildingsInUse) && (_dist < 150) ) then
	{
		_res set [count(_res), _queue select 0];
	};
};

_fac = objNull;
if ( count _res > 0 ) then
{
	_fac = _res select (floor(random(count _res)));
};

_fac