_sec = floor(_this select 1);

_str = _sec call funcSecondsToString;
_text = format["Time limit reached in %1", _str];

[_text, true, false, htTimeLimit, true] call funcHint;
