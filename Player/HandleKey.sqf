_display = _this select 0;
_keypressed = _this select 1;
_shift_state = _this select 2;
_control_state = _this select 3;
_alt_state = _this select 4;

_return = false;

#define KEYSCODE_2_KEY		3
#define KEYSCODE_C_KEY      46

switch (_keypressed) do
{
	case KEYSCODE_2_KEY:
	{
		if ( !(isNull(getConnectedUAV player))) then
		{
			_return = true;
		};
	};
	case KEYSCODE_C_KEY:
	{
		_sitting = player getVariable ["sitting", false];

		if ( _sitting ) then
		{
			player setVariable ["sitting", false, false];
			detach player;
			[[player, ""], "funcSwitchMove", true, false, true] call BIS_fnc_MP;
		};
	};
};
_return;