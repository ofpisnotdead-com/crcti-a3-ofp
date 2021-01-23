_board = _this select 0;
_si = _this select 2;

_oldObject = objNull;

_texname = format["livefeedrtt_%1", str(_board)];

_cam = "camera" camCreate [0,0,0];
_board setObjectTexture [0, format["#(argb,512,512,1)r2t(%1,1)", _texname]];

_lastUpdate = -5;

while {alive _board && !isNull _board}do
{
	sleep 0.1;
	_group = _board getVariable ["LiveFeedTarget", grpNull];
	_object = leader _group;

	_controlCenters = [_si, stComm] call funcGetWorkingStructures;
	_unitCam = ((upgMatrix select _si) select upgUnitCam) select 3;
	if ( !alive player || !alive _object || count(_controlCenters) == 0 || _unitCam != 2 ) then {_object = objNull;};

	if ( _object != _oldObject ) then
	{
		if ( !isNull _object ) then
		{
			_cam cameraEffect ["Internal", "Back", _texname];
			_cam camSetTarget _object;
			_cam camSetRelPos [0, -1.5, 1.5];
			_cam camCommit 0;
			_board setObjectTexture [0, format["#(argb,512,512,1)r2t(%1,1)", _texname]];
		}
		else
		{
			_board setObjectTexture [0, "Images\nosignal.paa"];
		};

		_oldObject = _object;
	}
	else
	{
		_cam camSetRelPos [0, -1.5, 1.5];
		_cam camCommit 1;
	};

	if ( time > _lastUpdate) then
	{
		_lastUpdate = time + 5;
		removeAllActions _board;

		_name = getText(configFile >> "CfgVehicles" >> typeOf(_board) >> "displayName");
		_str = format["Remove %1", _name];
		_nul = _board addAction [_str, "Player\ActionDeleteVehicle.sqf", [_board], 2, false, false];

		{
			_leader = leader _x;
			if ( isPlayer _leader ) then
			{
				_name = name _leader;
				_actionName = format["Watch %1", _name];
				_action = {(_this select 0) setVariable ["LiveFeedTarget", _this select 3, true];};
				_board addAction [ _actionName, _action, _x ];
			};
		}forEach (groupMatrix select _si);
	};

};

camDestroy _cam;
