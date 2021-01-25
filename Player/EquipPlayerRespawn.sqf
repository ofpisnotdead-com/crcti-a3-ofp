// args: [unit, si]

_unit = _this Select 0;
_si = _this Select 1;

if ( _unit == leader group _unit ) then
{
        _unit call funcGearClear;
        systemChat format ["%1", _si];
        [_unit, _si, "Default"] call funcGearAssign;
}
else
{
	_unit setVehicleAmmo 1;
};

// Set Radio Channel 1 to Side Frequency
if ( AcreAllowed ) then
{
	_freqs = pvAcreFreq select _si;
	{
		[_x, _freqs ] call acre_api_fnc_setDefaultChannels;
	}forEach AcreRadioClasses;
};
