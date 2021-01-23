_value = _this select 0;
_si = _value select 0;
_amount = _value select 1;

if ( !isServer ) then
{
	moneySideTotal set [_si, _amount];
};

