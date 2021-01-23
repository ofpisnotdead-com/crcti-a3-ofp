// args: [object, si, cost]

_object = _this select 0;
_si = _this select 1;
_cost = _this select 2;

// calc score
_score = round(_cost*structScoreFactor);

if ( _cost > 0 && _score < 1 ) then {_score = 1;};

_event = format["_nul = [_this, %1, %2] spawn EventStructHit", _si, _score];

_object addEventHandler ["hit", _event];