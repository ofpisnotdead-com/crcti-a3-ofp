// args: [vehicle]

_crate = _this select 0;

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;

_crate AddWeaponCargoGlobal ["hgun_ACPC2_F", 1];
_crate AddWeaponCargoGlobal ["hgun_PDW2000_Holo_F", 1];
_crate AddWeaponCargoGlobal ["srifle_EBR_MRCO_pointer_F", 1];
_crate AddWeaponCargoGlobal ["arifle_TRG20_ACO_F", 1];
_crate AddWeaponCargoGlobal ["arifle_TRG21_MRCO_F", 1];
_crate AddWeaponCargoGlobal ["arifle_TRG21_GL_MRCO_F", 1];
_crate AddWeaponCargoGlobal ["arifle_Mk20C_ACO_pointer_F", 1];
_crate AddWeaponCargoGlobal ["arifle_Mk20_ACO_pointer_F", 1];
_crate AddWeaponCargoGlobal ["arifle_Mk20_GL_MRCO_pointer_F", 1];
_crate AddWeaponCargoGlobal ["arifle_SDAR_F", 1];
_crate AddWeaponCargoGlobal ["LMG_Mk200_F", 1];
_crate AddWeaponCargoGlobal ["srifle_GM6_LRPS_F", 1];
_crate AddWeaponCargoGlobal ["launch_NLAW_F", 2];
_crate AddWeaponCargoGlobal ["launch_RPG32_F", 2];


_crate AddMagazineCargoGlobal ["9Rnd_45ACP_Mag", 12];
_crate AddMagazineCargoGlobal ["30Rnd_9x21_Mag", 12];
_crate AddMagazineCargoGlobal ["20Rnd_762x51_Mag", 12];
_crate AddMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
_crate AddMagazineCargoGlobal ["200Rnd_65x39_cased_Box", 8];
_crate AddMagazineCargoGlobal ["5Rnd_127x108_Mag", 12];
_crate AddMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 8];
_crate AddMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell", 8];
_crate AddMagazineCargoGlobal ["NLAW_F", 4];
_crate AddMagazineCargoGlobal ["RPG32_F", 4];
_crate AddMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 5];

_crate AddItemCargoGlobal ["FirstAidKit", 4];
_crate AddItemCargoGlobal ["acc_flashlight", 4];