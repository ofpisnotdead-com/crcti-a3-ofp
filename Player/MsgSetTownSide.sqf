if ( !isNull player ) then
{

	_value = _this select 0;
	_index = _value select 0;
	_si = _value select 1;
	_lastSide = _value select 2;

	_townDesc = towns select _index;
	_town = _townDesc select 0;

	(towns select _index) set [tdSide, _si];

	if (_si == playerSideIndex || _lastSide == playerSideIndex || playerSideIndex == siCiv) then
	{
		_marker = Format["Town_%1", _index];

		// color
		if (_si == playerSideIndex && _si == siWest ) then {_marker setMarkerColorLocal "colorBlue";};
		if (_si == playerSideIndex && _si == siEast ) then {_marker setMarkerColorLocal "colorRed";};
		if (_si != playerSideIndex) then {_marker setMarkerColorLocal "colorBlack";};
		if (playerSideIndex == siCiv && _si == siWest) then {_marker setMarkerColorLocal "colorBlue";};
		if (playerSideIndex == siCiv && _si == siEast) then {_marker setMarkerColorLocal "colorRed";};

		_towns = [0,0,0];
		{
			_si2 = (_x select tdSide);
			_towns set [_si2, (_towns select _si2) + 1];
		}foreach towns;

		// announce
		//? (playerSideIndex == siCiv): titleText [Format["\n\n\n\n\n\n\n\n%1 has taken %2.", sideNames select _si, _townDesc select 1], "Plain"]

		if ( (playerSideIndex != siCiv) && (_si == playerSideIndex) ) then
		{
			[format["%1 WON from %2. (controlling %3 towns)", _townDesc select 1, sideNames select _lastSide, _towns select playerSideIndex], false, false, htTownSideChange, false] call funcHint;
		};

		if ( (playerSideIndex != siCiv) && (_si != playerSideIndex) ) then
		{
			[format["%1 LOST. (controlling %2 towns)", _townDesc select 1, _towns select playerSideIndex], true, false, htTownSideChange, false] call funcHint;
		};

	};

};