forceMap false;
closeDialog 0;

player setDamage 0;

if ( player != vehicle player ) then
{
	player action ["EJECT", vehicle player];
	unassignVehicle player;
	[player] orderGetIn false;
	[player] allowGetIn false;
};

_drawMusic = "Track04_Underwater1";
_winMusic = "Track03_OnTheRoad";
_loseMusic = "Track01_Proteus";

sleep 1;

_textResult = "";
_textReason = "";
_mhqWinner = objNull;
_mhqLoser = objNull;

_value = pvGameOver;

_type = _value select 0;
_siWinner = _value select 1;
_siLoser = siEnemy select _siWinner;

_WestTotal = moneySideTotal select siwest;
_EastTotal = moneySideTotal select sieast;
_wintotal = 0;

"1" ObjStatus "FAILED";
"2" ObjStatus "FAILED";
"3" ObjStatus "FAILED";

2 setFog 0;
sleep 2;
2 setOverCast 0;
sleep 2;

_gameEndType = -1;
gameEndDialog = 0;

if ( _type == 0 ) then
{

	if (_EastTotal == _WestTotal) then
	{
		_textResult = "DRAW";
		_textReason = format ["Time Limit (%1h)", timeLimit/(60*60)];
		_siLoser= siWest;
		_siWinner=siEast;
		_mhqLoser = mhqWest;
		_mhqWinner = mhqEast;
		_textLoser="WEST";
		_textWinner="EAST";
		playMusic _drawMusic;
		_gameEndType = 3;
	};

	if (_EastTotal < _WestTotal) then
	{
		_textResult = "WEST Wins";
		_mhqWinner = mhqWest;
		_mhqLoser = mhqEast;
		_siLoser = siEast;
		_siWinner = siWest;
		_wintotal = _WestTotal - _EastTotal;
		_textReason = format["ECONOMIC WIN\n WEST Made $%1 More than EAST",_wintotal];
		_gameEndType = 1;
		if ( playerSideIndex == siWest ) then
		{
			playMusic _winMusic;
			"3" ObjStatus "DONE";
		}
		else
		{
			playMusic _loseMusic;
		};
	};

	if (_EastTotal > _WestTotal) then
	{
		_textResult = "EAST Wins";
		_mhqWinner = mhqEast;
		_mhqLoser = mhqWest;
		_siLoser = siWest;
		_siWinner = siEast;
		_wintotal = _EastTotal - _WestTotal;
		_textReason = format["ECONOMIC WIN\n EAST Made $%1 More than WEST",_wintotal];
		_gameEndType = 2;
		if ( playerSideIndex == siEast ) then
		{
			playMusic _winMusic;
			"3" ObjStatus "DONE";
		}
		else
		{
			playMusic _loseMusic;
		};

	};

};

if ( _type == 1 || _type == 2 || _type == 3) then
{

	if (_siWinner == siWest) then
	{
		_textResult = "WEST Wins";
		_mhqWinner = mhqWest;
		_mhqLoser = mhqEast;
		_siLoser= siEast;
		_gameEndType = 1;
	};
	if (_siWinner == siEast) then
	{
		_textResult = "EAST Wins";
		_mhqWinner = mhqEast;
		_mhqLoser = mhqWest;
		_siLoser=siWest;
		_gameEndType = 2;
	};

	if (_type == 1) then
	{
		_textReason = "Destruction";
		if ( playerSideIndex == _siWinner ) then {"1" ObjStatus "DONE";};
	};
	if (_type == 2) then
	{
		_textReason = "All Towns";
		if ( playerSideIndex == _siWinner ) then {"2" ObjStatus "DONE";};
	};
	if (_type == 3) then
	{
		_textReason = "Surrender";
	};

	if ( _siWinner == playerSideIndex) then {playMusic _winMusic;};
	if ( _siLoser == playerSideIndex) then {playMusic _loseMusic;};

};

_cam = "camera" camCreate [posCenter select 0, posCenter select 1, 200];
camUseNVG false;

_cam cameraEffect ["internal","back"];
_cam camSetFOV 1;
_cam camSetDive 0;
_cam camSetPos [posCenter select 0, posCenter select 1, 200];
_cam setDir (daytime/24)*360;
_cam camCommit 0;
showCinemaBorder true;

TitleText[Format ["%1 - %2", _textResult, _textReason], "PLAIN", 1];

sleep 10;

_dlghandle = [] execVM "Player\UpdateGameOverDialogs.sqf";

