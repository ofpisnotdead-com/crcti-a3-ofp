// returns closest base of side
// args: [position, side]
// return: [base name, position, distance]

private ["_pos", "_si", "_bpos1", "_dist1", "_bpos2", "_dist2", "_return"];

_pos = _this select 0;
_si = _this select 1;
_return = [];

if((count(BaseMatrix select _si))>0) then
{
	if((count(BaseMatrix select _si))==1)then
	{
		_bpos1 = (BaseMatrix select _si) select 0;
		_dist1 = _pos distance _bpos1;
		_return = ["Base1", _bpos1, _dist1];

	} else {

		_bpos1 = (BaseMatrix select _si) select 0;
		_dist1 = _pos distance _bpos1;

		_bpos2 = (BaseMatrix select _si) select 1;
		_dist2 = _pos distance _bpos2;
		
		if(_dist1 < _dist2)then {
			_return = ["Base1", _bpos1, _dist1];
		} else {
			_return = ["Base2", _bpos2, _dist2];
		};
	};
};

_return