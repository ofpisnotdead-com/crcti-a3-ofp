if ( !isNull player ) then
{
	_value = _this select 0;
	_msgType = _value select 0;

	_scriptShort = (infoDefs select _msgType) select 0;
	_script = format ["Player\Info\%1", _scriptShort];

	_value execVM _script;
};

