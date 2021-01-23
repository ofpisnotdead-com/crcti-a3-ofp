// [IDD, IDC, text]
private ["_display", "_ctrl", "_text", "_idd", "_idc"];

_idd = _this select 0;
_idc = _this select 1;
_text = _this select 2;

disableSerialization;

_display = findDisplay _idd;
_ctrl = _display displayCtrl _idc;
_ctrl ctrlSetText _text;
