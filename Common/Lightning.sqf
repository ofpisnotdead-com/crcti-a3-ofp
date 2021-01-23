private ["_pos", "_bolt", "_lightning", "_class"];

_pos = _this;

_bolt = objNull;
_lightning = objNull;

if ( isServer ) then
{
	_bolt = createVehicle ["LightningBolt",_pos,[],0,"CAN_COLLIDE"];
	_bolt setposatl _pos;
	_bolt setdamage 1;
}
else
{
	_class = ["lightning1_F","lightning2_F"] call bis_Fnc_selectrandom;
	_lightning = _class createvehiclelocal [100,100,100];
	_lightning setdir (random 360);
	_lightning setpos _pos;
};

sleep 0.5 + random(1.5);

deleteVehicle _bolt;
deleteVehicle _lightning;
