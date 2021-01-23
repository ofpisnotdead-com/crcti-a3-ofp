scriptName "Player\CommsMenuToggleAvailability.sqf";
/*
	File: CommsMenuToggleAvailability.sqf
	Author: Joris-Jan van 't Land

	Description:
	Enables or disables certain sections of the global communications menu.

	Parameter(s):
	_this select 0: index (Scalar) or list of indices (Array of Scalars) or section name (String)
		"som" - SecOps section
		"wf" - Warfare section
	_this select 1: mode (Scalar)
		0 - disable
		1 - enable
	
	Returns:
	Success flag (Boolean)
*/

private ["_indices", "_mode"];
_indices = _this select 0;
_mode = _this select 1;

//TODO: more parameter validation.
if (isnil "BIS_MENU_GroupCommunication") exitWith {};
if ((typeName _mode) != (typeName 0)) exitWith {};
if (!((typeName _indices) in [(typeName 0), (typeName []), (typeName "")])) exitWith {};

private ["_modifier"];
if (_mode == 0) then {_modifier = "0"} else {_modifier = "1"};

private ["_wfMode"]; //Hax :-)
_wfMode = false;
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
			case "cti": {_indices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]};			
		};
	};
};

{
	private ["_value"];
	_value = _modifier;
	
	[BIS_MENU_GroupCommunication, [_x, 6], _value] call BIS_fnc_setNestedElement;	
} 
forEach _indices;

true