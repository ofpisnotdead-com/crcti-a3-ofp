// args: [vehicle, lock]
private ["_v", "_lock"];

_v = _this select 0;
_lock = _this select 1;

if ( local _v ) then
{
	_v lock _lock;
}
else
{
	if ( _lock ) then
	{		
		pvLock = _v;
		publicVariable "pvLock";
		_nul = [pvLock] spawn MsgLock;
	}
	else
	{	
		pvUnlock = _v;
		publicVariable "pvUnlock";
		_nul = [pvUnlock] spawn MsgUnlock;
	};
};