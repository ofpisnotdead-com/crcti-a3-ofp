if ( isServer ) then
{
	_value = _this select 0;

	_upg = _value select 0;
	_si = _value select 1;

	_nul = [_upg, _si] execVM "Server\StartUpgrade.sqf";
};