disableSerialization;
_dlg = createDialog "GameInfoDialog";

_back = _this select 0;

lbClear IDC_GI_PARAM;
lbClear IDC_GI_VALUE;

ctrlEnable [IDC_GI_PARAM, false];
ctrlEnable [IDC_GI_VALUE, false];

_ca = ["Off", format["Price %1x", CarsAllowed]] select (CarsAllowed > 0);
_la = ["Off", format["Price %1x", LightArmorAllowed]] select (LightArmorAllowed > 0);
_hw = ["Off", format["Price %1x", HeavyArmorAllowed]] select (HeavyArmorAllowed > 0);
_ah = ["Off", format["Price %1x", AttackChoppersAllowed]] select (AttackChoppersAllowed > 0);
_ap = ["Off", format["Price %1x", AttackPlanesAllowed]] select (AttackPlanesAllowed > 0);
_aa = ["Off", format["Price %1x", AntiAirAllowed]] select (AntiAirAllowed > 0);
_ts = ["Disabled", "Enabled"] select TeamSwitchAllowed;

_art = ["Off", format["Price %1x", ArtyAllowed]] select (ArtyAllowed > 0);
_us = ["Disabled", "Enabled"] select UnitSwitchAllowed;

_tg = format["Maximum %1 Towns", MaxTownGroups];
if ( MaxTownGroups < 0 ) then {_tg = "Disabled";};

_textSP = ["Fixed", "Airfields", "Random", "Near", "Medium", "Far", "Maximum Separation"] select fixedStartPos;

_resp = str(resPatrolGroups);
if (resPatrolGroups == 0 ) then {_resp = "None";};

_timeLimitStr = format["Unlimited"];
if (timeLimit > 0) then {_timeLimitStr = format["%1 Seconds", timeLimit];};
if (timeLimit > 60) then {_timeLimitStr = format["%1 Minutes", timeLimit/60];};
if (timeLimit > 3600) then {_timeLimitStr = format["%1 Hours", timeLimit/3600];};

_terStr = (GridSizeTexts select minTerrainGrid);

_weatherStr = "";
if ( WeatherSetting == -1 ) then {_weatherStr = "Random";};
if ( WeatherSetting == 0 ) then {_weatherStr = "Clear";};
if ( WeatherSetting == 1 ) then {_weatherStr = "Sunny";};
if ( WeatherSetting == 2 ) then {_weatherStr = "Cloudy";};
if ( WeatherSetting == 3 ) then {_weatherStr = "Rainy";};
if ( WeatherSetting == 4 ) then {_weatherStr = "Poor";};
if ( WeatherSetting == 5 ) then {_weatherStr = "Inclement";};
_fogStr = format["%1%2",FogFactor, "%"];

ctrlSetText [IDC_TEXT_MENU_NAME, format["%1 - Game Options", crCTImissionName]];

lbAdd[IDC_GI_PARAM, "AI Skill:"];
lbAdd[IDC_GI_VALUE, format["%1 (Accuracy: %2)", str(AiSkill), str(AiAccuracy)]];

lbAdd[IDC_GI_PARAM, "Resistance Amount:"];
lbAdd[IDC_GI_VALUE, ""];

