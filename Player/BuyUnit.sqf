// args: [nType, nDriver, nGunner, nCommander, giJoin, oFactory]
private ["_type", "_driver", "_gunner", "_commander", "_giJoin", "_gi", "_si", "_factory"];

_type = _this select 0;
_driver = _this select 1;
_gunner = _this select 2;
_commander = _this select 3;
_giJoin = _this select 4;
_gi = playerGroupIndex;
_si = playerSideIndex;
_factory = _this select 5;

if ( !isNull _factory ) then
{
	pvBuyUnit = [_type, _driver, _gunner, _commander,_giJoin,_gi,_si,_factory];
	if ( isServer ) then
	{
		_nul = [pvBuyUnit] spawn MsgBuyUnit;
	}
	else
	{
		publicVariable "pvBuyUnit";
	};
};

