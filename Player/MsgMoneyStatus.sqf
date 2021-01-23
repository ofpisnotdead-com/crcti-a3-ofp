_value = _this select 0;
_si = _value select 0;
_gi = _value select 1;
_amount = _value select 2;

if ( !isServer ) then
{
	(groupMoneyMatrix select _si) set [_gi, _amount];
};
