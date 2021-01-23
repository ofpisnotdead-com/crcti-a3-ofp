AutoFactionsWest = [];
AutoFactionsEast = [];
AutoFactionsRes = [];
AutoFactionsCiv = [];

_serverFactions = [];

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
			_serverFactions = _serverFactions + [_class];
		};
	};

};

_availableFactions = [];
_lastAvailableFactions = [];

_selectedFactions = DefaultFactions;
_lastSelectedFactions = [];

_endt = time + factionSelectionTimeout;

_finished = false;
while {!_finished && time < _endt}do
{
	_availableFactions = + _serverFactions;
	_selectedFactions = [];

	_dt = _endt - time;
	pvFactionSelectionTimeout = _dt;
	publicVariable "pvFactionSelectionTimeout";

	_finished = true;
	{
		if ( isPlayer _x ) then
		{
			_selectedFactions = _selectedFactions + (_x getVariable ["playerSelectedFactions", []]);
			_playerFactions = _x getVariable ["playerLocalFactions", []];

			_missingFactions = _serverFactions - _playerFactions;

			_availableFactions = _availableFactions - _missingFactions;
			_selectedFactions = _selectedFactions - _missingFactions;

			_finished = _finished && (_x getVariable ["playerVotedFactions", false]);
		};
	}forEach playableUnits;

	if ( str(_lastAvailableFactions) != str(_availableFactions) ) then
	{
		_lastAvailableFactions = + _availableFactions;
		pvServerFactions = _availableFactions;
		publicVariable "pvServerFactions";
	};

	if ( str(_lastSelectedFactions) != str(_selectedFactions) ) then
	{
		_tmp = + _selectedFactions;
		_selectedFactions = [];

		{
			if ( !(_x in _selectedFactions) ) then {_selectedFactions = _selectedFactions + [_x];};
		}forEach _tmp;

		_lastSelectedFactions = + _selectedFactions;
		pvServerFactionsResult = _selectedFactions;
		publicVariable "pvServerFactionsResult";
	};

	sleep 0.25;
};

{
	_faction = _x call funcMapFaction;

	if ( (_faction select 1) == siWest ) then {AutoFactionsWest = AutoFactionsWest + [_x];};
	if ( (_faction select 1) == siEast ) then {AutoFactionsEast = AutoFactionsEast + [_x];};
	if ( (_faction select 1) == siRes ) then {AutoFactionsRes = AutoFactionsRes + [_x];};
	if ( (_faction select 1) == siCiv ) then {AutoFactionsCiv = AutoFactionsCiv + [_x];};

}forEach _selectedFactions;

pvFactionsSelected = true;
publicVariable "pvFactionsSelected";