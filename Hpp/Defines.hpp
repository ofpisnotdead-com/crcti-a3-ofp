// Fonts
#define FontS "TahomaB"
#define FontM "TahomaB"

#define FontHTML "courierNewB64"
#define FontHTMLBold "courierNewB64"
#define FontMAP "courierNewB64"
#define FontMAIN "SteelfishB64"
#define FontMAINCZ "SteelfishB64CE"
#define FontTITLE "SteelfishB128"
#define FontTITLEHalf "SteelfishB64"
#define FontBOOK "garamond64"
#define FontNOTES "AudreysHandI48"
#define FontSize 0.025
#define TitleFontSize 0.04

#define DEFAULTFONT "PuristaBold"
#define SMALLFONT "Garamond64"
#define VERYSMALLFONT "SteelfishB64"
#define BOLDFONT "TahomaB48"

// Control types
#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_TOOLBOX 6
#define CT_CHECKBOXES 7
#define CT_PROGRESS 8
#define CT_HTML 9
#define CT_STATIC_SKEW 10
#define CT_ACTIVETEXT 11
#define CT_TREE 12
#define CT_3DSTATIC 20
#define CT_3DACTIVETEXT 21
#define CT_3DLISTBOX 22
#define CT_3DHTML 23
#define CT_3DSLIDER 24
#define CT_3DEDIT 25
#define CT_OBJECT 80
#define CT_OBJECT_ZOOM 81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER 99
#define CT_MAP 100
#define CT_MAP_MAIN 101

// Static styles
#define ST_HPOS 0x0F
#define ST_LEFT 0
#define ST_RIGHT 1
#define ST_CENTER 2
#define ST_UP 3
#define ST_DOWN 4
#define ST_VCENTER 5

#define ST_TYPE 0xF0
#define ST_SINGLE 0
#define ST_MULTI 16
#define ST_TITLE_BAR 32
#define ST_PICTURE 48
#define ST_FRAME 64
#define ST_BACKGROUND 80
#define ST_GROUP_BOX 96
#define ST_GROUP_BOX2 112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE 144
#define ST_WITH_RECT 160
#define ST_LINE 176

#define ST_SHADOW 256
#define ST_NO_RECT 512

#define ST_TITLE ST_TITLE_BAR + ST_CENTER

// Predefined controls
#define IDC_OK 1
#define IDC_CANCEL 2

// Colors
#define BG_Transparency 0.8
#define BG_Field_Transparency 0.8 /*-0.3*/

#define COLOR_MENU_BG {0.48, 0.5, 0.35,BG_Transparency}
#define COLOR_BTN_BG {0.8,0.8,0.8,BG_Transparency}
#define COLOR_BTN_TEXT {0,0,0,1}
#define COLOR_TITLE_BG {0.45,0,0,BG_Transparency}
#define COLOR_TITLE_TEXT {1,1,1,1}
#define COLOR_LABEL_TEXT {0.8,0.8,0.0,1}
#define COLOR_DATA_BG {0.7,0.7,0.7,BG_Field_Transparency}
#define COLOR_DATA_TEXT {1,1,1,1}
#define COLOR_SELECTED_BG {0.2,0.2,0.2,BG_Field_Transparency}
#define COLOR_SELECTED_TEXT {1,1,0.2,1}
#define COLOR_CLICKABLE_BG {0.7,0.7,0.7,BG_Field_Transparency }
#define COLOR_LB_TEXT {0.0,0.0,0.0,1}

// new added for ArmA

#define Color_White {1, 1, 1, 1}
#define Color_Black {0, 0, 0, 1}
#define Color_Gray {0.3, 0.3, 0.3, 1}
#define Color_GrayLight {0.6, 0.6, 0.6, 1}
#define Color_GrayDark {0.2, 0.2, 0.2, 1}
#define Color_Orange {1, 0.5, 0, 1}
#define Color_Main_Foreground1Color_White
#define Color_Text_Default Color_Main_Foreground1

