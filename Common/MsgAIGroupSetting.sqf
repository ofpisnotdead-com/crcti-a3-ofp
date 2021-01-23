_value = _this select 0;

_si = _value select 0;
_gi = _value select 1;
_type = _value select 2; 
_setting = _value select 3;

((aiSetting select _si) select _gi) set [_type, _setting];


if ( !isNull player && _si == playerSideINdex ) then
{
	_group = (groupMatrix select _si) select _gi;
	_nameType = (aiSettingDefs select _type) select 0;
	_nameSetting = ((aiSettingDefs select _type) select 1) select _setting;

	(leader _group) commandChat format["Copy, %1 at %2", _nameType, _nameSetting];
};



