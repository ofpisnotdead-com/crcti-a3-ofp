_value = _this select 0;

_wp = _value select 0;
_gi = _value select 1;
_si = _value select 2;
_pos = _value select 3;

((wpCO select _si) select _wp) set [0, _pos select 0];
((wpCO select _si) select _wp) set [1, _pos select 1];

if ( !isNull player && playerSideIndex == _si ) then
{
	waitUntil {!isNil "crcti_kb_initPlayerDone"};
	waitUntil {crcti_kb_initPlayerDone};

	_marker = format["co_%1", _wp];
	_marker setMarkerPosLocal hiddenMarkerPos;

	if ( (_pos select 0) != -1 && (_pos select 1) != -1 ) then
	{
		_group = (groupMatrix select _si) select _gi;
		(leader _group) commandChat format["CO waypoint %1 set. %2 %3", _wp, _pos call funcCalcMapPos, _pos call funcCalcTownDirDistFromPos ];
		_marker setMarkerPosLocal _pos;
	};

};
