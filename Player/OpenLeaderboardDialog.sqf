disableSerialization;

_back = _this select 0;

_lastt = -1;
_sleep = 2;

_dlg = createDialog "LeaderboardDialog";
[IDD_LeaderboardDialog]call funcFixDialogTitleColor;

{
	ctrlEnable [_x, true];
}foreach [IDC_LB_GROUP, IDC_LB_INFANTRY, IDC_LB_VEHICLE, IDC_LB_MHQ, IDC_LB_STRUCT, IDC_LB_TOWN, IDC_LB_TOTAL, IDC_LB_SIDE, IDC_LB_INFANTRYSIDE, IDC_LB_MHQSIDE, IDC_LB_TOWNSIDE, IDC_LB_TOTALSIDE, IDC_LB_VEHICLESIDE, IDC_LB_STRUCTSIDE];

while {true}do
{

	if ( !dialog || !(ctrlVisible IDC_LB_GROUP)) exitWith {};
	if ((count(pvGameOver) == 0) && !(alive player)) exitWith {closeDialog 0;};

	if ( time > _lastt + _sleep ) then
	{
		_lastt = time;
		
		_totalTotal = [0,0,0,0,0,0];
		_totalScores = [[],[],[],[],[],[]];
		{
			(_totalScores select siWest) set [_forEachIndex, 0];
			(_totalScores select siEast) set [_forEachIndex, 0];
		}forEach scoreDefs;

		_scoresPlayers = [];
		_scoresAI = [];
		_scoresResi = [];
		{
			if ( (_x select 1) == "0" || (_x select 1) == "1" ) then
			{
				_scoresAI = _scoresAI + [_x];
			}
			else
			{
				if ( (_x select 1) == "2" ) then
				{
					_scoresResi = _scoresResi + [_x];
				}
				else
				{
					_scoresPlayers = _scoresPlayers + [_x];
				};
			};
		}forEach groupScoreMatrix;

		_scoresPlayers = [4, false, _scoresPlayers] call funcSort;
		_scoresAI = [4, false, _scoresAI] call funcSort;

		{
			lbClear _x;
		}foreach [IDC_LB_GROUP, IDC_LB_INFANTRY, IDC_LB_VEHICLE, IDC_LB_MHQ, IDC_LB_STRUCT, IDC_LB_TOWN, IDC_LB_TOTAL, IDC_LB_SIDE, IDC_LB_INFANTRYSIDE, IDC_LB_MHQSIDE, IDC_LB_TOWNSIDE, IDC_LB_TOTALSIDE, IDC_LB_VEHICLESIDE, IDC_LB_STRUCTSIDE];

		{
			{
				_score = _x;
				_scoreline = + (_x select 3);

				if ( count(pvGameOver) == 0 ) then
				{
					_scoreline set [scVehicle, (_scoreline select scVehicle) + (_scoreline select scMHQ)];
					_scoreline set [scMHQ, 0];
				};

				_side = _score select 0;

				if ( count(pvGameOver) > 0 || LeaderBoardAvailable == 2 || (LeaderBoardAvailable == 1 && _side == playerSideIndex)) then
				{

					_id = _score select 1;
					_name = _score select 2;
					_inf = _scoreline select scInfantry;
					_veh = _scoreline select scVehicle;
					_mhq = _scoreline select scMHQ;
					_struct = _scoreline select scStruct;
					_town = _scoreline select scTown;
					_total = _score select 4;

					{
						(_totalScores select _side) set [_forEachIndex, ((_totalScores select _side) select _forEachIndex) + (_scoreline select _forEachIndex)];
					}forEach scoreDefs;
					_totalTotal set [_side, (_totalTotal select _side) + _total];

					_color = sideColors select _side;

					_id = lbAdd[IDC_LB_GROUP, _name];
					lbSetColor [IDC_LB_GROUP, _id, _color];
					_id = lbAdd[IDC_LB_INFANTRY, str(_inf)];
					lbSetColor [IDC_LB_INFANTRY, _id, _color];
					_id = lbAdd[IDC_LB_VEHICLE, str(_veh)];
					lbSetColor [IDC_LB_VEHICLE, _id, _color];
					_id = lbAdd[IDC_LB_MHQ, str(_mhq)];
					lbSetColor [IDC_LB_MHQ, _id, _color];
					_id = lbAdd[IDC_LB_STRUCT, str(_struct)];
					lbSetColor [IDC_LB_STRUCT, _id, _color];
					_id = lbAdd[IDC_LB_TOWN, str(_town)];
					lbSetColor [IDC_LB_TOWN, _id, _color];
					_id = lbAdd[IDC_LB_TOTAL, str(_total)];
					lbSetColor [IDC_LB_TOTAL, _id, _color];
				};

			}forEach _x;
		}forEach [_scoresPlayers, _scoresAI, _scoresResi];

		_totalTotalHigh = _totalTotal select siWest;
		_totalScoresHigh = _totalScores select siWest;
		_colorHigh = sideColors select siWest;
		_textHigh = sideNames select siWest;
		_totalTotalLow = _totalTotal select siEast;
		_totalScoresLow = _totalScores select siEast;
		_colorLow = sideColors select siEast;
		_textLow = sideNames select siEast;

		if ( (_totalTotal select siEast) > (_totalTotal select siWest)) then
		{
			_totalTotalHigh = _totalTotal select siEast;
			_totalScoresHigh = _totalScores select siEast;
			_colorHigh = sideColors select siEast;
			_textHigh = sideNames select siEast;
			_totalTotalLow = _totalTotal select siWest;
			_totalScoresLow = _totalScores select siWest;
			_colorLow = sideColors select siWest;
			_textLow = sideNames select siWest;
		};

		_id = lbAdd [IDC_LB_SIDE, _textHigh];
		lbSetColor [IDC_LB_SIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_SIDE, _textLow];
		lbSetColor [IDC_LB_SIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_INFANTRYSIDE, str(_totalScoresHigh select scInfantry)];
		lbSetColor [IDC_LB_INFANTRYSIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_INFANTRYSIDE, str(_totalScoresLow select scInfantry)];
		lbSetColor [IDC_LB_INFANTRYSIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_VEHICLESIDE, str(_totalScoresHigh select scVehicle)];
		lbSetColor [IDC_LB_VEHICLESIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_VEHICLESIDE, str(_totalScoresLow select scVehicle)];
		lbSetColor [IDC_LB_VEHICLESIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_MHQSIDE, str(_totalScoresHigh select scMHQ)];
		lbSetColor [IDC_LB_MHQSIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_MHQSIDE, str(_totalScoresLow select scMHQ)];
		lbSetColor [IDC_LB_MHQSIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_STRUCTSIDE, str(_totalScoresHigh select scStruct)];
		lbSetColor [IDC_LB_STRUCTSIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_STRUCTSIDE, str(_totalScoresLow select scStruct)];
		lbSetColor [IDC_LB_STRUCTSIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_TOWNSIDE, str(_totalScoresHigh select scTown)];
		lbSetColor [IDC_LB_TOWNSIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_TOWNSIDE, str(_totalScoresLow select scTown)];
		lbSetColor [IDC_LB_TOWNSIDE, _id, _colorLow];

		_id = lbAdd [IDC_LB_TOTALSIDE, str(_totalTotalHigh)];
		lbSetColor [IDC_LB_TOTALSIDE, _id, _colorHigh];
		_id = lbAdd [IDC_LB_TOTALSIDE, str(_totalTotalLow)];
		lbSetColor [IDC_LB_TOTALSIDE, _id, _colorLow];
	};
};

if ( _back ) then {_nul = [] exec "Player\OpenOptionsMenu.sqs";};