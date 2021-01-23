_pvSitrep = _this select 0;

_gi = _pvSitrep select 0;
_si = _pvSitrep select 1;

if ( _si == playerSideIndex && MapMode < 3 && count ([_si, stComm] call funcGetWorkingStructures) > 0 ) then
{
	_group = (groupMatrix select _si) select _gi;
	_leader = leader _group;
	_name = [_si,_gi] call funcGetGroupName;

	_posTex = (getPos _leader) call funcCalcMapPos;
	_text = format["%1 is at Position %2", _name, _posTex];

	{
		_h = date select 3;
		_m = date select 4;

		if ( _m < 10 ) then {_m = format["0%1",_m];};

		_desc = format["%1:%2", _h,_m];
		_col = "ColorOrange";
		_size = [0.25,0.25];

		if ( _x == leader _group ) then
		{
			_desc = format["%1 %2:%3", _name, _h,_m];
			_col = "ColorBlue";
			_size = [0.5,0.5];
		};

		if ( (MapMode == 1 && _x == leader _group) || MapMode == 2) then
		{
			_pos = getPos _x;
			_marker = format["SitRepMarker_%1_%2_%3", _si, _gi, _forEachIndex];
			createMarkerLocal [_marker, _pos];
			_marker setMarkerPosLocal _pos;
			_marker setMarkerTypeLocal "n_inf";
			_marker setMarkerColorLocal _col;
			_marker setMarkerTextLocal _desc;
			_marker setMarkerSizeLocal _size;
		};

	}forEach units _group;

	_leader sideChat _text;
};