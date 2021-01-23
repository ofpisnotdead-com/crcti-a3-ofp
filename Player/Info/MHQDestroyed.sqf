// args: [params]

_siMHQ = _this select 1;
_siKiller = _this select 2;
_giKiller = _this select 3;

if (playerSideIndex == _siMHQ) then
{
	_sideText = ["OPFOR", "BLUFOR"] select (_siMHQ == siWest);
	_enemyText = ["BLUFOR", "OPFOR"] select (_siMHQ == siWest);

	_giCO = giCO select _siMHQ;
	_siEnemy = siEnemy select _siMHQ;
	_giEnemyCO = giCO select _siEnemy;

	_nameCO = [_siMHQ,_giCO] call funcGetGroupName;
	_nameEnemyCO = [_siEnemy,_giEnemyCO] call funcGetGroupName;

	_title = format["<t size='2.3' font='PuristaBold' shadow='2'>MHQ DESTROYED!</t><br /><t size='.85'>%1 MHQ has just been destroyed!</t>", _sideText];	
	_scroll = "<t color='#FF0000' shadow='2'>- AAN -</t> ";
	_scroll = format["%1%2", _scroll, "BREAKING NEWS -- MHQ DESTROYED "];
	_scroll = format["%1%2", _scroll, "<t color='#FF0000' shadow='2'>- AAN -</t> "];
	_scroll = format["%1%2", _scroll, format["Unconfirmed sources report: %1 MHQ has been destroyed. ", _sideText]];
	_scroll = format["%1%2", _scroll, "<t color='#FF0000' shadow='2'>- AAN -</t> "];
	_scroll = format["%1%2", _scroll, format["%1 Commander %2 comments: 'WTF?!' ", _sideText, _nameCO]];
	_scroll = format["%1%2", _scroll, "<t color='#FF0000' shadow='2'>- AAN -</t> "];
	_scroll = format["%1%2", _scroll, format["%1 Commander %2 replies: 'HAHA!!' ", _enemyText, _nameEnemyCO]];

	_text1 = "Our MHQ has been destroyed";
	if (_siMHQ != _siKiller) then
	{
		[_text1, true, false, htGeneral, false] call funcHint;
	}
	else
	{
		_name = [_siKiller,_giKiller] call funcGetGroupName;
		_text2 = format["MHQ Destroyed by our side: %1", _name];
		[format["%1\n\n%2", _text1, _text2], true, false, htGeneral, false] call funcHint;

		_scroll = format["%1%2", _scroll, "<t color='#FF0000' shadow='2'>- AAN -</t> "];
		_scroll = format["%1%2", _scroll, format["Preliminary investigations hint at a possible friendly fire by %1. %1 says: 'I am so sorry. I will never kill the MHQ again.' ", _name]];

	};

	_scroll = format["%1%2", _scroll, "<t color='#FF0000' shadow='2'>- AAN -</t> Stay tuned. More at 11. "];
	_scroll = format["%1%2", _scroll, _scroll];
	_scroll = format["%1%2", _scroll, _scroll];
	_scroll = format["                                                                       %1", _scroll];
	
	_nul = [parsetext(_title),parsetext(_scroll)] spawn BIS_fnc_AAN;
	sleep 90;

	(uinamespace getvariable "BIS_AAN") closedisplay 1
};