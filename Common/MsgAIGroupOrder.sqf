_msg = _this select 0;

_si = _msg select 0;
_gi = _msg select 1;
_type = _msg select 2;
_param0 = _msg select 3;
_param1 = _msg select 4;
_param2 = _msg select 5;

_id = ((orderMatrix select _si) select _gi) select 0;
(orderMatrix select _si) set [_gi, [_id+1, _type, [_param0, _param1, _param2]]];

if ( !isNull player && _si == playerSideIndex ) then
{
	_group = (groupMatrix select _si) select _gi;
	(leader _group) commandChat format["Roger, %1", ((orderMatrix select _si) select _gi) call funcGetOrderDesc];
};

