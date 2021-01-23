// args: [params]

_gi = _this select 1;
_si = _this select 2;

_group = (groupMatrix select _si) select _gi;

if (playerSideIndex == _si && playerGroupIndex == _gi) then
{
	_text = "You are now the Commander";
	player groupchat _text;
	[_text, false, false, htGeneral, false] call funcHint;
};

if (playerSideIndex == _si && playerGroupIndex != _gi) then
{
	_name = [_si,_gi] call funcGetGroupName;
	_text = format["New Commander: %1", _name];
	[_text, false, false, htGeneral, false] call funcHint;
};