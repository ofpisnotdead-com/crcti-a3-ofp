_type = _this select 1;
_si = _this select 2;
_objects = _this select 4;

{

	if ( _x isKindOf "Land_FlatTV_01_F" ) then
	{
		_nul = [_x, 0, _si] execVM "Player\InitLiveFeed.sqf";
	};

	if ( _x isKindOf "Fridge_01_closed_F" ) then
	{
		_actionName = "Grab a Beer";
		_action =
		{
			pvSay3D = [_this select 1, [], "beer", 100];
			publicVariable "pvSay3D";
			_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";
			playerBACPending = playerBACPending + 0.02;
			[-(beerPrice*10), scBeer, playerSideIndex, playerGroupIndex] spawn funcSendScore;
		};

		_x addAction [ _actionName, _action, _x ];

	};

	if ( _x isKindOf "Land_FieldToilet_F" ) then
	{
		_actionName = "Use Toilet";
		_action =
		{
			pvSay3D = [_this select 0, [], "toilet", 100];
			publicVariable "pvSay3D";
			_nul = [pvSay3D] execVM "Player\MsgSay3D.sqf";
			playerBACPending = 0.001;
		};

		_x addAction [ _actionName, _action, _x ];

	};

	if ( _x isKindOf "Land_CampingChair_V2_F" ) then
	{
		_actionName = "Sit Down";
		_action =
		{
			_chillMoves = ["HubSittingAtTableU_idle1","HubSittingAtTableU_idle2","HubSittingAtTableU_idle2",
			"HubSittingChairA_idle1","HubSittingChairA_idle2","HubSittingChairA_idle3","HubSittingChairA_move1",
			"HubSittingChairB_idle1","HubSittingChairB_idle2","HubSittingChairB_idle3","HubSittingChairB_move1",
			"HubSittingChairC_idle1","HubSittingChairC_idle2","HubSittingChairC_idle3","HubSittingChairC_move1",
			"HubSittingChairUA_idle1","HubSittingChairUA_idle2","HubSittingChairUA_idle3","HubSittingChairUA_move1",
			"HubSittingChairUB_idle1","HubSittingChairUB_idle2","HubSittingChairUB_idle3","HubSittingChairUB_move1",
			"HubSittingChairUC_idle1","HubSittingChairUC_idle2","HubSittingChairUC_idle3","HubSittingChairUC_move1"];

			_chair = _this select 0;
			_player = _this select 1;

			_player setVariable ["sitting", true, false];

			_player attachTo [_chair,[0,-0.15,-0.45]];
			_player setDir 180;
			_move = _chillMoves select floor(random(count _chillMoves));
			[[_player, _move], "funcSwitchMove", true, false, true] call BIS_fnc_MP;
			["Press 'C' to stand up.", false, true, htGeneral, false] call funcHint;
		};

		_x addAction [ _actionName, _action, _x, 2, false, false, "", "count(attachedObjects _target) == 0" ];

	};

}forEach _objects;