if ( (dayTime > 6) && (dayTime < 18) ) then {camUseNVG false;};
if (!((dayTime > 6) && (dayTime < 18))) then {camUseNVG true;};

_targets = (BaseMatrix select _siWinner) + [position _mhqWinner] + (BaseMatrix select _siLoser) + [position _mhqLoser];
_targetTexts = [];

if ( count(BaseMatrix select _siWinner) > 0 ) then {_targetTexts = _targetTexts + [format["%1 Base 1", sideNames select _siWinner]];};
if ( count(BaseMatrix select _siWinner) > 1 ) then {_targetTexts = _targetTexts + [format["%1 Base 2", sideNames select _siWinner]];};
_targetTexts = _targetTexts + [format["MHQ %1", sideNames select _siWinner]];
if ( count(BaseMatrix select _siLoser) > 0 ) then {_targetTexts = _targetTexts + [format["%1 Base 1", sideNames select _siLoser]];};
if ( count(BaseMatrix select _siLoser) > 1 ) then {_targetTexts = _targetTexts + [format["%1 Base 2", sideNames select _siLoser]];};
_targetTexts = _targetTexts + [format["MHQ %1", sideNames select _siLoser]];

{
	_target = _x;
	_posInfo = _target call funcCalcTownDirDistFromPos;
	_textPos = format ["%1 %2 %3", _posInfo select 0, _posInfo select 1, _posInfo select 2];

	_start = [-150 + (_x select 0) + random(300),-150 + (_x select 1) + random(300), 20 + random(50)];
	_stop = [-150 + (_x select 0) + random(300),-150 + (_x select 1) + random(300), 20 + random(50)];

	_cam camSetTarget _target;
	_cam camSetPos _start;
	_cam camCommit 0;
	_cam camSetPos _stop;
	_cam camCommit 15;

	TitleText[Format ["%1 - %2", _targetTexts select _forEachIndex, _textPos], "PLAIN DOWN", 1];

	waitUntil {camCommitted _cam};

}forEach _targets;

// Player of the Match

_bestPlayer = objNull;
_bestScore = -10000000;
_bestName = "";

{
	_si = _x;
	{
		_gi = _forEachIndex;
		_group = _x;
		_leader = leader _group;
		_score = [_si, _gi] call funcCalcScore;

		if ( _score > _bestScore && isPlayer _leader ) then
		{
			_bestScore = _score;
			_bestPlayer = _leader;
			_bestName = [_si,_gi] call funcGetGroupName;
		};

	}forEach (groupMatrix select _si);

}forEach [siWest, siEast];

if ( !isNull _bestPlayer ) then
{
	player setDir 0;
	player setDamage 0;

	player playMove "aidlpercmstpsraswrfldnon_idlesteady04n";

	_bestPos = getPos _bestPlayer;
	if ( player != _bestPlayer ) then
	{
		_npos = [(_bestPos select 0), (_bestPos select 1) - 3, 0];
		_pos = [_npos, 1, 5, false, objNull] call funcGetRandomPos;
		player setPos _pos;
	};

	_campos = [(_bestPos select 0) - 0.5, (_bestPos select 1) + 3, 1.5];
	_cam camSetTarget _bestPlayer;
	_cam camSetPos _campos;
	_cam camCommit 0;

	TitleText[Format ["Player of the Match: %1 (Score: %2)", _bestName, _bestScore], "PLAIN DOWN", 1];

	_campos = [(_bestPos select 0) + 0.5, (_bestPos select 1) + 3, 1.5];

	_cam camSetPos _campos;
	_cam camCommit 20;

	if ( player != _bestPlayer ) then
	{
		sleep 2;
		player action ["salute", player];
	};

	waitUntil {camCommitted _cam};

};

_cam camSetDive 0;
_cam camSetPos [posCenter select 0, posCenter select 1, 200];
_cam setDir (daytime/24)*360;
_cam camCommit 0;

gameEndDialog = 1;
waituntil { scriptDone _dlghandle; };

_handle = [false] execVM "Player\OpenLeaderboardDialog.sqf";
waituntil {scriptDone _handle};
waituntil {! dialog};

titleRsc ["crctilogo","PLAIN"];
sleep 10;

camUseNVG false;

if ( _gameEndType == 1 ) then
{
	endMission "END1";
};
if ( _gameEndType == 2 ) then
{
	endMission "END2";
};
if ( _gameEndType == 3 ) then
{
	endMission "END3";
};