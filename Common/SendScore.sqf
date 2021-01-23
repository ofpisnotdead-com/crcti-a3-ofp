// args: [score, class, si, gi]

_score = floor(_this select 0);
_class = _this select 1;
_si = _this select 2;
_gi = _this select 3;

pvScore = [_score, _class, _gi,_si];
_nul = [pvScore] spawn MsgScore;
publicVariable "pvScore";

