// args: [si, structTypes] (e.g. [siWest, [stBarracks, stLight] ])
// return: factory

private ["_res", "_queues", "_types", "_index", "_queue"];

_res = objNull;
_queues = factoryQueues select (_this select 0);
_types = _this select 1;

_index = 0;
_count = count _queues;
while {_index < _count && isNull _res} do
{
	_queue = _queues select _index;

	if ( ((_queue select 1) in _types)
		   && !(isNull (_queue select 0))
			 && alive (_queue select 0)
			 && (count (_queue select 2)) == 0 ) then
	{
		_res = _queue select 0;
	};
	_index = _index + 1;
};

_res