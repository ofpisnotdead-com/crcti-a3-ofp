_ext = _this select 1;
_text = format["Time limit extended by %1 minutes.", round(_ext/60)];
[_text, false, false, htTimeLimitExtend, true] call funcHint;
