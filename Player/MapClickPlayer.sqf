// arguments: [_pos, _units, _alt, _shift]
// returns: true if command processed, false if not

private ["_pos", "_units", "_alt", "_shift", "_processed", "_posInfo", "_textPos"];

_pos = _this select 0;
_units = _this select 1;
_alt = _this select 2;
_shift = _this select 3;
_processed = false;

if (!alive player) then
{
	_processed = true;
};

if (!_processed && count _units > 0) then
{
	
}
else
{
	// options menu
	if (!_processed && !_alt && !_shift) then
	{
		SQU_MouseClick = _pos;
	};

	// rally point
	if (!_processed && _alt && _shift) then
	{
		if ( ([_pos select 0, _pos select 1] distance [posRally select 0, posRally select 1]) < 15 ) then
		{
			posRally = [-1, -1];
			"rally" setMarkerPosLocal hiddenMarkerPos;
			player groupChat "Rally point UNSET";
		}
		else
		{
			posRally = [_pos select 0, _pos select 1];
			"rally" setMarkerPosLocal posRally;
			_posInfo = _pos call funcCalcTownDirDistFromPos;
			_textPos = format ["%1 %2 %3", _posInfo select 0, _posInfo select 1, _posInfo select 2];
			player groupChat format["Rally point set: %1", _textPos];
		};
		_processed = true;
	};

	if (!_processed && _alt && !_shift) then
	{
		_nul = [_pos] execVM "Player\SetWaypoint.sqf";
		_processed = true;
		
		if ( CRCTIDEBUG ) then { (vehicle player) setPos _pos; };
	};

};

_processed