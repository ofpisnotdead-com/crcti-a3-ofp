_si = _this select 1;
_msgs = _this select 2;

if ( _si == playerSideIndex ) then
{
	_text = "";
	{
		_to = _x select 0;
		_from = _x select 1;
		_amount = _x select 2;
		_toName = [playerSideIndex, _to] call funcGetGroupName;
		_fromName = [playerSideIndex, _from] call funcGetGroupName;

		if ( _to == playerGroupIndex ) then
		{
			if ( _text != "" ) then {_text = format["%1\n", _text];};
			_text = format["%1Requesting %2$ from %3.", _text, _amount, _fromName];
		};
		if ( _from == playerGroupIndex ) then
		{
			if ( _text != "" ) then {_text = format["%1\n", _text];};
			_text = format["%1%2 needs %3$.", _text, _toName, _amount];
		};
	}forEach _msgs;

	if ( _text != "" ) then
	{
		[_text, false, true, htMoneyRequest, true] call funcHint;
		if ( isNil "lastREQText" ) then {lastREQText = "";};
		if ( _text != lastREQText ) then
		{
			// <<--- hier sound abspielen
			lastREQText = _text;
		};
	};

};