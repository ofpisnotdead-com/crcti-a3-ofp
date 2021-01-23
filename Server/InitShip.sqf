// args: [object, type, si, gi]
_v = _this select 0;
_pos = getPos _v;

_pos set [2,10000];
_v setPos _pos;
_pos set [2,0];

_nearBuoys = _pos nearObjects ["Land_BuoyBig_F", 200];
_nearLHs = _pos nearObjects ["Land_Lighthouse_small_F", 200];

if ( count (_nearBuoys) > 0 && count(_nearLHs) > 0 ) then
{
	_buoy = _nearBuoys select 0;
	_lh = _nearLHs select 0;

	_bpos = getPos _buoy;
	_lpos = getPos _lh;

	_vec = ([_bpos, _lpos] call fVectorSubstract) call fVectorNormalize;
	_npos = [_lpos, _vec, 45] call fVectorAdd;

	_npos2 = _npos findEmptyPosition [1,30, typeOf _v];
	if ( count(_npos2) > 0 ) then {_npos = _npos2;};
	
	_v setDir (getDir _buoy);
	_v setPos _npos;
}
else
{
	_v setPos ((selectBestPlaces[_pos, 50, "sea + waterdepth factor [1.5,2.0]",1,5] select 0) select 0);
};
