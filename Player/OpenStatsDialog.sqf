// args [si]
disableSerialization;

_siShow = _this select 0;
_back = _this select 1;

_dlg = createDialog "StatsDialog";
[IDD_StatsDialog]call funcFixDialogTitleColor;

_idc = IDC_TEXT_MONEYWEST;
_si = siWest;
if (_siShow == _si || _siShow == siBoth) then
{
	ctrlSetText [_idc, format["%1/%2", moneySideTotal select _si, moneySideSpent select _si] ];
}
else {ctrlSetText [_idc, "?/?"];
};

_idc = IDC_TEXT_MONEYEAST;
_si = siEast;
if (_siShow == _si || _siShow == siBoth) then
{
	ctrlSetText [_idc, format["%1/%2", moneySideTotal select _si, moneySideSpent select _si] ];
}
else
{
	ctrlSetText [_idc, "?/?"];
};

_idc = IDC_LB_STRUCTSWEST;
lbClear _idc;
_index = 0;
_si = siWest;
{
	if (_siShow != _si && _siShow != siBoth) then
	{
		_x=-1;
	};
	_sides = ((structDefs select _index) select sdSides);
	if ((_sides == siBoth || _si == _sides) && _x > 0 ) then
	{
		_spacer = " ";
		if(_x<10)then {_spacer=_spacer+" "};
		if(_x<100)then {_spacer=_spacer+" "};
		_name = (structDefs select _index) select sdName;
		lbAdd[_idc, format["%1%2%3", [_x, "?"] select (_x == -1), _spacer, _name]];
	};
	_index = _index + 1;
}foreach (structsBuilt select _si);

_idc = IDC_LB_UNITSWEST;
lbClear _idc;
_index = 0;
_si = siWest;
{
	if (_siShow != _si && _siShow != siBoth) then
	{
		_x=-1;
	};
	if (_si == ((unitDefs select _index) select udSide) && _x > 0 ) then
	{
		_spacer = " ";
		if(_x<10)then {_spacer=_spacer+" "};
		if(_x<100)then {_spacer=_spacer+" "};
		_name = (unitDefs select _index) select udName;
		lbAdd[_idc, format["%1%2%3", [_x, "?"] select (_x == -1), _spacer, _name]];
	};
	_index = _index +1;
}foreach (unitsBuilt select _si);

_idc = IDC_LB_STRUCTSEAST;
lbClear _idc;
_index = 0;
_si = siEast;
{
	if (_siShow != _si && _siShow != siBoth) then
	{
		_x=-1;
	};
	_sides = ((structDefs select _index) select sdSides);
	if ((_sides == siBoth || _si == _sides) && _x > 0 ) then
	{
		_spacer = " ";
		if(_x<10)then {_spacer=_spacer+" "};
		if(_x<100)then {_spacer=_spacer+" "};
		_name = (structDefs select _index) select sdName;
		lbAdd[_idc, format["%1%2%3", [_x, "?"] select (_x == -1), _spacer, _name]];
	};
	_index = _index +1;
}foreach (structsBuilt select _si);

_idc = IDC_LB_UNITSEAST;
lbClear _idc;
_index = 0;
_si = siEast;
{
	if (_siShow != _si && _siShow != siBoth) then
	{
		_x=-1;
	};
	if (_si == ((unitDefs select _index) select udSide) && _x > 0 ) then
	{
		_spacer = " ";
		if(_x<10)then {_spacer=_spacer+" "};
		if(_x<100)then {_spacer=_spacer+" "};
		_name = (unitDefs select _index) select udName;
		lbAdd[_idc, format["%1%2%3", [_x, "?"] select (_x == -1), _spacer, _name]];
	};
	_index = _index +1;
}foreach (unitsBuilt select _si);

while {dialog}do
{
	if (!ctrlVisible IDC_TEXT_MONEYWEST || !alive player) then {closeDialog 0;};	
};

if ( _back ) then { _nul = [] exec "Player\OpenOptionsMenu.sqs"; };