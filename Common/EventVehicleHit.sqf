// args: [[vehicle, source, amount], siUnit, score]

_vehicle = (_this select 0) select 0;
_source = (_this select 0) select 1;
_amount = (_this select 0) select 2;
_siVehicle = _this select 1;
_scoreTotal = _this select 2;
_destroyed = _this select 3;

_lastDamage = _vehicle getVariable "lastDamage";
if ( isNil "_lastDamage" ) then {_lastDamage = 0.0;};
_damage = damage _vehicle;
_vehicle setVariable ["lastDamage", _damage, true];

_amount = _damage - _lastDamage;

_sigi = _source call funcGetSideAndGroup;
_siSource = _sigi select 0;
_giSource = _sigi select 1;

_class = scVehicle;
if ( _vehicle == mhqWest || _vehicle == mhqEast ) then
{
	_class = scMHQ;
};

// calc score
if ( _amount > 1 ) then
{
	_amount = 1;
};

_score = _scoreTotal*_amount;

if ( _siSource != -1 && _siSource != _siVehicle ) then
{
	[_score, _class, _siSource, _giSource] spawn funcSendScore;
};

if (_destroyed && _vehicle != mhqWest && _vehicle != mhqEast) then
{
	[_vehicle, deleteVehicleDelay] call funcMoveToGarbage;
};