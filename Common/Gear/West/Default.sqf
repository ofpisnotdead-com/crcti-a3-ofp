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
_player addWeapon "gst_m16a2";
_player addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_player addWeapon "rhs_weap_m72a7";
_player addWeapon "rhsusf_weap_m9";
_player addHandgunItem "rhsusf_mag_15Rnd_9x19_JHP";

comment "Add containers";
_player forceAddUniform "rhs_uniform_bdu_erdl";
_player addVest "rhsgref_TacVest_ERDL";

comment "Add binoculars";
_player addWeapon "rhsusf_bino_m24";

comment "Add items to containers";
_player addItemToUniform "rhs_m136_mag";
for "_i" from 1 to 3 do {_player addItemToUniform "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
_player addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
_player addItemToVest "rhsusf_mag_15Rnd_9x19_JHP";
for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_m67";};
_player addItemToVest "rhs_grenade_anm8_mag";
_player addHeadgear "rhsgref_helmet_pasgt_woodland";

comment "Add items";
_player linkItem "ItemMap";
_player linkItem "ItemCompass";
_player linkItem "ItemWatch";
_player linkItem "ItemRadio";
_player linkItem "ItemGPS";
