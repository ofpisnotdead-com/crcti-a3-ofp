// args: [_si,_gi] or [-1,-1, group]

private ["_si", "_gi", "_group", "_name", "_leader"];

_si = _this select 0;
_gi = _this select 1;

_group = grpNull;
_name = "";

if ( count(_this) > 2 ) then
{
	_group = _this select 2;
};

if ( !isNull _group ) then
{
	_sigi = (leader _group) call funcGetSideAndGroup;
	_si = _sigi select 0;
	_gi = _sigi select 1;
};

if ( isNull _group && _si != -1 && _gi != -1 ) then
{
	_group = (groupMatrix select _si) select _gi;
};

_leader = leader _group;

if ( isPlayer _leader ) then
{
	_name = name _leader;
}
else
{
	if ( _si != -1 && _gi != -1 ) then
	{
		_name = format["AI %1", (groupNameMatrix select _si) select _gi];
	};
};

if ( _si != -1 ) then
{
	if ( _group == (groupCommander select _si) ) then
	{
		_name = format["%1 (C)", _name];
	};
};

_name