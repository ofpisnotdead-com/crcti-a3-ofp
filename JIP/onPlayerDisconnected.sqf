if (isServer) then
{
	_uid = _this select 1;

	{
		_si = _x;
		_groups = groupMatrix select _si;
		_index = 0;
		_gi = -1;

		{
			if (_uid == _x) exitwith
			{
				_group = _groups select _index;
				_gi = _index;
				_nul = [_group, _si, _index] execVM "JIP\DetectPlayerDisconnect.sqf";
				(JIPUserID select _si) set[_index,"-1"];
			};
			_index = _index + 1;
		}forEach (JIPUserID select _si);
	}forEach [siWest, siEast];
};