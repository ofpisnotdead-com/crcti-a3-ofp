// args: [si, gi, type, setting]
private ["_si", "_gi", "_type", "_setting"];

_si = _this select 0;
_gi = _this select 1;
_type = _this select 2;
_setting = _this select 3;

pvSetting = [_si, _gi, _type, _setting];
_nul = [pvSetting] spawn MsgAIGroupSetting;
publicVariable "pvSetting";

