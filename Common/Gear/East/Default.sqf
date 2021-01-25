params ["_player"];

comment "Remove existing items";
removeAllWeapons _player;
removeAllItems _player;
removeAllAssignedItems _player;
removeUniform _player;
removeVest _player;
removeBackpack _player;
removeHeadgear _player;
removeGoggles _player;

comment "Add weapons";
_player addWeapon "rhs_weap_akm";
_player addPrimaryWeaponItem "rhs_acc_dtkakm";
_player addPrimaryWeaponItem "rhs_30Rnd_762x39mm_bakelite";
_player addWeapon "rhs_weap_rpg75";
_player addWeapon "rhs_weap_makarov_pm";
_player addHandgunItem "rhs_mag_9x18_8_57N181S";

comment "Add containers";
_player forceAddUniform "m68_klmk_coverall";
_player addVest "6B3_RHS_RF";

comment "Add binoculars";
_player addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_player addItemToUniform "rhs_30Rnd_762x39mm_bakelite";};
_player addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_9x18_8_57N181S";};
_player addItemToVest "rhs_30Rnd_762x39mm_bakelite";
_player addHeadgear "ssh68_dark_green";

comment "Add items";
_player linkItem "ItemMap";
_player linkItem "ItemCompass";
_player linkItem "ItemWatch";
_player linkItem "ItemRadio";
_player linkItem "ItemGPS";
