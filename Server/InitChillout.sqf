_type = _this select 0;
_si = _this select 1;
_objects = _this select 2;
_object = _objects select 0;

WorkerHangout set [_si, (WorkerHangout select _si) + [_object]];

if ( THISISARMA3 && ((productVersion select 2) >= 154) && ((productVersion select 3) >= 132763) ) then
{
	_stuff = [getPos _object, [], 10 ] call funcNearestTerrainObjects;
	{
		[_x, true] call funcHideObjectGlobal;
	}forEach _stuff;
};

{
	_x enableSimulation false;
	_dir = getDir _x;
	_pos = getPosATL _x;
	_pos set [2,(_pos select 2)+0.1];
	_up = surfaceNormal _pos;

	_x allowDamage false;
	_x setDamage 0;

	if ( _x isKindOf "Land_CampingTable_F" || _x isKindOf "Land_CampingChair_V2_F"
			|| _x isKindOf "Land_ClutterCutter_large_F" || _x isKindOf "Land_PartyTent_01_F"
			|| _x isKindOf "Land_Camping_Light_F") then
	{
		_x hideObject true;
	};

	if ( _x isKindOf "Land_Noticeboard_F") then
	{
		_x setObjectTextureGlobal [0, "Images\donotfeed.paa"];
	};

	_x enableSimulation true;
	_x setDir _dir;
	_x setPosATL _pos;
	_x setVectorUp _up;

}forEach _objects;

