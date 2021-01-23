if ( AcreAllowed && AcreChannelID > -1) then
{
	while {true}do
	{
		[AcreChannelID, "acrechannel"] spawn acre_api_fnc_joinChannel;
		sleep 30;
	};
};