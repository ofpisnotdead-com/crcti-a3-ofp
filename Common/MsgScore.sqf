if (count(pvGameOver) == 0) then
{
	_pvScore = _this select 0;

	_score = _pvScore select 0;
	_class = _pvScore select 1;
	_gi = _pvScore select 2;
	_si = _pvScore select 3;

	if ( _si > -1 && _gi > -1 && _class > -1 && _si != siCiv) then
	{
		_id = str(_si);
		_name = sideNamesAI select _si;

		if ( _si == siWest || _si == siEast ) then
		{
			_group = (groupMatrix select _si) select _gi;
			_unit = leader _group;

			if ( isPlayer _unit ) then
			{
				_id = getPlayerUID _unit;
				_name = name _unit;
			};
		};

		if ( isServer && (_si == siWest || _si == siEast) ) then
		{
			(scoreMoney select _si) set [_gi, ((scoreMoney select _si) select _gi) + _score];
		};

		_score = round(_score*scoreFactor);

		_found = false;
		{
			if ( (_si == _x select 0) && _id == (_x select 1)) exitWith
			{
				_found = true;

				_scoreline = _x select 3;
				_newscore = (_scoreline select _class) + _score;
				_scoreline set [_class, _newscore];

				_total = (_x select 4) + _score;
				_x set [4, _total];
				_x set [2, _name];
			};
		}forEach groupScoreMatrix;

		if ( !_found ) then
		{
			_newscore = [];
			{
				_newscore set [_forEachIndex, 0];
			}forEach scoreDefs;

			_newscore set [_class, _score];

			_scoreline = [_si, _id, _name, _newscore, _score];
			groupScoreMatrix set [count(groupScoreMatrix), _scoreline];
		};

	};

};

