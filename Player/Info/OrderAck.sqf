// args: [params]

_type = _this select 1;
_gi = _this select 2;
_si = _this select 3;

if (_si == playerSideIndex) then
{   
	_nameGroup = (groupNameMatrix select _si) select _gi;
	_nameOrder = (orderDefs select _type) select 0;
	player groupChat format["%1: Order Acknowledged - %2", _nameGroup, _nameOrder];
};
