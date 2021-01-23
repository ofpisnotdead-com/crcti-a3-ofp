_group = (_this select 0);
_side = side _group;

if ( _side == WEST ) then
{
	if ( isNil "GroupsWest" ) then {GroupsWest = [];};	
	GroupsWest = GroupsWest + [_group];
};

if ( _side == EAST ) then
{
	if ( isNil "GroupsEast" ) then {GroupsEast = [];};	
	GroupsEast = GroupsEast + [_group];
};