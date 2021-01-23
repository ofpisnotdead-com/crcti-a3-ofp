// args: [vehicle, unit, idAction]

_truck = _this select 0;
_unit = _this select 1;
_vehicle = vehicle _unit;

_rt = _truck getVariable "lastRapTime";
if ( isNil "_rt" ) then {_rt = -500;};

if ( time < _rt + 60 ) then
{
	_nul = ["STOP THAT!",true, false, htTip,true] call funcHint;
	sleep 5;
	_truck setDamage 1;
	_unit setDamage 1;

}
else
{
	if ( time < _rt + 300 ) then
	{
		_nul = ["Raptruck rate limit exceeded!",true, false, htTip,true] call funcHint;
		sleep 2;
		_truck setDamage 1;

	};
};

if (alive _truck) then
{

	pvSay3D = [_truck, [], "hiphop", 200];
	publicVariable "pvSay3D";
	_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";

	_start = time;

	_truck setVariable ["lastRapTime", _start, true];

	while {time - _start < 15}do
	{
		_pos = getPos _truck;
		_truck setPos [_pos select 0, _pos select 1, (_pos select 2) + 0.2];
		sleep 1;
	};

};
