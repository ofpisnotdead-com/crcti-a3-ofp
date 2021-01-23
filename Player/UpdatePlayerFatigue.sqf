while {true}do
{
	waitUntil { (playerBAC > 0) || (getFatigue player > FatigueLimit) };
	
	if ( playerBAC > 0 && (getFatigue player) < playerBac / 0.2 ) then
	{
		player setFatigue playerBac / 0.2;
		player setCustomAimCoef WeaponSwayFactor + (playerBac / 0.04);
	}
	else
	{
		player setCustomAimCoef WeaponSwayFactor;
		if ( getFatigue player > FatigueLimit ) then
		{
			player setFatigue FatigueLimit;
		};
	};
};