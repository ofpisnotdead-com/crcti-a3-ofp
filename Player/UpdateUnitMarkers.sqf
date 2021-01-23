// args: [si];

_GroupLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R"];

_si = _this select 0;

_textSide = "";
_textSideEnemy = "";
_siEnemy = -1;
_unitID = "";

if (_si == siWest) then
{
	_textSide = "West";
	_textSideEnemy = "East";
	_siEnemy = siEast;
	_unitID = "B";
};

if (_si == siEast) then
{
	_textSide = "East";
	_textSideEnemy = "West";
	_siEnemy = siWest;
	_unitID = "O";
};

_groups = groupMatrix select playerSideIndex;
_groupNames = groupNameMatrix select playerSideIndex;

_count = count _groups;
_ids = [];

for [ {_id=0}, {_id<maxGroupSize+5}, {_id=_id+1}] do
{
	_ids set [_id, format["%1 %2:%3", _unitID, _groupNames select playerGroupIndex, _id]];
};

_state = "update";

while {_state != "finished"}do
{
	_to = time + 5;
	waitUntil {visibleMap || visibleGPS || dialog || time > _to};

	_commCenters = count ([playerSideIndex, stComm] call funcGetWorkingStructures);
	_airUpg = ((upgMatrix select playerSideIndex) select upgRadarAircraft) select 3;
	_gndUpg = ((upgMatrix select playerSideIndex) select upgRadarGround) select 3;
	_artUpg = 0;
	if ( ArtyAllowed > 0) then {_artUpg = ((upgMatrix select playerSideIndex) select upgRadarArtillery) select 3;};
	_radars = [playerSideIndex, stAAradar] call funcGetWorkingStructures;
	_radarsLR = [playerSideIndex, stAAradarLR] call funcGetWorkingStructures;

	// Relays	
	{
		_relay = _x;
		_pos = getPos _relay;
		_rm = format["relaymarker_%1", _forEachIndex];

		if ( isNull _relay ) then
		{
			_rm setMarkerPosLocal hiddenMarkerPos;
			_rm setMarkerSizeLocal [0.0, 0.0];
		}
		else
		{
			_rm setMarkerPosLocal _pos;
			_rm setMarkerSizeLocal [0.75, 0.75];
			if ( !alive _relay ) then
			{
				_rm setMarkerTypeLocal "Warning";
			}
			else
			{
				_rm setMarkerTypeLocal "n_mortar";
			};
		};

	}forEach (pvAcreRelays select playerSideIndex);

	// Radars
	radarMarkers = radarMarkers - [0];
	{
		_radar = _x select 0;
		_marker = _x select 1;
		_circle = _x select 2;
		_rangemarkers = _x select 3;

		if ( (_airUpg == 2 || _artUpg == 2) && _commCenters > 0 ) then
		{
			_circle setMarkerAlphaLocal 1;
		}
		else
		{
			_circle setMarkerAlphaLocal 0;
		};

		if ( _gndUpg == 2 && _commCenters > 0 ) then
		{
			{
				_x setMarkerAlphaLocal 1;
			}forEach _rangeMarkers;
		}
		else
		{
			{
				_x setMarkerAlphaLocal 0;
			}forEach _rangeMarkers;
		};

		if ( !alive _radar || isNull _radar ) then
		{
			deleteMarkerLocal _marker;
			deleteMarkerLocal _circle;

			{
				deleteMarkerLocal _x;
			}forEach _rangeMarkers;

			radarMarkers set [_forEachIndex,0];
		};
	}forEach radarMarkers;

	if ( CRCTIDEBUG ) then
	{
		{
			_m = str(_x);
			if ( getMarkerType _m == "" ) then
			{
				_m = createMarkerLocal [str(_x), position _x];
				str(_x) setMarkerTypeLocal "n_inf";
				str(_x) setMarkerSizeLocal [0.25,0.25];
			};

			str(_x) setMarkerPos (position _x);

		}forEach allUnits;
	};

	if ((_si == siWest)&& pvbase1W && (count (BaseMatrix select _si)>=1)) then
	{
		"Base1" setMarkerPosLocal ((BaseMatrix select _si) select 0);
		(leader (groupCommander select _si)) commandChat "Base-1 Established";
		pvbase1W = false;
	};

	if ((_si == siEast)&& pvbase1E && (count (BaseMatrix select _si)>=1)) then
	{
		"Base1" setMarkerPosLocal ((BaseMatrix select _si) select 0);
		(leader (groupCommander select _si)) commandChat "Base-1 Established";
		pvbase1E = false;
	};

	if ((_si == siWest)&& pvbase2W && (count (BaseMatrix select _si)==2)) then
	{
		"Base2" setMarkerPosLocal ((BaseMatrix select _si) select 1);
		(leader (groupCommander select _si)) commandChat "Base-2 Established";
		pvbase2W = false;
	};

	if ((_si == siEast)&& pvbase2E && (count (BaseMatrix select _si)==2)) then
	{
		"Base2" setMarkerPosLocal ((BaseMatrix select _si) select 1);
		(leader (groupCommander select _si)) commandChat "Base-2 Established";
		pvbase2E = false;
	};

	if ( _commCenters == 0 || (MapMode < 3 && !(time < CurPictureTime)) ) then
	{
		if ( _state != "hidden") then
		{
			_state = "hideall";
		};
	}
	else
	{
		_state = "update";
	};

	if ( _state == "update") then
	{

		// LEADERS
		{
			_leader = leader _x;
			_markerType = (["waypoint",SQSoldier] select (alive _leader));
			_marker = format ["%1 %2 Marker", _textSide, groupNames select _forEachIndex];
			_name = [-1,-1, _x] call funcGetGroupName;

			_marker setmarkertextlocal _name;

			_marker setMarkerPosLocal getPos _leader;
			_marker setMarkerTypeLocal _markerType;

			_wpPos = _leader getVariable "expectedDestination";

			if ( isNil "_wpPos" ) then
			{
				_wpPos = [0,0,0];
			};
			[_marker+"_1", position _leader, _wpPos, "ColorBlue"] call funcDrawMapLine;

		}foreach _groups;

		// PLAYERS NUMBERED AI
		_units = (units playerGroup) - [leader playerGroup];
		_i = 0;
		_c = count _units;
		for [ {_id=2}, {_id<=maxGroupSize+5}, {_id=_id+1}] do
		{
			_marker = format["PlayerUnit_%1", _id];

			if (_i < _c) then
			{
				_ai = _units select _i;
				_text = format["%1", _ai];

				if ( _text == (_ids select _id) ) then
				{
					_marker setMarkerPosLocal getPos _ai;
					_i = _i + 1;
				}
				else
				{
					_marker setMarkerPosLocal hiddenMarkerPos;
				};
			}
			else
			{
				_marker setMarkerPosLocal hiddenMarkerPos;
			};
		};

		// GROUP MEMBER MARKERS
		_gi = 0;
		_countGroups = count (groupMatrix select playerSideIndex);
		for [ {_gi=0}, {_gi<_countGroups}, {_gi=_gi+1}] do
		{
			_group = (groupMatrix select playerSideIndex) select _gi;
			_units = units _group - [leader _group];
			_count = count _units;

			for[ {_index=0}, {_index<maxGroupSize+5}, {_index=_index+1}] do
			{

				_marker = Format["UnitMarker_%1_%2_%3", playerSideIndex, _gi, _index];
				_marker2 = Format["UnitWpMarker_%1_%2_%3", playerSideIndex, _gi, _index];

				if ( !((_index < _count) && (_gi == playerGroupIndex || giMarkersAI == _gi || giMarkersAI == _countGroups))) then
				{
					_marker setMarkerPosLocal hiddenMarkerPos;
					[_marker2, [0,0,0], [0,0,0], "ColorRed"] call funcDrawMapLine;
				}
				else
				{
					_ai = _units select _index;
					_marker setMarkerPosLocal getPos _ai;

					if ( isPlayer _ai ) then
					{
						_marker setMarkerTextLocal (name _ai);
					}
					else
					{
						_marker setMarkerTextLocal "";
					};

					if (_gi == playerGroupIndex) then
					{
						_destRecord = expectedDestination _ai;
						_wpPos = [0,0,0];
						if (count _destRecord > 0) then
						{
							_wpPos = _destRecord select 0;
						};
						[_marker2, position _ai, _wpPos, "ColorRed"] call funcDrawMapLine;
					};
				};
			};
		};

		// VEHICLES OWN
		_vehicleMapping = (vehicleMarkerMapping select playerSideIndex) - [0];
		_index = 0;
		_count = count _vehicleMapping;

		for[ {_index=0}, {_index<_count}, {_index=_index+1}] do
		{

			_vehicle = (_vehicleMapping select _index) select 0;
			_marker = format["%1 Vehicle %2", str(playerSideIndex), (_vehicleMapping select _index) select 1];

			if (isNull _vehicle || (_vehicle != mhq && !alive _vehicle) ) then
			{
				_marker setMarkerPosLocal hiddenMarkerPos;
			}
			else
			{
				_marker setMarkerPosLocal getPos _vehicle;
				_marker setMarkerDirLocal getDir _vehicle;

				_tpduty = _vehicle getVariable ["isTpDuty", false];
				if ( _tpduty ) then
				{
					_marker setMarkerColorLocal "ColorYellow";
				}
				else
				{
					_marker setMarkerColorLocal "ColorGreen";
				};
			};
		};
	};

	if ( _airUpg == 2 || _gndUpg == 2 ) then
	{
		_minHeight = 10;
		_maxHeight = 10;

		if ( _airUpg == 2 ) then {_maxHeight = 100000;};
		if ( _gndUpg == 2 ) then {_minHeight = -10;};

		_radarSides = [_siEnemy,siRes,siCiv];
		if ( MapMode < 3 && !(time < CurPictureTime)) then {_radarSides = _radarSides + [playerSideIndex];};

		// Radarwieheikels
		{
			_vehicleMapping = (vehicleMarkerMapping select _x) - [0];
			_count = count _vehicleMapping;

			for [ {_index=0}, {_index<_count}, {_index=_index+1}] do
			{
				_vehicle = (_vehicleMapping select _index) select 0;
				_marker = format["%1 Vehicle %2", str(_x), (_vehicleMapping select _index) select 1];

				if (_commCenters == 0 || isNull _vehicle || (((getPos _vehicle) select 2) < _minHeight)||(((getPos _vehicle) select 2) > _maxHeight)) then
				{
					_marker setMarkerPosLocal hiddenMarkerPos;
				}
				else
				{
					_inrange = false;
					{
						_r = radarRange;
						if (_x in _radarsLR) then {_r = radarRangeLR;};

						if ((_vehicle distance _x) < _r) then
						{
							_inrange = true;

							if ( _inrange ) then
							{
								_rpos = getPosASL _x;
								_vpos = getPosASL _vehicle;
								_rpos set [2,getTerrainHeightASL(_rpos) + radarHeight];
								_vpos set [2,(_vpos select 2)+5];

								_inrange = !(terrainIntersectASL [_rpos, _vpos]);
							};

						};
					}foreach _radars + _radarsLR;

					if ( !_inrange || !alive _vehicle ) then
					{
						_marker setMarkerPosLocal hiddenMarkerPos;
					}
					else
					{
						_marker setMarkerPosLocal getPos _vehicle;
						_marker setMarkerDirLocal getDir _vehicle;
					};
				};
			};
		}forEach _radarSides;

	};

	if ( _state == "hideall") then
	{
		// LEADERS
		_index = 0;
		{
			_leader=leader _x;
			_marker=Format ["%1 %2 Marker", _textSide, _groupNames select _forEachIndex];
			_marker setMarkerPosLocal hiddenMarkerPos; _marker+"_1" setMarkerSizeLocal [0,0];
		}foreach _groups;

		for [ {_i=2}, {_i<maxGroupSize+5}, {_i=_i+1}] do
		{
			format["PlayerUnit_%1", _i] setMarkerPosLocal hiddenMarkerPos;
		};

		// GROUP MEMBER MARKERS
		for [ {_gi=0}, {_gi<12}, {_gi=_gi+1}] do
		{
			for[ {_index=0}, {_index<maxGroupSize+5}, {_index=_index+1}] do
			{
				Format["UnitMarker_%1_%2_%3", playerSideIndex, _gi, _index] setMarkerPosLocal hiddenMarkerPos;
				Format["UnitMarker_%1_%2_%3", _siEnemy, _gi, _index] setMarkerPosLocal hiddenMarkerPos;
			};
		};

		// VEHICLES OWN
		_vehicleMapping = vehicleMarkerMapping select playerSideIndex;
		{
			_marker = format["%1 Vehicle %2", str(playerSideIndex), _x select 1];
			_marker setMarkerPosLocal hiddenMarkerPos;
		}foreach _vehicleMapping;

		// VEHICLES ENEMY
		_vehicleMapping = vehicleMarkerMapping select _siEnemy;
		{
			_marker = format["%1 Vehicle %2", str(_siEnemy), _x select 1];
			_marker setMarkerPosLocal hiddenMarkerPos;
		}foreach _vehicleMapping;

		_state = "hidden";
	};

};