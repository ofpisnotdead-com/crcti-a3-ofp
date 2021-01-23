// args: [[object, typeUnit, siUnit], ["action1", "action2", ...], actionDistance, onlyCO]

_object = (_this select 0) select 0;
_type = (_this select 0) select 1;
_si = (_this select 0) select 2;
_actionNames = _this select 1;
_actionDistance = _this select 2;
_actionIDs = [];
_actionsAdded = false;
_onlyCO = _this select 3;

_unitName = (unitDefs select _type) select udName;

_distBase1 = 0;
_distBase2 = 0;

while {count(pvGameOver) == 0}do
{
	sleep 0.5;

	if ( isNull _object || !alive _object || (_onlyCO && playerGroup != (groupCommander select playerSideIndex)) ) exitWith
	{
		{	player removeAction _x;}foreach _actionIDs;
	};

	_NumberOfBases = (count (BaseMatrix select _si));

	if (_onlyCO && (player == driver _object) && (_NumberOfBases == 1)) then
	{
		_distBase1 = _object distance ((BaseMatrix select _si) select 0);
		[format["Move the MHQ More Than\n%1 meters From Base1\nAnd Build a Main Building\nWill Creat The Last Base2\n\nYou are %2 meters\naway from Base1 center",secondBaseDistance,_distBase1], false, true, htBuildStruct, true] call funcHint;
	};
	if (_onlyCO && (player == driver _object) && (_NumberOfBases == 2)) then
	{
		_distBase1 = _object distance ((BaseMatrix select _si) select 0);
		_distBase2 = _object distance ((BaseMatrix select _si) select 1);
		[format["Build Distance from\nBase is %1 meters\nYou are %2 meters\naway from Base1 center\n\nYou are %3 meters\naway from Base2 center",secondBaseDistance,_distBase1, _distBase2],false, true, htBuildStruct, true] call funcHint;
	};

	_isTugged = false;
	{
		_tugged = _x select tsTugged;
		if (_object in _tugged) then
		{
			_isTugged = true;
		};
	}foreach vehicleAttached;

	_forceremove = false;
	if (_isTugged || (_onlyCO && (_NumberOfBases == 2) && !((_distBase1<baseRadius) || (_distBase2<baseRadius)))) then
	{
		_forceremove = true;
	};

	if (!alive player) then
	{
		{	player removeAction _x;}foreach _actionIDs;
		_actionIDs = [];
		_actionsAdded = false;
		waitUntil {sleep 0.5; alive player;};
	};

	// add actions
	if (!_actionsAdded && (player distance _object <= _actionDistance) && (player == vehicle player)) then
	{
		{	_id = player AddAction [_x, "Player\ActionStructure.sqf", [], 2, false, false]; _actionIDs = _actionIDs + [_id]}foreach _actionNames;
		_actionsAdded = true;
	};

	// remove actions
	if (_forceremove || (_actionsAdded && ((player distance _object > _actionDistance) || (player != vehicle player)))) then
	{
		{	player removeAction _x}foreach _actionIDs;
		_actionIDs = [];
		_actionsAdded = false;
	};

	// PerformAction
	if (_actionsAdded && structAction in _actionIDs) then
	{
		{
			if (structAction == _x ) exitWith
			{
				_script = format ["Player\ActionFar %1.sqf", _actionNames select _forEachIndex];
				[_object, _type, _si, _actionDistance] execVM _script;
			};
		}forEach _actionIDs;
		structAction = -1;
	};
};

