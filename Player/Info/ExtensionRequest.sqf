_si = _this select 1;
_ext = _this select 2;
_text = format["%1 wants to extend the time limit by %2 minutes.", sideNames select _si, round(_ext/60)];
[_text, false, true, htExtensionRequest, true] call funcHint;
