private ["_unit", "_target", "_et", "_wep", "_weapons", "_count"];

_unit = _this select 0;
_target = _this select 1;

if ( !local _unit ) then
{
	[_this, "funcFireAt", _unit, false, false] call BIS_fnc_MP;
}
else
{
	_unit doWatch _target;
	_unit doTarget _target;
	_unit doFire _target;

	_weapons = weapons _unit;
	_wep = _weapons select random(count(_weapons)-1);

	_et = time + 10;
	
	waitUntil {_unit aimedAtTarget [_target] > 0 || time > _et};
	_count = 0;
	while  { (_unit aimedAtTarget [_target]) > 0 && _count < 5 } do
	{
		_count = _count + 1;
		_unit fireAtTarget [_target, _wep];
		_unit fireAtTarget [_target];
		sleep 1;
	};

};