#define CA_colordark {0, 0, 0, 1}
#define CA_buttoff {1, 1, 1, 0.7}
#define CA_button {1, 1, 1, 1}
#define CA_textoff {1, 1, 1, 0.7}
#define CA_texton {1, 1, 1, 1}
#define CA_Redtextoff {0.25, 0, 0, 0.7}
#define CA_Redtexton {0.7, 0, 0, 1}
#define CA_UI_element_background {1, 1, 1, 0.7}
#define CA_UI_background {0.6, 0.6, 0.6, 0.4}
#define CA_UI_help_background {0.2, 0.1, 0.1, 0.7}
#define CA_UI_green{0.84,1,0.55,1}
#define CA_UI_grey{0.4,0.4,0.4,1}
#define CA_UI_transparent{1,1,1,0}

#define Color_WhiteDark {1, 1, 1, 0.5}
#define Color_White{1, 1, 1, 1}
#define Color_Black {0, 0, 0, 1}
#define Color_Gray {1, 1, 1, 0.5}
#define Color_DarkRed {0.5, 0.1, 0, 0.5}
#define Color_Green {0.8, 0.9, 0.4, 1}

#define Color_MainBack {1, 1, 1, 0.9} //hlavni pozadi
#define Color_Back {0.1, 0.1, 0.1, 0.4} // okraj pro obrazek
#define Color_BackList {0.2, 0.2, 0.2, 0.2} //back v seznamu
#define Color_MainBackFull {0.63, 0.65, 0.61, 1} //v editoru

// Control IDs
#define IDC 200

#define IDC_UNDEFINED 0
#define IDC_DEFAULT 9999

#define IDC_BTN 150
#define IDC_LB 170

#define IDC_TEXT_MENU_NAME 300
#define IDC_TEXT_MENU_STATUS 301
#define IDC_TEXT_PLAYER_MONEY 302
#define IDC_CB_GROUPS 303
#define IDC_TEXT_GROUP_SIZE 304
#define IDC_TEXT_GROUP_MONEY 305
#define IDC_BTN_BUY 306
#define IDC_BTN_BUY_MANNED 307
#define IDC_TEXT_LIST1_INFO 308
#define IDC_TEXT_LIST2_INFO 309
#define IDC_TEXT_LIST3_INFO 310
#define IDC_LB_LIST1 311
#define IDC_LB_LIST2 312
#define IDC_LB_LIST3 313
#define IDC_BTN_BUY_BG 314
#define IDC_BTN_BUY_MANNED_BG 315
#define IDC_BTN_CANCEL 12315

#define IDC_BTN_BUILD 316
#define IDC_BTN_BUILD_BG 317
#define IDC_TEXT_WORKERS 318
#define IDC_BTN_UNDO 319
#define IDC_BTN_UNDO_BG 320
#define IDC_BTN_ALIGN 321
#define IDC_BTN_FLOAT 322
#define IDC_Build_Picture 323
#define IDC_Buy_Picture 324
#define IDC_LABEL_WORKERS 325

#define IDC_TEXT_RESPAWN_TYPE 330
#define IDC_TEXT_RESPAWN_POS 331
#define IDC_BTN_RESPAWN_MHQ 332
#define IDC_TEXT_RESPAWN_MHQ 333
#define IDC_BTN_RESPAWN_STRUCT 334
#define IDC_CB_RESPAWN_STRUCT 344

#define IDC_BTN_DRIVER 345
#define IDC_BTN_GUNNER 346
#define IDC_BTN_COMMANDER 347

#define IDC_TEXT_PASSENGER_COUNT 1347

#define IDC_BG_DRIVER_SELECTED 348
#define IDC_BG_GUNNER_SELECTED 349
#define IDC_BG_COMMANDER_SELECTED 350

#define IDC_BG_LIST2 351
#define IDC_BG_LIST3 352

#define IDC_TEXT_STRUCT_INFO 353

#define IDC_LB_PRIM 354
#define IDC_LB_PRIM_AMMO 355
#define IDC_LB_SEC 356
#define IDC_LB_SEC_AMMO 357
#define IDC_LB_CURRENT 358
#define IDC_LB_CLOTHES 359

