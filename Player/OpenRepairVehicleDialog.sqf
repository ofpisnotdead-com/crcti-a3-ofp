// args: [truck, unit]

_truck = _this select 0;
_unit = _this select 1;

_vehicles = [getPos _truck, repairRange, [siWest, siEast, siRes, siCiv], [], [_truck]] call funcGetNearbyVehicles;

if ((count _vehicles) == 0) then
{
	["No nearby Vehicles", true, false, htGeneral, false] call funcHint;
}
else
{
	disableSerialization;
	_dlg = createDialog "NearbyVehiclesDialog";
	[IDD_NearbyVehiclesDialog]call funcFixDialogTitleColor;

	_idcVehicles = IDC_LB_VEHICLES;
	lbClear _idcVehicles;

	btnAction = false;
	[IDD_NearbyVehiclesDialog, IDC_BTN_ACTION, "Heal/Repair"] call funcSetButtonText;

	{
		_v = _x select 0;
		_health = 1.0 - (damage _v);
		_health = round(_health * 100);

		_model = typeOf _v;
		_image = getText (configFile >> "CfgVehicles" >> _model >> "picture");
		_str = getText (configFile >> "CfgVehicles" >> _model >> "displayName");
		_text = format["%1 %2%3", _str, _health, "%"];
		_id = lbAdd [_idcVehicles, _text];

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

				if (!alive _vehicle) then
				{
					["Vehicle destroyed", true, false, htGeneral, false] call funcHint;
				}
				else
				{
					if ((_vehicle distance _truck) > repairRange) then
					{
						["Vehicle out of repair range", true, false, htGeneral, false] call funcHint;
					}
					else
					{
						[_unit, _truck, _vehicle] execVM "Player\HealRepair.sqf";
					};
				};
			};
		};
	};
};