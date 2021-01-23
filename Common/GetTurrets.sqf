private ["_mainturret", "_level", "_idx", "_t", "_g","_c", "_ct","_i","_j","_nidx","_res"];

_mainturret = _this select 0 >> "Turrets";
_level = _this select 1;
_idx = _this select 2;

_t = [];
_g = [];
_c = [];
_ct = [];

if ( isClass (_mainturret) ) then
{

	_j=0;
	for[ {_i=0}, {_i<count(_mainturret)}, {_i=_i+1}] do
	{

		_turret = _mainturret select _i;

		if ( isClass _turret ) then
		{

			_nidx = _idx + [_j];
			_t = _t + [_turret];

			if ( getNumber(_turret >> "dontCreateAI") == 1 ) then
			{
				_ct = _ct + [_nidx];
				_j=_j+1;
			}
			else
			{
				if ( getNumber(_turret >> "commanding") == 2 && getNumber(_turret >> "primarygunner") != 1 ) then
				{
					_c = _c + [_nidx];
					_j=_j+1;
				}
				else
				{
					if ( getNumber(_turret >> "hasGunner") > 0 ) then
					{
						_g = _g + [_nidx];
						_j=_j+1;
					};
				};
			};

			if ( (configName _turret) == "MainTurret" ) then
			{
				_res = [_mainturret >> "MainTurret",_level + 1,_nidx] call funcGetTurrets;

				_t = _t + (_res select 0);
				_g = _g + (_res select 1);
				_c = _c + (_res select 2);
				_ct = _ct + (_res select 3);
			};

		};
	};

};

[_t,_g,_c,_ct]