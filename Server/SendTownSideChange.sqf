// args: [indexTown, siNew, siLast]
private["_index", "_siNew", "_siLast", "_flag"];

_index = _this select 0;
_siNew = _this select 1;
_siLast = _this select 2;

_flag = (towns select _index) select tdFlag;

pvTownSide = [_index, _siNew, _siLast ];
_nul = [pvTownSide] execVM "Player\MsgSetTownSide.sqf";
publicVariable "pvTownSide";

if (_siNew == siRes) then
{
	_flag SetFlagTexture "\a3\data_f\Flags\flag_green_co.paa";
};

if (_siNew == siWest) then
{
	_flag SetFlagTexture "\a3\data_f\Flags\flag_blue_co.paa";
};

if (_siNew == siEast) then
{
	_flag SetFlagTexture "\a3\data_f\Flags\flag_red_co.paa";
};

(towns select _index) set [tdSide, _siNew];

if (_siNew == siWest || _siNew == siEast) then
{
	_siNew spawn scriptCheckWinTowns;
};
