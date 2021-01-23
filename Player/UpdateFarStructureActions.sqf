// args: [[object, typeStructure, si], ["action1", "action2", ...], actionDistance]

_object = (_this select 0) select 0;
_type = (_this select 0) select 1;
_si = (_this select 0) select 2;
_actionNames = _this select 1;
_actionDistance = _this select 2;
_actionIDs = [];
_actionsAdded = false;
_structName = (structDefs select _type) select sdName;

_markerName = format["struct_marker_%1", str(_object)];
_structAcronym = structsAcronyms select _type;

createMarkerLocal [_markerName, getPos _object ];
_markerName setMarkerTypeLocal (structsMarkers select 0);
_markerName setMarkerColorLocal "colorRed";
_markerName setMarkerSizeLocal [0.5, 0.5];

if ( count(toArray(str(_structAcronym))) > 0) then
{
	_markerName setMarkerTextLocal _structAcronym;
};

while {count(pvGameOver) == 0}do
{	
	sleep 0.5;
	// Object destroyed
	if (isNull _object) exitWith
	{
		{	player removeAction _x;}foreach _actionIDs;
		deleteMarkerLocal _markerName;
	};

	// RemoveActionsAndWaitUntilRepaired
	if (!alive _object) then
	{
		_markerName setMarkerTypeLocal (structsMarkers select 1);
		_markerName setMarkerPosLocal (getPos _Object);

		{	player removeAction _x;}foreach _actionIDs;
		_actionIDs = [];
		_actionsAdded = false;
		waitUntil {sleep 0.5 ; isNull _object || alive _object};

		_markerName setMarkerTypeLocal (structsMarkers select 1);
		_markerName setMarkerPosLocal (getPos _Object);
	};

	// RemoveActionsAndWaitUntilAlive
	if (!alive player) then
	{
		{	player removeAction _x;}foreach _actionIDs;
		_actionIDs = [];
		_actionsAdded = false;
		waitUntil {sleep 0.5 ; alive player;};
	};

	// add actions		
	if (!_actionsAdded && (player distance _object <= _actionDistance)) then
	{
		{
			_id = player AddAction [_x, "Player\ActionStructure.sqf", [], 1, false, false];
			_actionIDs = _actionIDs + [_id];
		}foreach _actionNames;
		_actionsAdded = true;
	};

	// remove actions
	if ((_actionsAdded) && (player distance _object > _actionDistance)) then
	{
		{	player removeAction _x;}foreach _actionIDs;
		_actionIDs = [];
		_actionsAdded = false;
	};

	//PerformAction	
	if (_actionsAdded && structAction in _actionIDs) then
	{
		{
			if ( structAction == _x ) exitWith
			{
				_script = format ["Player\ActionFar %1.sqf", _actionNames select _forEachIndex];
				_nul = [_object, _type, _si] execVM _script;
			};
		}forEach _actionIDs;
		structAction = -1;
	};

};

