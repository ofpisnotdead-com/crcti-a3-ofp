
_dlg = createDialog "DebugStatsDialog";

pvDebugStats = [];

pvSendDebugStats = true;
publicVariable "pvSendDebugStats";

_client = [] call MsgSendDebugStats;

waitUntil { count(pvDebugStats) > 0 };

{
	lbAdd[IDC_DBG_VALUE, _x];	
}forEach (pvDebugStats + ["---"] + _client);