#define IDC_LB_HG 360
#define IDC_LB_HG_AMMO 361
#define IDC_LB_EQ 366
#define IDC_EquiInfo 367
#define IDC_REMOVE_CURRENT 368
#define IDC_REMOVE_CURRENT_ALL 369

#define IDC_EQUIP_TYPELABEL 1370
#define IDC_BTN_PRIM 1371
#define IDC_BTN_PRIM_AMMO 1372
#define IDC_BTN_HG 1373
#define IDC_BTN_HG_AMMO 1374
#define IDC_BTN_CLOTHES 1375
#define IDC_BTN_SEC 1376
#define IDC_BTN_SEC_AMMO 1377
#define IDC_BTN_EQUIPMENT 1378

#define IDC_BTN_PRIMARY_TAB 1380
#define IDC_BTN_SECONDARY_TAB 1381
#define IDC_BTN_HANDGUN_TAB 1382
#define IDC_BTN_EQUIPMENT_TAB 1383
#define IDC_BTN_CLOTHES_TAB 1384


#define IDC_LB_TEMPLATES 461

#define IDC_TEXT_DESTRUCT_TYPE 370
#define IDC_TEXT_DESTRUCT_POS 371
#define IDC_BTN_DESTRUCT_MHQ 372
#define IDC_TEXT_DESTRUCT_MHQ 373
#define IDC_BTN_DESTRUCT_STRUCT 374
#define IDC_CB_DESTRUCT_STRUCT 384

// options dialog
#define IDC_TEXT_MONEY 500
#define IDC_TEXT_SCORE 501
#define IDC_LB_UNITS 502
#define IDC_LB_TRANSFER_TARGET 503
#define IDC_LB_TRANSFER_AMOUNT 504
#define IDC_CB_PLAYERINCOME 505
#define IDC_CB_AIRESPAWN 506
#define IDC_LB_UPGRADES 507
#define IDC_TEXT_TOWNS 508
#define IDC_BTN_UPGRADE 509
#define IDC_TEXT_INCOME 510
#define IDC_BTN_COMMANDAI 511
#define IDC_BTN_VEHICLEACTIONS 512
#define IDC_CB_AIMARKERS 513
#define IDC_BTN_COMMANDERTRANSFER 514
#define IDC_CB_COMMANDER 515
#define IDC_CB_REPORTS 516
#define IDC_BTN_TRANSFER_MONEY 517
#define IDC_TEXT_FPS 518
#define IDC_TEXT_PLAYERVD 519
#define IDC_TEXT_SERVERVD 520
#define IDC_TEXT_VD 521
#define IDC_TEXT_GRIDSIZE 522
#define IDC_BTN_SURRENDER 523
#define IDC_BTN_EXTENSION 524
#define IDC_BTN_DESTRUCTION 525
#define IDC_BTN_EXTENSION2 526
#define IDC_BTN_REQUEST_MONEY 527
#define IDC_BTN_CLEAN 528
#define IDC_BTN_KILL 529
#define IDC_BTN_DEBUGSTATS 530

// leaderboard dialog
#define IDC_LB_GROUP 600
#define IDC_LB_INFANTRY 601
#define IDC_LB_VEHICLE 602
#define IDC_LB_MHQ 603
#define IDC_LB_STRUCT 604
#define IDC_LB_TOWN 605
#define IDC_LB_TOTAL 606
#define IDC_LB_SIDE 607
#define IDC_LB_INFANTRYSIDE 608
#define IDC_LB_VEHICLESIDE 609
#define IDC_LB_MHQSIDE 610
#define IDC_LB_STRUCTSIDE 611
#define IDC_LB_TOWNSIDE 612
#define IDC_LB_TOTALSIDE 613

// stats dialog
#define IDC_TEXT_MONEYWEST 700
#define IDC_LB_STRUCTSWEST 701
#define IDC_LB_UNITSWEST 702
#define IDC_TEXT_MONEYEAST 703
#define IDC_LB_STRUCTSEAST 704
#define IDC_LB_UNITSEAST 705

