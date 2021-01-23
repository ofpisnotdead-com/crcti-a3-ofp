// args: [params]

_si = _this select 1;

if (_si == playerSideIndex) then
{
	_text = "Our MHQ has been repaired";
	[_text, false, false, htGeneral, false] call funcHint;
	player sidechat _text;
};
