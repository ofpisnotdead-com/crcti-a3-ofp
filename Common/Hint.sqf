private ["_text", "_fail", "_silent", "_type", "_replace", "_cat", "_t", "_lines", "_cats", "_last", "_line"];

_text = _this select 0;
_fail = _this select 1;
_silent = _this select 2;
_type = _this select 3;
_replace = _this select 4;

if ( _replace ) then
{
	hintTexts set [_type, [[_text, time]]];
}
else
{
	_cat = hintTexts select _type;
	_cat set [count _cat, [_text, time]];
	hintTexts set [_type, _cat];
};

_lines = [];
_last = "";

{
	_cat = hintTexts select _x;
	{
		_line = _x;

		if ( count _line == 2 ) then
		{
			if ( time - (_line select 1) < HintTimeOut ) then
			{
				if ( (_line select 0) != _last ) then
				{
					_lines = _lines + [_line];
					_last = (_line select 0);
				};
			}
			else
			{
				_cat set [_forEachIndex, objNull];
			};
		};
	}forEach _cat;
	_cat = _cat - [objNull];
	hintTexts set [_x, _cat];

}forEach hintTypes;

_lines = [1, false, _lines] call funcSort;

_t = "";
{
	if ( _forEachIndex == 0 ) then
	{
		_t = _x select 0;
	}
	else
	{
		_t = format["%1\n\n%2", _t, _x select 0];
	};
}forEach _lines;

if ( _silent ) then
{
	hintSilent _t;
}
else
{
	if ( _fail ) then
	{
		playSound "dong";
	}
	else
	{
		playSound "ding";
	};
	hintSilent _t;
};