// nearby vehicles dialog
#define IDC_BTN_ACTION 800
#define IDC_LB_VEHICLES 801

// cam dialogs: spectator, unit cam, sat cam
#define IDC_BTN_SHOWLOG 900
#define IDC_LB_LOG 901
#define IDC_BTN_SHOWGROUPS 902
#define IDC_LB_GROUPLEADERS 903
#define IDC_LB_GROUPMEMBERS 904
#define IDC_SL_ANGLEVERT 905
#define IDC_SL_DISTANCE 906
#define IDC_SL_ANGLEHORZ 907
#define IDC_BG_LOG 908
#define IDC_BG_GROUPS 909
#define IDC_BTN_LOCKDIR 910
#define IDC_BTN_SHOWALL 911
#define IDC_TEXT_TRACKING 912
#define IDC_BTN_LEFT 913
#define IDC_BTN_RIGHT 914
#define IDC_BTN_REAR 915
#define IDC_BTN_FRONT 916
#define IDC_BTN_NEAR 917
#define IDC_BTN_FAR 918
#define IDC_TEXT_GAMETIME 919
#define IDC_BTN_TOP 920
#define IDC_BTN_SHOWMAP 921
#define IDC_BTN_TRACK 922
#define IDC_TEXT_MAPPOS 923
#define IDC_BTN_NORTH 924
#define IDC_BTN_SOUTH 925
#define IDC_BTN_WEST 926
#define IDC_BTN_EAST 927
#define IDC_BTN_LEADERBOARD 928
#define IDC_BTN_STATS 929
#define IDC_TEXT_TRACKINGBOTTOM 930
#define IDC_TEXT_GAMETIMEBOTTOM 931
#define IDC_BTN_DISB 932
#define IDC_BTN_SWITCH 933
#define IDC_INFO 934
#define IDC_BTN_SHOWINFO 935
#define IDC_BTN_DISBGROUP 936
#define IDC_BTN_TOGGLENV 937

// command ai dialog
#define IDC_LB_GROUPORDERS 1000
#define IDC_BTN_SENDORDER 1001
#define IDC_TEXT_ORDER 1002
#define IDC_CB_ORDER 1003
#define IDC_TEXT_PARAM0LABEL 1004
#define IDC_CB_PARAM0 1005
#define IDC_TEXT_PARAM1LABEL 1006
#define IDC_CB_PARAM1 1007
#define IDC_CommandAI_Map 1008
#define IDD_CommandAI 2000

// flight altitude dialog
#define IDC_LB_ALTITUDES 1100

// GameInfo Dialog
#define IDC_GI_PARAM 1200
#define IDC_GI_VALUE 1201

// Debug Dialog
#define IDC_DBG_VALUE 1401

// Faction selection Dialog
#define IDC_LB_AVAILABLE_FACTIONS 1601
#define IDC_LB_SELECTED_FACTIONS 1602
#define IDC_LB_RESULT_FACTIONS 1603
#define IDC_BTN_ADD_FACTION 1604
#define IDC_BTN_DEL_FACTION 1605
#define IDC_FACTION_TIMER 1606
#define IDC_FACTION_SELECTION_FINISHED 1607

// Dialog IDDs
#define IDD_RespawnMenu 8000
#define IDD_FactoryMenu 8001
#define IDD_BuildMenu 8002
#define IDD_StatsDialog 8003
#define IDD_EquipmentMenu 8004
#define IDD_LeaderboardDialog 8006
#define IDD_OptionsDialog 8007
#define IDD_UnitCamDialog 8009
#define IDD_SatCamDialog 8010
#define IDD_CommandAIDialog 8011
#define IDD_SetFlightAltitudeDialog 8012
#define IDD_GameOverDialog 8014
#define IDD_DestructMenu 8015
#define IDD_NearbyVehiclesDialog 8016
#define IDD_GameInfoDialog 8017
#define IDD_DebugStatsDialog 8018
#define IDD_FactionsDialog 8019

