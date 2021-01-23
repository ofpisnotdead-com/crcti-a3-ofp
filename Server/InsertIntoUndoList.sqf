// args: [si,gi, type, objectArray]

_si = _this select 0;
_gi = _this select 1;
_type = _this select 2;
_objects = _this select 3;

_index = count((undoList select _si) select _gi);
((undoList select _si) select _gi) set [_index, [_type,_objects]];
sleep 30;
((undoList select _si) select _gi) set [_index, 0];
