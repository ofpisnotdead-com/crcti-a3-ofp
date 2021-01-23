// args: [posWest, dirWest, posEast, dirEast]

waitUntil {!isNil "mhqWest" && !isNil "mhqEast"};
waitUntil {!(isNull mhqWest) && !(isNull mhqEast)};

_posWest = _this select 0;
_dirWest = _this select 1;
_posEast = _this select 2;
_dirEast = _this select 3;

_vehiclesWest = [mhqWest];
_vehiclesEast = [mhqEast];

// West Vehicles
_dest = [(_posWest select 0) - 30*cos(_dirWest), (_posWest Select 1) + 30*sin(_dirWest), 0];
_res = [utTruckWest, 0, 0, 0, _dest, _dirWest, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;
_vehiclesWest = _vehiclesWest + [_res select 0];

_dest = [(_posWest select 0) - 20*cos(_dirWest), (_posWest Select 1) + 20*sin(_dirWest), 0];
_res = [utTruckWest, 0, 0, 0, _dest, _dirWest, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;
_vehiclesWest = _vehiclesWest + [_res select 0];

_dest = [(_posWest select 0) + 20*cos(_dirWest), (_posWest Select 1) - 20*sin(_dirWest), 0];
_res = [(typesRearm select siWest) select 0, 0, 0, 0, _dest, _dirWest, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;
_vehiclesWest = _vehiclesWest + [_res select 0];

_dest = [(_posWest select 0) + 30*cos(_dirWest), (_posWest Select 1) - 30*sin(_dirWest), 0];
_res = [(typesRepair select siWest) select 0, 0, 0, 0, _dest, _dirWest, siWest, -1, tempGroupWest, "NONE",false, false] call funcAddUnit;
_vehiclesWest = _vehiclesWest + [_res select 0];

// East Vehicles
_dest = [(_posEast select 0) - 30*cos(_dirEast), (_posEast Select 1) + 30*sin(_dirEast), 0];
_res = [utTruckEast, 0, 0, 0, _dest, _dirEast, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;
_vehiclesEast = _vehiclesEast + [_res select 0];

_dest = [(_posEast select 0) - 20*cos(_dirEast), (_posEast Select 1) + 20*sin(_dirEast), 0];
_res = [utTruckEast, 0, 0, 0, _dest, _dirEast, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;
_vehiclesEast = _vehiclesEast + [_res select 0];

_dest = [(_posEast select 0) + 20*cos(_dirEast), (_posEast Select 1) - 20*sin(_dirEast), 0];
_res = [(typesRearm select siEast) select 0, 0, 0, 0, _dest, _dirEast, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;
_vehiclesEast = _vehiclesEast + [_res select 0];

_dest = [(_posEast select 0) + 30*cos(_dirEast), (_posEast Select 1) - 30*sin(_dirEast), 0];
_res = [(typesRepair select siEast) select 0, 0, 0, 0, _dest, _dirEast, siEast, -1, tempGroupEast, "NONE",false, false] call funcAddUnit;
_vehiclesEast = _vehiclesEast + [_res select 0];

if ( IntroMode < 2 ) then
{
	InsertionState = [2,2];
	publicVariable "InsertionState";
}
else
{
	_insertionChoppers = [[],[]];
	_running = [[],[]];

	_fInsert =
	{
		_chopper = _this select 0;
		_driver = driver _chopper;
		_si = _this select 1;
		_start = _this select 2;
		_dest = _this select 3;

		_nul = [_chopper, true] spawn funcLockVehicle;

		_tcrew = [_chopper] call funcGetAllCrewWithoutCargo;

		{
			[_x,"TARGET"] call funcDisableAI;
			[_x,"AUTOTARGET"] call funcDisableAI;
			[_x,"FSM"] call funcDisableAI;
			_x setSpeedMode "FULL";
			_x setBehaviour "CARELESS";
			_x setCombatMode "BLUE";
			_x setSkill 1.0;
		}forEach _tcrew;

		_shell = createVehicle ["SmokeShellGreen",_dest, [], 0, "FORM"];

		_abortt = time + 60;
		[_driver, _dest] call funcMoveAI;
		while {time < _abortt && _dest distance _chopper > 500 && alive _chopper && alive _driver}do
		{
			sleep 5;
			[_driver, _dest] call funcMoveAI;
		};

		_abortt = time + 60;
		waitUntil {time > _abortt || unitReady _chopper || !alive _chopper || !alive _driver};
		doStop _driver;
		_chopper land "GET IN";

		_abortt = time + 120;
		waitUntil {((getPosATL _chopper) select 2) < 3 || !alive _chopper || !alive _driver || time > _abortt};

		_placecargo = [_chopper] call funcGetAllCargo;
		[_chopper, false] spawn funcLockVehicle;
		[_chopper, _si, 0.25] spawn funcEjectCargo;
		sleep 1;

		_cargo = ["ihihihi."];
		_abortt = time + 60;
		while {count(_cargo) > 0 && alive _chopper && alive _driver && time < _abortt}do
		{
			_cargo = [_chopper] call funcGetAllCargo;
			sleep 1;
		};

		{
			_np = [getPos _x, 100,300, true, _x] call funcGetRandomPos;
			[_x, _np] call funcMoveAI;
		}forEach _placecargo;

		[_driver, _start] call funcMoveAI;

		_fRemoveCh =
		{
			_abt = time + 180;
			_ch = _this;
			waitUntil {unitReady _ch || !alive driver _ch || time > _abt};

			_nul = (crew _ch) call funcEjectDisband;
			deleteVehicle _ch;
		};

		_chopper spawn _fRemoveCh;
	};

	_fDrop =
	{

		_fMoveToEnd =
		{

			_veh = _this select 0;
			_dest = _this select 1;
			_dir = _this select 2;
			_si = _this select 3;

			_crewtype = [utCrewW, utCrewE] select _si;
			_tempGroup = createGroup ([West, East] select _si);
			_res = [_crewtype, 1, 1, 1, _dest, _dir, _si, -1, _tempGroup, "NONE", true, false] call funcAddUnit;
			_driver = _res select 0;
			
			[_driver] orderGetIn true;
			[_driver] allowGetIn true;
			unassignVehicle _driver;
			_driver assignAsDriver _veh;

			while {vehicle _driver != _veh}do
			{
				_driver moveInDriver _veh;
				_driver setDamage 0;
			};

			[_driver, _dest] call funcMoveAI;

			_abortt = time + 60;
			waitUntil {unitReady _veh || !alive _driver || time > _abortt};

			_veh setDamage 0;
			unassignVehicle _driver;
			_driver action ["EJECT", _veh];
			sleep 2;

			deleteVehicle _driver;
			deleteGroup _tempGroup;
			_veh setPosATL _dest;
			_veh setDir _dir;
			_veh engineOn false;

		};

		sleep 60 + random(60);

		_chopper = _this select 0;
		_driver = driver _chopper;
		_group = group _driver;
		_si = _this select 1;
		_start = _this select 2;
		_dest = _this select 3;
		_endPos = _this select 4;
		_dir = _this select 5;
		_veh = _this select 6;

		_chopper flyInHeight (200 + random(200));

		_tcrew = [_chopper] call funcGetAllCrewWithoutCargo;

		{
			[_x,"TARGET"] call funcDisableAI;
			[_x,"AUTOTARGET"] call funcDisableAI;
			[_x,"FSM"] call funcDisableAI;
			_x setSpeedMode "FULL";
			_x setBehaviour "CARELESS";
			_x setCombatMode "BLUE";

			_x setSkill 1.0;
		}forEach _tcrew;

		_shell = createVehicle ["SmokeShellYellow",_dest, [], 0, "FORM"];

		_abortt = time + 60;
		[_driver, _dest] call funcMoveAI;
		while {time < _abortt && _dest distance _chopper > 500 && alive _chopper && alive _driver}do
		{
			sleep 5;
			[_driver, _dest] call funcMoveAI;
		};

		_abortt = time + 60;
		waitUntil {time > _abortt || unitReady _chopper || !alive _chopper || !alive _driver};

		_chopper flyInHeight 30;
		[_driver, _dest] call funcMoveAI;

		_abortt = time + 60;
		waitUntil {((getPosATL _chopper) select 2) < 50 || !alive _chopper || !alive _driver || time > _abortt};

		pvDetachVehicle = [_chopper, 0];
		publicVariable "pvDetachVehicle";
		[pvDetachVehicle] spawn MsgDetachVehicle;

		_chopper flyInHeight 300;
		[_driver, _start] call funcMoveAI;

		_fRemoveCh =
		{
			_ch = _this;
			_abt = time + 180;
			waitUntil {unitReady _ch || !alive driver _ch || time > _abt};
			{
				deleteVehicle _x;
			}forEach (crew _ch);
			deleteVehicle _ch;
		};

		_chopper spawn _fRemoveCh;

		_hndl = [_veh, _endPos, _dir, _si] spawn _fMoveToEnd;
		waitUntil {scriptDone _hndl};
		deleteGroup _group;
	};

// Place Inf
	{
		_si = _x;
		if ( (InsertionState select _si) < 2 ) then
		{

			_chopperList = (unitsBuyAi select _si) select utbTransportAir;

			if ( count _chopperList > 0 ) then
			{
				_chopperType = (_chopperList select floor(random(count(_chopperList)))) select 0;
				_model = (unitDefs select _chopperType) select udModel;
				_transportsoldier = round( 0.75 * (getNumber(configFile >> "CfgVehicles" >> _model >> "Transportsoldier")+count((_model call funcGetVehicleWeapons) select 5)));

				_units = [];
				{
					_group = _x;
					{
						_units = _units + [_x];
						pvAllowDamage = [_x, false];
						publicVariable "pvAllowDamage";
						[pvAllowDamage] spawn MsgAllowDamage;
					}forEach (units _group);
				}forEach (groupMatrix select _si);

				_chopperCount = ceil(count(_units) / _transportsoldier);

				_choppers = [];
				_endPos = [_posWest, _posEast] select _si;

				_v = [_endPos, posCenter] call fVectorSubstract;
				_dir = _v call fVectorNormalize;
				_startPos = [_endPos, _dir, 2000] call fVectorAdd;
				_startPos2 = [_endPos, _dir, 4000] call fVectorAdd;
				_azimuth = [_startPos, _endPos] call funcCalcAzimuth;

				for [ {_i=0}, {_i<_chopperCount}, {_i=_i+1}] do
				{
					_np = [(_startPos select 0) + 100*_i,(_startPos select 1) + 100*_i, 75+(10*_i)];

					_tempGroup = createGroup ([West, East] select _si);
					_chopper = ([_chopperType, 1, 1, 1, _np, _azimuth, _si, -1, _tempGroup, "FLY", true, false] call funcAddUnit) select 0;

					pvAllowDamage = [_chopper, false];
					publicVariable "pvAllowDamage";
					[pvAllowDamage] spawn MsgAllowDamage;

					_chopper setDamage 0;

					_chopper flyInHeight 75+(10*_i);
					_choppers = _choppers + [vehicle _chopper];

					_r = _running select _si;
					_r = _r + [[_chopper, _si, _startPos, [_endPos,50,300,true, _chopper] call funcGetRandomPos] spawn _fInsert];
					_running set [_si, _r];
				};

				_seats = [];

				{
					_ch = _choppers select (_forEachIndex % (count _choppers));
					_seats = _seats +[[_x, _ch]];
				}forEach _units;

				InsertionChoppers set [_si, _seats];
				publicVariable "InsertionChoppers";
				InsertionState set [_si, 1];
				publicVariable "InsertionState";

				// fly in vehicles
				_chopperType = -1;
				_maxTransport = -1;
				{
					_type = _x select 0;
					_model = (unitDefs select _type) select udModel;
					_transportsoldier = getNumber(configFile >> "CfgVehicles" >> _model >> "Transportsoldier");

					if ( _transportsoldier > _maxTransport ) then
					{
						_maxTransport = _transportsoldier;
						_chopperType = _type;
					};
				}forEach _chopperList;

				{
					_veh = _x;
					_endPos = getPos _veh;
					_endDir = getDir _veh;

					_np = [(_startPos2 select 0) - 200*_forEachIndex,(_startPos2 select 1) - 200*_forEachIndex, 500+(25*_forEachIndex)];

					_tempGroup = createGroup ([West, East] select _si);
					_chopper = ([_chopperType, 1, 1, 1, _np, _azimuth, _si, -1, _tempGroup, "FLY", true, false] call funcAddUnit) select 0;

					pvAllowDamage = [_chopper, false];
					publicVariable "pvAllowDamage";
					[pvAllowDamage] spawn MsgAllowDamage;

					pvAllowDamage = [_veh, false];
					publicVariable "pvAllowDamage";
					[pvAllowDamage] spawn MsgAllowDamage;

					_chopper setDamage 0;

					_chopper flyInHeight 150+(25*_forEachIndex);
					doStop _chopper;

					pvVehicleAttached = [_veh, _chopper,0,ttHeli,0,_si];
					publicVariable "pvVehicleAttached";
					[pvVehicleAttached] spawn MsgVehicleAttached;

					_hndl = [_chopper, _si, _startPos, [_endPos,0,150,true, _chopper] call funcGetRandomPos, _endPos, _endDir, _veh] spawn _fDrop;
					if ( _veh == mhqWest || _veh == mhqEast ) then
					{
						_r = _running select _si;
						_r = _r + [_hndl];
						_running set [_si, _r];
					};

				}forEach ([_vehiclesWest, _vehiclesEast] select _si);
			};
		};
	}forEach [siWest, siEast];

	_fCheckFinish =
	{
		_si = _this select 0;
		_running = _this select 1;
		_vehicles = _this select 2;
		{
			waitUntil {scriptDone _x};
		}forEach _running;

		{
			_group = _x;
			{
				pvAllowDamage = [_x, true];
				publicVariable "pvAllowDamage";
				[pvAllowDamage] spawn MsgAllowDamage;
			}forEach (units _group);
		}forEach (groupMatrix select _si);

		{
			pvAllowDamage = [_x, true];
			publicVariable "pvAllowDamage";
			[pvAllowDamage] spawn MsgAllowDamage;
		}forEach _vehicles;

		InsertionState set [_si, 2];
		publicVariable "InsertionState";
	};

	[siWest, _running select siWest, _vehiclesWest] spawn _fCheckFinish;
	[siEast, _running select siEast, _vehiclesEast] spawn _fCheckFinish;
};