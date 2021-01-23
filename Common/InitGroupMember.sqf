private["_unit", "_side", "_groupID", "_score", "_event"];

_unit = _this select 0;
_side = _this select 1;
_groupID = _this select 2;
_score = _this select 3;

_event = format["[_this, %1, %2] spawn EventInfantryKilled", _side, _score];
_unit addEventHandler ["killed", _event];
_event = format["[_this, %1, %2, %3] spawn EventRespawn", _side, _groupId, (_unit == leader (group _unit))];
_unit addEventHandler ["respawn", _event];

if ( (isPlayer _unit && FatigueEnabled > 1) || ((!isPlayer _unit) && (FatigueEnabled == 1 || FatigueEnabled == 3))) then
{
	_unit enableFatigue true;
}
else
{
	_unit enableFatigue false;
};