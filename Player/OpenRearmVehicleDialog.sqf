// args: [truck, unit]

_truck = _this select 0;
_unit = _this select 1;

_vehicles = [getPos _truck, rearmRange, [siWest, siEast, siRes, siCiv], [], [_truck]] call funcGetNearbyVehicles;

{
	_rearmData = (_x select 0) call funcGetRearmData;	
	_mags = _rearmData select 1;

	if ( count(_mags) == 0 ) then {_vehicles set [_forEachIndex, objNull];};
}forEach _vehicles;
_vehicles = _vehicles - [objNull];

if ((count _vehicles) != 0) then
{
	disableSerialization;
	_dlg = createDialog "NearbyVehiclesDialog";
	[IDD_NearbyVehiclesDialog] call funcFixDialogTitleColor;
	_idcVehicles = IDC_LB_VEHICLES;
	lbClear _idcVehicles;
	btnAction = false;
	[IDD_NearbyVehiclesDialog, IDC_BTN_ACTION, "Rearm Vehicle"] call funcSetButtonText;

	{
		_v = _x select 0;

		_model = typeOf _v;
		_image = getText (configFile >> "CfgVehicles" >> _model >> "picture");
		_str = getText (configFile >> "CfgVehicles" >> _model >> "displayName");

		if ( !someAmmo _v ) then
		{
			_str = _str + " (out of Ammo)";
		};
		_id = lbAdd [_idcVehicles, _str];

		lbSetPicture [_idcVehicles, _id, _image];
	}foreach _vehicles;

	lbSetCurSel [_idcVehicles, 0];

	while {dialog && alive _truck && alive _unit && alive player}do
	{

		if (btnAction) then
		{
			btnAction=false;
			_sel = lbCurSel _idcVehicles;
			if (_sel == -1) then
			{
				["No vehicle selected", true, false, htGeneral, false] call funcHint;
			}
			else
			{
				_vehicle = (_vehicles select _sel) select 0;

				if ( !alive _vehicle ) then
				{
					["Vehicle destroyed", true, false, htGeneral, false] call funcHint;
				}
				else
				{

					if ((_vehicle distance _truck) > rearmRange) then
					{
						["Vehicle out of rearm range", true, false, htGeneral, false] call funcHint;
					}
					else
					{
						[_unit, _truck, _vehicle] spawn funcRearm;
					};
				};
			};
		};

	};
}
else
{
	["No Nearby Vehicles/Statics", true, false, htGeneral, false] call funcHint;
};
