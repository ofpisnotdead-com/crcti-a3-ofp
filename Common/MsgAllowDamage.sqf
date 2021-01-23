_pvAllowDamage = _this select 0;

_vehicle = _pvAllowDamage select 0;
_value = _pvAllowDamage select 1;

_vehicle allowDamage _value;
