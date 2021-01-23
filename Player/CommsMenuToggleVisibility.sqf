scriptName "Player\CommsMenuToggleVisibility.sqf";
/*
	File: CommsMenuToggleVisibility.sqf
	Author: Joris-Jan van 't Land

	Description:
	Shows or hides certain sections of the global communications menu.

	Parameter(s):
	_this select 0: index (Scalar) or list of indices (Array of Scalars) or section name (String)
		"som" - SecOps section
		"wf" - Warfare section
	_this select 1: mode (Scalar)
		0 - hide
		1 - show
	
	Returns:
	Success flag (Boolean)
*/

private ["_indices", "_mode"];
_indices = _this select 0;
_mode = _this select 1;

//TODO: one more mode for: "conditioned on" (_modifier is condition (see below), not 1)

//TODO: more parameter validation.
if (isnil "BIS_MENU_GroupCommunication") exitWith {debugLog "Log: ERROR  [fn_commsMenuToggleVisibility] Global communications menu does not exist!"; false};
if ((typeName _mode) != (typeName 0)) exitWith {debugLog "Log: ERROR [fn_commsMenuToggleVisibility] mode (1) must be a number!"; false};
if (!((typeName _indices) in [(typeName 0), (typeName []), (typeName "")])) exitWith {debugLog "Log: [fn_commsMenuToggleVisibility] indices (0) must be a number, array or string!"; false};

if ((typeName _indices) == (typeName 0)) then 
{
	_indices = [_indices];
} 
else 
{
	if ((typeName _indices) == (typeName "")) then 
	{
		switch (_indices) do 
		{
			case "som": {_indices = []};
			case "cti": {_indices = [1, 2, 3, 4, 5, 6, 7, 8 ]};		
		};
		
	};
};

private ["_modifier"];

{
  if (_mode == 0) then {_modifier = "0"} else {_modifier = "1"};
  
  switch (_x) do
  {//"conditioned on" mode - using conditions for visibility    
    case 9: {_modifier = "1 - IsLeader"; debugLog format ["COMM_  -> cond %1",[_x, BIS_MENU_GroupCommunication select _x]];};  //request disband
    case 10: {_modifier = "IsLeader"; debugLog format    ["COMM_  -> cond  %1",[_x, BIS_MENU_GroupCommunication select _x]];}; //disband selected         
    case 11: {_modifier = "IsLeader"; debugLog format    ["COMM_  -> cond  %1",[_x, BIS_MENU_GroupCommunication select _x]];}; //send units             
    case 12: {_modifier = "IsLeader"; debugLog format    ["COMM_  -> cond  %1",[_x, BIS_MENU_GroupCommunication select _x]];}; //send money
    default {};
  };

	[BIS_MENU_GroupCommunication, [_x, 5], _modifier] call BIS_fnc_setNestedElement;	
	//debugLog format ["COMM_ iterating %1",[_x, BIS_MENU_GroupCommunication select _x, _this]];
} 
forEach _indices;

true