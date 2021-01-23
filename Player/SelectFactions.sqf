disableSerialization;
_dialog = CreateDialog "FactionsDialog";

_sideList = [siWest, siEast, siRes, siCiv];

_localFactions = [];
_availableFactions = [];

_selectedFactions = DefaultFactions;
if ( profileAvailable ) then {_selectedFactions = profileNameSpace getVariable ["savedSelectedFactions", DefaultFactions];};

_serverResult = [];

_cfgfile = configFile >> "CfgFactionClasses";
_count = count(_cfgfile);

for [ {_i=0}, {_i<_count}, {_i=_i+1}] do
{
	_entry = (_cfgfile) select _i;

	if ( isClass _entry ) then
	{
		_side = getNumber(_entry >> "side");
		if ( _side >= 0 && _side < 4 ) then
		{
			_class = configName _entry;
			_localFactions = _localFactions + [_class];
		};
	};

};

player setVariable ["playerVotedFactions", false, true];
player setVariable ["playerLocalFactions", _localFactions, true];
player setVariable ["playerSelectedFactions", _selectedFactions, true];

_fServerUpdate = {

	_lastResult = + _serverResult;
	lnbClear IDC_LB_RESULT_FACTIONS;
	{
		_si = _x;
		_id = lnbAddRow [IDC_LB_RESULT_FACTIONS, ["", format["--- %1 ---", sideNames select _si]]];
		lnbSetValue [IDC_LB_RESULT_FACTIONS, [_id,0], -1];

		{
			_faction = _x call funcMapFaction;
			if ( _faction select 1 == _si ) then
			{
				_id = lnbAddRow [IDC_LB_RESULT_FACTIONS, ["", _faction select 3]];
				lnbSetPicture [IDC_LB_RESULT_FACTIONS, [_id, 0], _faction select 2];
				lnbSetValue [IDC_LB_RESULT_FACTIONS, [_id, 0], _forEachIndex];
			};

		}forEach _serverResult;
	}forEach _sideList;

};

_fUpdate = {

	_lastAvailable = + _availableFactions;
	lnbClear IDC_LB_AVAILABLE_FACTIONS;
	{
		_si = _x;
		_id = lnbAddRow [IDC_LB_AVAILABLE_FACTIONS, ["", format["--- %1 ---", sideNames select _si]]];
		lnbSetValue [IDC_LB_AVAILABLE_FACTIONS, [_id,0], -1];

		{
			_faction = _x call funcMapFaction;
			if ( _faction select 1 == _si && !(_x in _selectedFactions)) then
			{
				_id = lnbAddRow [IDC_LB_AVAILABLE_FACTIONS, ["", _faction select 3]];
				lnbSetPicture [IDC_LB_AVAILABLE_FACTIONS, [_id, 0], _faction select 2];
				lnbSetValue [IDC_LB_AVAILABLE_FACTIONS, [_id, 0], _forEachIndex];
			};

		}forEach _availableFactions;
	}forEach _sideList;

	_lastSelected = + _selectedFactions;
	lnbClear IDC_LB_SELECTED_FACTIONS;
	{
		_si = _x;
		_id = lnbAddRow [IDC_LB_SELECTED_FACTIONS, ["", format["--- %1 ---", sideNames select _si]]];
		lnbSetValue [IDC_LB_SELECTED_FACTIONS, [_id,0], -1];

		{
			_faction = _x call funcMapFaction;
			if ( _faction select 1 == _si && (_x in _availableFactions) ) then
			{
				_id = lnbAddRow [IDC_LB_SELECTED_FACTIONS, ["", _faction select 3]];
				lnbSetPicture [IDC_LB_SELECTED_FACTIONS, [_id, 0], _faction select 2];
				lnbSetValue [IDC_LB_SELECTED_FACTIONS, [_id, 0], _forEachIndex];
			};

		}forEach _selectedFactions;
	}forEach _sideList;

	player setVariable ["playerSelectedFactions", _selectedFactions, true];
};

_lastAvailable = -1;
_lastSelected = -1;
_lastResult = -1;

btnFinished=false;

selectMusicLoop=true;
playMusic "jeopardy1";

_handler = {
	if ( selectMusicLoop ) then
	{
		playMusic "jeopardy1";
	}
	else
	{
		playMusic "jeopardy2";
		removeMusicEventHandler ["MusicStop", selectMusicHandler];
	};
};

selectMusicHandler = addMusicEventHandler ["MusicStop", _handler];

while {!pvFactionsSelected}do
{
	if ( !dialog ) then
	{
		_dialog = CreateDialog "FactionsDialog";
		call _fUpdate;
		call _fServerUpdate;
	};

	if ( !isNil "pvFactionSelectionTimeout") then
	{
		_str = format["%1", (pvFactionSelectionTimeout) call funcSecondsToString];
		ctrlSetText[IDC_FACTION_TIMER, _str];
	};

	if (count(pvServerFactions) > 0 )then
	{

		_availableFactions = + pvServerFactions;
		_serverResult = + pvServerFactionsResult;

		_missing = _selectedFactions - _availableFactions;
		_selectedFactions = _selectedFactions - _missing;

		if ( str(_lastAvailable) != str(_availableFactions) || str(_lastSelected) != str(_selectedFactions) ) then {call _fUpdate;};
		if ( str(_lastResult) != str(_serverResult)) then {call _fServerUpdate;};

		_sel = lnbCurSelRow IDC_LB_AVAILABLE_FACTIONS;
		if ( _sel >= 0 ) then
		{
			_val = lnbValue [IDC_LB_AVAILABLE_FACTIONS, [_sel,0]];
			lnbSetCurSelRow [IDC_LB_AVAILABLE_FACTIONS, -1];

			_fac = _availableFactions select _val;
			if ( _val >= 0 && !(_fac in _selectedFactions)) then
			{
				_selectedFactions = _selectedFactions + [_fac];
			};
			diag_log format["%1 %2", str(_sel), str(_val)];
		};

		_sel = lnbCurSelRow IDC_LB_SELECTED_FACTIONS;
		if ( _sel >= 0 ) then
		{
			_val = lnbValue [IDC_LB_SELECTED_FACTIONS, [_sel,0]];
			lnbSetCurSelRow [IDC_LB_SELECTED_FACTIONS, -1];
			if ( _val >= 0 ) then
			{
				_fac = _selectedFactions select _val;
				_selectedFactions = _selectedFactions - [_fac];
			};
			diag_log format["%1 %2", str(_sel), str(_val)];
		};
	};

	if ( btnFinished ) then
	{
		btnFinished = false;
		ctrlShow[IDC_FACTION_SELECTION_FINISHED, false];
		player setVariable ["playerVotedFactions", true, true];
		if ( profileAvailable ) then
		{
			profileNameSpace setVariable ["savedSelectedFactions", _selectedFactions];
			saveProfileNameSpace;
		};
	};
};

selectMusicLoop=false;
closeDialog 0;