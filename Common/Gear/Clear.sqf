params ["_player"];

systemChat "gear cleared";
removeAllPrimaryWeaponItems _player;
removeAllHandgunItems _player;
removeAllWeapons _player;

{ _player unassignItem _x } forEach (assignedItems _player);
removeAllItems _player;

removeBackPack _player;
removeVest _player;
removeHeadgear _player;
removeUniform _player;
removeGoggles _player;
