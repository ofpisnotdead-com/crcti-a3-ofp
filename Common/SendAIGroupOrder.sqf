// args: [si, gi, orderType, params]
private["_si", "_gi", "_type", "_params", "_par0", "_par1", "_par2"];

_si = _this select 0;
_gi = _this select 1;
_type = _this select 2;
_params = _this select 3;

_par0 = 0;
if ((count _params) > 0) then
{
	_par0 = _params select 0;
};

_par1 = 0;
if ((count _params) > 1) then
{
	_par1 = _params select 1;
};

_par2 = 0;
if ((count _params) > 2) then
{
	_par2 = _params select 2;
};


pvOrder = [_si, _gi, _type, _par0, _par1, _par2];
_nul = [pvOrder] spawn MsgAIGroupOrder;
publicVariable "pvOrder";

