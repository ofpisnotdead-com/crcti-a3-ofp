// Desc: Get config display name of object type
// Result: string
//-----------------------------------------------------------------------------
private["_ObjType", "_dispName", "_classPath", "_class"];

// params
_ObjType = _this select 0; // eg: typeOf obj
//-----------------------------------------------------------------------------
_dispName = _ObjType;
_classPath = configFile >> "cfgVehicles" >> _ObjType;
if (isClass _classPath) then
{
  _class = _classPath >> "displayName"; 
  if (isText _class) then 
  { 
    _dispName = getText _class 
  };
};
//-----------------------------------------------------------------------------
_dispName;
