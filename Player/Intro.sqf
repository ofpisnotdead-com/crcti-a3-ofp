// uhuhuhu.

_play = true;
_uid = getPlayerUID player;

call compile format["if ( !isNil""IntroPlayed%1"" ) then { _play = false; };", _uid];

if ( _play ) then
{
	waitUntil {ReceivingScreenDone};
	call compile format["IntroPlayed%1 = true; publicVariable ""IntroPlayed%1"";", _uid];

	_namesWest = [];
	_namesEast = [];

	{
		_group = _x;
		{
			if ( isPlayer _x ) then
			{
				_namesWest = _namesWest + [name _x];
			};
		}forEach (units _group);
	}forEach (groupMatrix select siWest);

	{
		_group = _x;
		{
			if ( isPlayer _x ) then
			{
				_namesEast = _namesEast + [name _x];
			};
		}forEach (units _group);
	}forEach (groupMatrix select siEast);

	enableRadio false;
	_stime = time;

	playMusic "Track02_SolarPower";
	
	_pos = position player;
	_start = [-1000 + (_pos select 0) + random(2000), -1000 + (_pos select 1) + random(2000), 200];
	_target = [_pos select 0, _pos select 1,_start select 2];

	_pos set [2, 2];

	_cam = "camera" camCreate _start;
	_cam camSetTarget _target;
	_cam camSetPos _target;
	
	_cam camCommit 30;

	_cam cameraEffect ["internal","back"];
	_cam camSetFOV 1;

	showCinemaBorder true;

	waitUntil {time > (_stime + 3.5 )};
	titleText ["Kastenbier presents", "PLAIN", 0];
	waitUntil {time > (_stime + 7.5)};
	titleText ["a Squeeze Port of a Cleanrock Mission", "PLAIN", 0];
	waitUntil {time > (_stime + 11.5)};
	titleRsc ["crctilogo","PLAIN"];	
	waitUntil {time > (_stime + 15)};

	if ( count(_namesWest) > 0 ) then
	{
		_textWest = "BLUFOR\n";

		{
			_textWest = format["%1\n%2",_textWest,_x];
		}forEach _namesWest;

		titleText [_textWest, "PLAIN", 0];
	};

	waitUntil {time > (_stime + 18)};

	if ( count(_namesEast) > 0 ) then
	{
		_textEast = "OPFOR\n";
		{
			_textEast = format["%1\n%2",_textEast,_x];
		}forEach _namesEast;

		titleText [_textEast, "PLAIN", 0];
	};

	waitUntil {time > (_stime + 22)};

	_start = [-250 + (_pos select 0) + random(500), -250 + (_pos select 1) + random(500), 150];
	_cam camSetTarget position player;
	_cam camSetPos _start;
	_cam camCommit 0;
	_cam camSetPos [_pos select 0, _pos select 1, 80];
	_cam camCommit 10;

	waitUntil {time > (_stime + 25)};
	_start = [-15 + (_pos select 0) + random(30), -15 + (_pos select 1) + random(30), 1.75];
	_cam camSetPos _start;
	_cam camCommit 0;
	_cam camSetPos _pos;
	_cam camSetTarget _pos;
	_cam camCommit 3;

	waitUntil {camCommitted _cam;};

	_cam cameraEffect["terminate","back"];

	camDestroy _cam;
	enableRadio true;
};