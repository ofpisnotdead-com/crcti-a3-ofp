private["_class", "_entry", "_side", "_flag", "_displayName"];

_class = _this;
_entry = _cfgfile >> _class;

_sideMapping = [siEast, siWest, siRes, siCiv];

_side = getNumber(_entry >> "side");
_side = _sideMapping select _side;
_icon = getText(_entry >> "icon");
_displayName = getText(_entry >> "displayName");

[_class, _side, _icon, _displayName];