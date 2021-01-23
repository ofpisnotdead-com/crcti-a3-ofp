// args: [typeUnit, driver, gunner, commander, pos, dir, si, giJoin or Group, Special]
// return: [unit] or [vehicle, driver, gunner, commander]

private ["_return", "_type", "_driver", "_gunner", "_commander", "_pos", "_dir",
"_si", "_gi", "_group", "_special", "_dynamic", "_unitDesc", "_mannedUnitTypes",
"_model", "_unit", "_sigi", "_vehiclemodel", "_npos", "_inftype", "_desc", "_crew",
"_driver", "_driverunit", "_weptmp", "_gunners", "_commanders", "_gunner", "_gunnerunit",
"_commander", "_commanderunit"];

_return = [];

_type = _this select 0;
_driver = _this select 1;
_gunner = _this select 2;
_commander = _this select 3;
_pos = _this select 4;
_dir = _this select 5;
_si = _this select 6;
_gi = _this select 7;
_group = _this select 8;
_special = _this select 9;
_dynamic = _this select 10;
_vacate = _this select 11;

if ( _gi >= 0 ) then {_group = (groupMatrix select _si) select _gi;};

_unitDesc = unitDefs select _type;
_mannedUnitTypes = _unitDesc select udCrew;
_model = _unitDesc select udModel;

if (_model isKindOf "Man") then
{
	// infantry		
	_unit = _group createUnit [_model,_pos, [], 0, _special];
	_unit setDir _dir;
	_unit setDamage 0;

	_SiGi = [_si,_gi,_type, false];
	_unit setVariable["SQU_SI_GI", _SiGi, true];

	_unit call funcRandomSkill;
	_unit setUnitRank "PRIVATE";
	
	unassignVehicle _unit;
	[_unit] orderGetIn false;
	[_unit] allowGetIn false;
		
	pvUnitBuilt = [_type, _si, _gi, _unit];
	_nul = [pvUnitBuilt] spawn MsgUnitBuilt;
	publicVariable "pvUnitBuilt";

	_return = [_unit];
}
else
{
	// vehicle		
	_vehiclemodel = _model;

	if ( _special != "FLY" ) then
	{
		_npos = _pos findEmptyPosition [1,100, _model];
		if ( count(_npos) > 0 ) then {_pos = _npos;};
	};

	if (_model isKindof "Air" && _special != "FLY" ) then
	{
		_pos = [_pos, 200] call funcFindFlatEmptyPos;
		_pos set [2, 0];
	};

	_vehicle = createVehicle [_model, [_pos select 0, _pos select 1, 10000], [], 0, _special];
	_vehicle setDir _dir;
	_vehicle setPos _pos;
	_vehicle setVelocity [0,0,0];
	_vehicle setDamage 0;
	_group addVehicle _vehicle;

	_SiGi = [_si,_gi,_type, false];
	_vehicle setVariable["SQU_SI_GI", _SiGi, true];
	_vehicle setVariable["dynamic", _dynamic, true];

	_vehicle addEventHandler ["getout",
	{	_this select 0 setVariable ["lastUsageTime", floor(time), true];}];

	if ( TIEEnabled == 0 ) then {_vehicle disableTIEquipment true;};

	_return set [count _return, _vehicle];

	_infType = _mannedUnitTypes select 1;
	_desc = unitDefs select _infType;
	_model = _desc select udModel;

	_crew = [];

	pvUnitBuilt = [_type, _si, _gi, _vehicle];
	_nul = [pvUnitBuilt] spawn MsgUnitBuilt;
	publicVariable "pvUnitBuilt";

	if(getNumber(configFile >> "CfgVehicles" >> typeof _vehicle >> "isUav")==1) then
	{
		createVehicleCrew _vehicle;
		_driver = 0;
		_gunner = 0;
		_commander = 0;

		{
			_return = _return + [_x];
		}forEach (crew _vehicle);
	};

	_weptmp = (_vehiclemodel call funcGetVehicleWeapons);

	_gunners = _weptmp select 3;
	_commanders = _weptmp select 4;

	if (_commander != 0 ) then
	{
		{
			_commanderUnit = _group createUnit [_model,_pos, [], 0, "NONE"];
			_commanderUnit setDamage 0;

			_commanderUnit call funcRandomSkill;
			_commanderUnit setUnitRank "SERGEANT";

			_SiGi = [_si,_gi,_infType, false];
			_commanderUnit setVariable["SQU_SI_GI", _SiGi, true];

			pvUnitBuilt = [_inftype, _si, _gi, _commanderUnit];
			_nul = [pvUnitBuilt] spawn MsgUnitBuilt;
			publicVariable "pvUnitBuilt";

			/*_commanderUnit assignAsTurret [_vehicle, _x];
			[_commanderUnit] orderGetIn true;
			[_commanderUnit] allowGetIn true;*/
			_commanderUnit moveInTurret [_vehicle, _x];

			_return set [count _return, _commanderUnit];
		}forEach _commanders;
	};

	if (_gunner != 0 ) then
	{

		{
			_gunnerUnit = _group createUnit [_model,_pos, [], 0, "NONE"];
			_gunnerUnit setDamage 0;

			_gunnerUnit call funcRandomSkill;
			_gunnerUnit setUnitRank "CORPORAL";

			_SiGi = [_si,_gi,_infType, false];
			_gunnerUnit setVariable["SQU_SI_GI", _SiGi, true];

			pvUnitBuilt = [_inftype, _si, _gi, _gunnerunit];
			_nul = [pvUnitBuilt] spawn MsgUnitBuilt;
			publicVariable "pvUnitBuilt";

			/*_gunnerUnit assignAsTurret [_vehicle, _x];
			[_gunnerUnit] orderGetIn true;
			[_gunnerUnit] allowGetIn true;*/
			_gunnerUnit moveInTurret [_vehicle, _x];

			_return set [count _return, _gunnerUnit];

		}forEach _gunners;
	};

	if (_driver != 0) then
	{
		_driverUnit = _group createUnit [_model,_pos, [], 0, "NONE"];
		_driverUnit setDamage 0;

		_SiGi = [_si,_gi,_infType, false];
		_driverUnit setVariable["SQU_SI_GI", _SiGi, true];
		_driverUnit call funcRandomSkill;
		_driverUnit setUnitRank "PRIVATE";

		pvUnitBuilt = [_inftype, _si, _gi, _driverunit];
		_nul = [pvUnitBuilt] spawn MsgUnitBuilt;
		publicVariable "pvUnitBuilt";

		/*_driverUnit assignAsDriver _vehicle;
		[_driverUnit] orderGetIn true;
		[_driverUnit] allowGetIn true;*/
		_driverUnit moveInDriver _vehicle;

		_return set [count _return, _driverUnit];
	};

};

{
	doStop _x;
	_x setDamage 0;
}forEach _return;

if ( _vacate && !((_return select 0) isKindOf "Ship") ) then
{
	_veh = _return select 0;
	_pos = getPos _veh;
	_dir = (getDir _veh) - 135 + random(90);
	_dist = 50 + random(50);

	_dv = [[0,1,0], _dir] call fVectorRot;
	_npos = [_pos, _dv, _dist] call fVectorAdd;

	[(driver _veh), _npos, 0, 10] call funcMoveAI;	
};

_return