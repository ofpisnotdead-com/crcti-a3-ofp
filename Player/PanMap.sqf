// Desc: Pan map between 2 positions
//-----------------------------------------------------------------------------
private["_IDD_display", "_IDC_Map", "_startPos1", "_endPos2"];
private["_panZoom", "_panDuration", "_finalZoom", "_finalDuration", "_display", "_ctrl"];

// params
_IDD_display = _this select 0;
_IDC_Map = _this select 1;
_startPos1 = _this select 2;
_endPos2 = _this select 3;
//-----------------------------------------------------------------------------
_panZoom = 1.00;
_panDuration = 1.2;
_finalZoom = -1; //0.30;
_finalDuration = 0.2;

if (count _this > 4) then
{
  _panZoom = _this select 4; // -1=ignore basePos
  _panDuration = _this select 5;
  _finalZoom = _this select 6; // -1=use current zoom. 0.05=zoom in max
  _finalDuration = _this select 7;
};

_display = findDisplay _IDD_display;
_ctrl = _display displayctrl _IDC_Map;

//if (_panZoom == -1) then {_panZoom = ctrlMapScale _ctrl};
if (_finalZoom == -1) then {_finalZoom = ctrlMapScale _ctrl};

ctrlMapAnimClear _ctrl; // stops previous panning

// [duration, zoom, pos]
if (_panZoom != -1) 
then { _ctrl ctrlMapAnimAdd [0.0, _panZoom, _startPos1] } // show first pos 
else { _panZoom = _finalZoom };

_ctrl ctrlMapAnimAdd [_panDuration, _panZoom, _endPos2]; // show second pos
_ctrl ctrlMapAnimAdd [_finalDuration, _finalZoom, _endPos2]; // zoom second pos
ctrlMapAnimCommit _ctrl;
