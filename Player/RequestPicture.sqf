_si = playerSideIndex;
_gi = playerGroupIndex;

_money = ((groupMoneyMatrix select _si) select _gi);

if ( _money >= PicturePrice) then
{
	[PicturePrice] execVM "Player\SendMoneySpent.sqf";
	CurPictureTime = time + PictureTime;
}
else
{
	["Not enough Money", true, false, htGeneral, false] call funcHint;
};
