_value = _this select 0;
_amount = _value select 0;
_giFrom = _value select 1;
_giTo = _value select 2;
_si = _value select 3;

if ( !isNull player ) then
{
	if ( (playerSideIndex == _si) && (playerGroupIndex == _giTo) ) then
	{
		if ( ! (((groupMatrix select _si) select _giFrom) in (groupAiMatrix select _si)) ) then
		{
			_nameFrom = name leader ((groupMatrix select _si) select _giFrom);
			player groupchat format ["You received $%1 from %2", _amount, _nameFrom];
		};
	};
};

