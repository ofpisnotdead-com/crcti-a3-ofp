// args: [params]

waitUntil {!isNil "crcti_kb_initPlayerDone"};
waitUntil {crcti_kb_initPlayerDone};

_gi = _this select 1;
_si = _this select 2;

_group = (groupMatrix select _si) select _gi;

if ( _si == playerSideIndex && playerGroup == (groupCommander select _si)) then
{
	[format["AI group is now under your control: %1", _group], false, false, htGeneral, false] call funcHint;
};