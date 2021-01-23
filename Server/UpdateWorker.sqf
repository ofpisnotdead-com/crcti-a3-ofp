// args: [unit, type, si]

if ( isServer ) then
{
	_chillMoves = ["HubSittingAtTableU_idle1","HubSittingAtTableU_idle2","HubSittingAtTableU_idle2",
	"HubSittingChairA_idle1","HubSittingChairA_idle2","HubSittingChairA_idle3","HubSittingChairA_move1",
	"HubSittingChairB_idle1","HubSittingChairB_idle2","HubSittingChairB_idle3","HubSittingChairB_move1",
	"HubSittingChairC_idle1","HubSittingChairC_idle2","HubSittingChairC_idle3","HubSittingChairC_move1",
	"HubSittingChairUA_idle1","HubSittingChairUA_idle2","HubSittingChairUA_idle3","HubSittingChairUA_move1",
	"HubSittingChairUB_idle1","HubSittingChairUB_idle2","HubSittingChairUB_idle3","HubSittingChairUB_move1",
	"HubSittingChairUC_idle1","HubSittingChairUC_idle2","HubSittingChairUC_idle3","HubSittingChairUC_move1"];

	_standup = {
	private["_unit"];
		_unit = _this;
		if ( !(isNull attachedTo _unit) ) then
		{			
			detach _unit;

			if ( _unit == leader _unit ) then
			{
				pvSay3D = [_unit, [], "saufaus", baseRadius*2];
				publicVariable "pvSay3D";

			};

		};
		[[_unit, ""], "funcSwitchMove", true, false, true] call BIS_fnc_MP;
		_unit enableAI "ANIM";
	};

	_mukke = {
	private["_unit", "_type", "_pos", "_schwabe"];

		_unit = _this;

		_anschiss = _unit getVariable ["anschiss", false];

		if ( !_anschiss ) then
		{
			_music = ["hiphop", "holadrio"] select floor(random(2));
			pvSay3D = [_unit, [], _music,baseRadius*2];
			publicVariable "pvSay3D";

			_type = (infTown select siCiv) call funcGetRandomUnitType;
			if ( _type != -1 ) then
			{
				_unit setVariable ["anschiss", true];

				_pos = [getPos _unit, 50, 100, true, objNull] call funcGetRandomPos;
				_schwabe = ([_type, 0, 0, 0, _pos, random 360, siCiv, -1, tempGroupCiv, "NONE", true, false] call funcAddUnit) select 0;

				[_schwabe,"TARGET"] call funcDisableAI;
				[_schwabe,"AUTOTARGET"] call funcDisableAI;
				[_schwabe,"FSM"] call funcDisableAI;
				_schwabe setSpeedMode "FULL";
				_schwabe setCombatMode "BLUE";
				_schwabe setBehaviour "CARELESS";
				_schwabe doFollow _schwabe;

				[_schwabe, getPos _unit, 0, 2] call funcMoveAI;

				_ta = time + 60;
				waitUntil {sleep 1; _schwabe distance (getPos _unit) < 15 || time > _ta;};

				_ta = time + 15;
				waitUntil {sleep 1; _schwabe distance (getPos _unit) < 4 || time > _ta;};

				[[_schwabe, "HubStandingUB_move1"], "funcSwitchMove", true, false, true] call BIS_fnc_MP;

				pvSay3D = [_schwabe, [], "leiser", baseRadius*2];
				publicVariable "pvSay3D";

				sleep 10;
				[[_schwabe, ""], "funcSwitchMove", true, false, true] call BIS_fnc_MP;
				[_schwabe, _pos, 0, 2] call funcMoveAI;
				_ta = time + 60;
				waitUntil {sleep 1; _schwabe distance (_pos) < 10 || time > _ta;};
				deleteVehicle _schwabe;

			};
		};

	};

	_unit = _this select 0;
	_type = -1;
	_si = _this select 2;

	_group = group _unit;
	_wander = true;
	_range = 1200;
	_repair = 0.05;

	if ( CRCTIDEBUG ) then
	{
		_repair = 1;
	};

	_animations = ["AinvPknlMstpSlayWrflDnon_medic","AmovPsitMstpSlowWrflDnon_Smoking"];
	_randomAnim = count _animations;
	_stuckObject = objNull;
	_sleep = 5;
	_initialPos = getPos _unit;
	_wegmit = objNull;

	_unit setCombatMode "YELLOW";
	_unit setBehaviour "SAFE";
	_unit setSpeedMode "FULL";

	_state = "update";

	_object = objNull;
	_objPos = [];
	_timeAbort = time;

	removeAllWeapons _unit;
	removeBackPack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	removeVest _unit;

	{	_unit unassignItem _x}forEach (assignedItems _unit);

	[_unit, _initialPos, 25, 50] call funcMoveAI;
	sleep 5 + random(5);

	while {_state != "finished"}do
	{

		sleep (_sleep*0.5) + random(_sleep*0.5);

		if ( _state == "update" ) then
		{

			_structs = repairableStructureMatrix select _si;

			{
				_object = _x select 0;
				_damage = _x select 1;
				_type = _x select 2;

				_objPos = position _object;

				_distToObject = [getPos _unit, _objPos] call funcDistH;

				if ( !isNull _object && _damage > 0 && _distToObject < _range ) exitWith
				{
					_state = "MoveToObject";
				};

			}forEach _structs;

			if ( _state != "MoveToObject" ) then
			{
				_sleep = 10 + random(10);
				_state = "Wander";
			};

		};

		if ( _state == "Wander" ) then
		{
			_unit setCombatMode "BLUE";
			_unit setBehaviour "CARELESS";
			_unit setSpeedMode "LIMITED";

			WorkerHangout set [_si, (WorkerHangout select _si) - [objNull]];

			_nearestHangout = objNull;
			_nearestDist = 10000000;

			{
				if ( (_unit distance _x) < _nearestDist ) then
				{
					_nearestHangout = _x;
					_nearestDist = _unit distance _x;
				};
			}forEach (WorkerHangout select _si);

			if ( ClearBasesEnabled > 0) then
			{
				if ( isNull _wegmit || {!alive _wegmit}|| {isObjectHidden _wegmit}) then
				{
					_wegmit = objNull;

					_bpos = [getPos _unit, _si] call funcGetClosestBase;

					if ( count(_bpos) > 0 ) then
					{
						_stuff = [_bpos select 1, [], clearBaseRadius ] call funcNearestTerrainObjects;
						_houses = [];
						_stuff2 = [];

						{
							_wmt = _x getVariable ["wmt", 0];
							if ( alive _x && !isObjectHidden _x && time > _wmt ) then
							{
								_d = ((_bpos select 1) distance _x) * (_unit distance _x);
								if ( !(_x isKindOf "House") ) then
								{
									_stuff2 = _stuff2 + [[_x, _d]];
								}
								else
								{
									_houses = _houses + [[_x, _d]];
								};
							};
						}forEach _stuff;

						if ( count(_houses) > 0 ) then {_stuff2 = _houses;};

						_stuff2 = [1, true, _stuff2] call funcSort;

						if (count(_stuff2) > 0 ) then
						{
							_wegmit = (_stuff2 select floor(random((count _stuff2)*0.1))) select 0;
						};
					};
				};
			};

			if ( !isNull _wegmit ) then
			{
				_wegmit setVariable ["wmt", time + 60];
				_wmt = typeOf _wegmit;
				_wto = time + 90;

				_unit call _standup;
				[_unit, getPos _wegmit, 0, 0] call funcMoveAI;
				waitUntil {!alive _unit || unitReady _unit || time > _wto || isNull _wegmit || isObjectHidden _wegmit};

				if ( !isNull _wegmit && !isObjectHidden _wegmit ) then
				{
					[_unit] call funcDoStop;
					if (str _wegmit find ": t_" > -1 || str _wegmit find ": b_" > -1) then
					{
						pvSay3D = [_unit, [], "chainsaw", baseRadius*2];
					}
					else
					{
						pvSay3D = [_unit, [], "jackhammer", baseRadius*2];
					};
					publicVariable "pvSay3D";

					sleep 4;
					[_wegmit, true] call funcHideObjectGlobal;
					_wegmit = objNull;
					sleep random(10);
				};
			}
			else
			{
				if ( isNull _nearestHangout || _nearestDist > 500 ) then
				{
					_unit call _standup;
					[_unit, _initialPos, 5, 100] call funcMoveAI;
				}
				else
				{
					if ( isNull attachedTo _unit ) then
					{
						_unit call _standup;
						[_unit, getPos _nearestHangout] call funcMoveAI;
					};

					if ( _nearestDist < 3 ) then
					{
						if ( random(200) > 198 ) then
						{
							pvSay3D = [_unit, [], "beer", baseRadius*2];
							publicVariable "pvSay3D";
							if ( damage _unit > 0 ) then
							{
								_unit setDamage ((damage _unit) - 0.1);
							};
						};

						if ( random(200) > 198 ) then
						{
							_laber = ["haha", "jajaeben", "panzerfaust", "gibtsned", "schlimm"];
							pvSay3D = [_unit, [], _laber select floor(random(count _laber)), baseRadius*2];
							publicVariable "pvSay3D";
						};

						if ( random(200) > 199 ) then
						{
							_nul = _unit spawn _mukke;
						};

						if ( isNull attachedTo _unit ) then
						{
							_chairs = (getPos _unit) nearObjects ["Land_CampingChair_V2_F", 5];

							{								
								if ( count(attachedObjects _x) == 0 ) exitWith
								{
									_unit setVariable ["gemotzt", false];									
									_unit setBehaviour "SAFE";
									_unit disableAI "ANIM";
									_unit attachTo [_x,[0,-0.15,-0.45]];
									_unit setDir 180;
									_move = _chillMoves select floor(random(count _chillMoves));
									[[_unit, _move], "funcSwitchMove", true, false, true] call BIS_fnc_MP;

								};
							}forEach _chairs;
						};
					};
				};
			};

			_state = "update";
		}
		else
		{
			if ( ( {	(_unit distance _x) < 2 }count allPlayers) > 0 && !(_unit getVariable ["gemotzt", false])) then
			{
				_unit setVariable ["gemotzt", true];
				pvSay3D = [_unit, [], "schneller", baseRadius*2];
				publicVariable "pvSay3D";
			};
		};

		if ( _state == "MoveToObject") then
		{
			_sleep = 5;

			_unit call _standup;
			_unit setCombatMode "YELLOW";
			_unit setBehaviour "SAFE";
			_unit setSpeedMode "FULL";

			_timeAbort = time + 60;

			[_unit, _objPos, 5, 20] call funcMoveAI;

			_state = "CheckObjectReached";
		};

		if ( _state == "CheckObjectReached") then
		{

			if (isNull _object) then
			{
				_state = "update";
			}
			else
			{
				_distToObject = [getPos _unit, _objPos] call funcDistH;

				if ( _distToObject < 25 ) then
				{
					[_unit, _objPos, 0, 5] call funcMoveAI;
					_sound = ["drill", "hammer", "saw"] select floor(random(3));
					pvSay3D = [objNull, _objPos, _sound, baseRadius*2];
					publicVariable "pvSay3D";

					_state = "RepairBuilding";
				};

				if ( time > _timeAbort ) then
				{
					_state = "MoveToObject";
				};

			};
		};

		if ( _state == "RepairBuilding") then
		{
			_sleep = 5;
			[_unit] call funcDoStop;

			if (isNull _object) then
			{
				_state = "update";
			}
			else
			{

				//_unit playMove (_animations select(random (_randomAnim - 1)));				
				_damage = [_object, _repair, _si, -1] call funcRepairStructure;

				if ( _damage == -1 ) then
				{
					_state = "update";
				};

				if ( _damage <= 0 ) then
				{
					[_si, _type] execVM "Server\Info\StructReady.sqf";
					primStructsPlaced = primStructsPlaced - [_object, objNull];
					_state = "update";
				};

			};

		};

		if (!alive _unit) then
		{

			if ( _si == siwest ) then
			{
				pvWorkersWest = pvWorkersWest - 1;
				publicVariable "pvWorkersWest";
			};
			if ( _si == sieast ) then
			{
				pvWorkersEast = pvWorkersEast - 1;
				publicVariable "pvWorkersEast";
			};
			_state = "finished";
		};

	};
};