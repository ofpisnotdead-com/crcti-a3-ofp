tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = true;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;
tf_terrain_interception_coefficient = 0.7 * AcreLossModelScaleFactor;

publicVariable "tf_no_auto_long_range_radio";
publicVariable "TF_give_personal_radio_to_regular_soldier";
publicVariable "tf_same_sw_frequencies_for_side";
publicVariable "tf_same_lr_frequencies_for_side";

_SwFreqs = [];
_LrFreqs = [];

for [ {_i=30}, {_i<512}, {_i=_i+1}] do
{
	_SwFreqs = _SwFreqs + [_i];
	if ( _i < 87 ) then {_LrFreqs = _LrFreqs + [_i];};
};

_swWest = [];
_lrWest = [];
_swEast = [];
_lrEast = [];
_swGuer = [];
_lrGuer = [];

for [ {_i=0}, {_i<10}, {_i=_i+1}] do
{
	_fi = floor(random(count _SwFreqs));
	_swWest = _swWest + [str(_SwFreqs select _fi)];
	_SwFreqs set [_fi, 0];
	_SwFreqs = _SwFreqs - [0];

	_fi = floor(random(count _SwFreqs));
	_swEast = _swEast + [str(_SwFreqs select _fi)];
	_SwFreqs set [_fi, 0];
	_SwFreqs = _SwFreqs - [0];

	_fi = floor(random(count _SwFreqs));
	_swGuer = _swGuer + [str(_SwFreqs select _fi)];
	_SwFreqs set [_fi, 0];
	_SwFreqs = _SwFreqs - [0];

	_fi = floor(random(count _LrFreqs));
	_lrWest = _lrWest + [str(_LrFreqs select _fi)];
	_LrFreqs set [_fi, 0];
	_LrFreqs = _LrFreqs - [0];

	_fi = floor(random(count _LrFreqs));
	_lrEast = _lrEast + [str(_lrFreqs select _fi)];
	_lrFreqs set [_fi, 0];
	_lrFreqs = _lrFreqs - [0];

	_fi = floor(random(count _LrFreqs));
	_lrGuer = _lrGuer + [str(_lrFreqs select _fi)];
	_lrFreqs set [_fi, 0];
	_lrFreqs = _lrFreqs - [0];
};

_swWest set [0, _lrWest select 0];
_swWest set [1, _lrWest select 1];
_swEast set [0, _lrEast select 0];
_swEast set [1, _lrEast select 1];
_swGuer set [0, _lrGuer select 0];
_swGuer set [1, _lrGuer select 1];


diag_log str(_swWest);
diag_log str(_lrWest);
diag_log str(_swEast);
diag_log str(_lrEast);
diag_log str(_swGuer);
diag_log str(_lrGuer);


_settingsSwWest = false call TFAR_fnc_generateSwSettings;
_settingsSwWest set [2, _swWest];
tf_freq_west = _settingsSwWest;
_settingsLrWest = false call TFAR_fnc_generateLrSettings;
_settingsLrWest set [2, _lrWest];
tf_freq_west_lr = _settingsLrWest;

_settingsSwEast = false call TFAR_fnc_generateSwSettings;
_settingsSwEast set [2, _swEast];
tf_freq_east = _settingsSwEast;
_settingsLrEast = false call TFAR_fnc_generateLrSettings;
_settingsLrEast set [2, _lrEast];
tf_freq_east_lr = _settingsLrEast;

_settingsSwGuer = false call TFAR_fnc_generateSwSettings;
_settingsSwGuer set [2, _swGuer];
tf_freq_guer = _settingsSwGuer;
_settingsLrGuer = false call TFAR_fnc_generateLrSettings;
_settingsLrGuer set [2, _lrGuer];
tf_freq_guer_lr = _settingsLrGuer;


publicVariable "tf_freq_west";
publicVariable "tf_freq_west_lr";
publicVariable "tf_freq_east";
publicVariable "tf_freq_east_lr";
publicVariable "tf_freq_guer";
publicVariable "tf_freq_guer_lr";