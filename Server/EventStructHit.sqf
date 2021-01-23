// args: [[object, source, amount], siStruct, score]

_object = (_this select 0) select 0;
_source = (_this select 0) select 1;
_amount = (_this select 0) select 2;
_siStruct = _this select 1;
_scoreTotal = _this select 2;

_sigi = _source call funcGetSideAndGroup;
_siSource = _sigi select 0;
_giSource = _sigi select 1;

if ( _siSource != -1 && _giSource != -1 && _source != _object ) then
{
	if ( _amount > 1 ) then {_amount = 1;};
	_score = floor(_scoreTotal*_amount);
	if ( _score < 1 ) then {_score = 1;};

	if ( _siSource != _siStruct && _scoreTotal > 0 ) then
	{
		[_score, scStruct, _siSource, _giSource] spawn funcSendScore;
	};
};