lbAdd[IDC_GI_PARAM, "Infantry:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountInf]];
lbAdd[IDC_GI_PARAM, "Cars:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountCar]];
lbAdd[IDC_GI_PARAM, "Light Armor:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountApc]];
lbAdd[IDC_GI_PARAM, "Heavy Armor:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountTank]];
lbAdd[IDC_GI_PARAM, "Air:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountAir]];
lbAdd[IDC_GI_PARAM, "Statics:"];
lbAdd[IDC_GI_VALUE, format["%1x", ResistanceAmountStatic]];
lbAdd[IDC_GI_PARAM, "Patrol Groups:"];
lbAdd[IDC_GI_VALUE, format["%1", _resp]];
lbAdd[IDC_GI_PARAM, "Town Groups:"];
lbAdd[IDC_GI_VALUE, format["%1", _tg]];

lbAdd[IDC_GI_PARAM, "Civilians Amount:"];
lbAdd[IDC_GI_VALUE, ""];
lbAdd[IDC_GI_PARAM, "Infantry:"];
lbAdd[IDC_GI_VALUE, format["%1x", CiviliansAmount]];
lbAdd[IDC_GI_PARAM, "Vehicles:"];
lbAdd[IDC_GI_VALUE, format["%1x", CivilianVehiclesAmount]];
lbAdd[IDC_GI_PARAM, "Traffic:"];
lbAdd[IDC_GI_VALUE, format["%1x", CivilianTrafficAmount]];

lbAdd[IDC_GI_PARAM, ""];
lbAdd[IDC_GI_VALUE, ""];

lbAdd[IDC_GI_PARAM, "Max Groupsize:"];
lbAdd[IDC_GI_VALUE, format["%1", maxGroupSize]];
lbAdd[IDC_GI_PARAM, "Side Switching:"];
lbAdd[IDC_GI_VALUE, format["%1", _ts]];
lbAdd[IDC_GI_PARAM, "Unit Switching:"];
lbAdd[IDC_GI_VALUE, format["%1", _us]];
lbAdd[IDC_GI_PARAM, "Startmoney:"];
lbAdd[IDC_GI_VALUE, format["West: %1%2 East: %2%3", startMoneyWest, "$", startMoneyEast, "$"]];
lbAdd[IDC_GI_PARAM, "Time Limit:"];
lbAdd[IDC_GI_VALUE, format["%1", _timeLimitStr]];
lbAdd[IDC_GI_PARAM, "Start Positions:"];
lbAdd[IDC_GI_VALUE, format["%1", _textSP]];
lbAdd[IDC_GI_PARAM, "Max Viewdistance:"];
lbAdd[IDC_GI_VALUE, format["%1m", maxViewDistance]];
lbAdd[IDC_GI_PARAM, "Min Terrain Detail:"];
lbAdd[IDC_GI_VALUE, format["%1", _terStr]];
lbAdd[IDC_GI_PARAM, "Weather:"];
lbAdd[IDC_GI_VALUE, format["%1 (Fog %2)", _weatherStr, _fogStr]];

lbAdd[IDC_GI_PARAM, "Town Values:"];
lbAdd[IDC_GI_VALUE, format["%1", ["Map Defaults", "Adaptive"] select AdaptiveTownValues]];

lbAdd[IDC_GI_PARAM, "Town Income Factor:"];
_tistr = format["%1x", TownIncomeFactor];
if ( IncomeLimit > 0 ) then {_tistr = format["%1 Limit: %2%3", _tistr, IncomeLimit, "$"];};
lbAdd[IDC_GI_VALUE, _tistr];

lbAdd[IDC_GI_PARAM, "Score Money Factor:"];
lbAdd[IDC_GI_VALUE, format["%1x", ScoreMoneyFactor]];
lbAdd[IDC_GI_PARAM, "Death Penalty Factor:"];
lbAdd[IDC_GI_VALUE, format["%1x", DeathPenaltyFactor]];
lbAdd[IDC_GI_PARAM, "Repair/Rearm Cost Factor:"];
lbAdd[IDC_GI_VALUE, format["%1x", RepairRearmCostFactor]];
lbAdd[IDC_GI_PARAM, "Build Times:"];
lbAdd[IDC_GI_VALUE, format["%1x", UnitBuildTimeFactor]];
lbAdd[IDC_GI_PARAM, "Prepare Times:"];
lbAdd[IDC_GI_VALUE, format["%1x", FactoryPrepareTimeFactor]];
lbAdd[IDC_GI_PARAM, "Cars:"];
lbAdd[IDC_GI_VALUE, format["%1", _ca]];
lbAdd[IDC_GI_PARAM, "Light Armor:"];
lbAdd[IDC_GI_VALUE, format["%1", _la]];
lbAdd[IDC_GI_PARAM, "Heavy Armor:"];
lbAdd[IDC_GI_VALUE, format["%1", _hw]];
lbAdd[IDC_GI_PARAM, "Attack Choppers:"];
lbAdd[IDC_GI_VALUE, format["%1", _ah]];
lbAdd[IDC_GI_PARAM, "Attack Planes:"];
lbAdd[IDC_GI_VALUE, format["%1", _ap]];
lbAdd[IDC_GI_PARAM, "Anti Air Units:"];
lbAdd[IDC_GI_VALUE, format["%1", _aa]];
lbAdd[IDC_GI_PARAM, "Artillery:"];
lbAdd[IDC_GI_VALUE, format["%1", _art]];

waituntil {! dialog};

if ( !_back ) then
{
	_spr = [format["Now with 10%1 more love than the next leading CTI!", "%"]];
	_spr = _spr + ["Coded entirely by sock puppets."];
	_spr = _spr + ["[X] <-- Nail here for new monitor."];
	_spr = _spr + ["In doublevision (TM) (where drunk)."];
	_spr = _spr + ["Real men play crCTI.\nGirls play that other Warfare\n(you know which one i mean)."];
	_spr = _spr + ["Chuck Norris plays crCTI KB."];
	_spr = _spr + ["ALL GLORY TO THE HYPNOTOAD!"];
	_spr = _spr + ["Now with flavour!"];
	_spr = _spr + ["Recommended by the\nAssociation of Disappointed Warfare Players (ADWP)"];
	_spr = _spr + ["No Hipsters were hurt in the production of this mission!"];

	_str = format["Modifications by Kastenbier\ntomi@vsbw.de\nhttp://www.vsbw.de/~arma\n\n%1", _spr select floor(random(count(_spr)))];

	titleText [_str, "PLAIN", 1];
	sleep 5;
	titleFadeOut 1;
	sleep 1;
};

enableRadio true;

if ( _back ) then {_nul = [] exec "Player\OpenOptionsMenu.sqs";};