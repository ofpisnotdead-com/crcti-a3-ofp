if ( isServer ) then
{
	_pvAddWorker = _this select 0;
	_value = _pvAddWorker;
	[_value] spawn scriptAddWorker;
};

