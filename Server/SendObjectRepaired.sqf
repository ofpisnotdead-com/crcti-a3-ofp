// args: [object, damage, si, gi]

_object = _this select 0;
_dmg = _this select 1;
_si = _this select 2;
_gi = _this select 3;

_percent = (1 - _dmg)*100;
_percent = _percent - (_percent % 1);

pvObjectRepaired = [_object, _percent, _gi, _si];
_nul = [pvObjectRepaired] spawn MsgObjectRepaired;
publicVariable "pvObjectRepaired";
