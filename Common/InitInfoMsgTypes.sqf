// infoDefs defines info messages

infoDefs = [];

// entry format ["script", "info string 1", "info string 2", ....])
// script "Player\Info"

_type = 0;

mtUnitQueued = _type;
infoDefs set [_type, ["UnitQueued.sqf"] ];
_type = _type + 1;

mtUnitQueueCancel = _type;
infoDefs set [_type, ["UnitQueueCancel.sqf"] ];
_type = _type + 1;

mtUnitQueueCancelFail = _type;
infoDefs set [_type, ["UnitQueueCancelFail.sqf"] ];
_type = _type + 1;

mtUnitBuilding = _type;
infoDefs set [_type, ["UnitBuilding.sqf"] ];
_type = _type + 1;

mtUnitPlaced = _type;
infoDefs set [_type, ["UnitPlaced.sqf"] ];
_type = _type + 1;

mtNoMoneyUnit = _type;
infoDefs set [_type, ["NoMoneyUnit.sqf"] ];
_type = _type + 1;

mtGroupFull = _type;
infoDefs set [_type, ["GroupFull.sqf"] ];
_type = _type + 1;

mtGroupIsAI = _type;
infoDefs set [_type, ["GroupIsAi.sqf"] ];
_type = _type + 1;

mtCommanderChange = _type;
infoDefs set [_type, ["CommanderChange.sqf"] ];
_type = _type + 1;

mtStructRepaired = _type;
infoDefs set [_type, ["StructRepaired.sqf"] ];
_type = _type + 1;

mtStructReady = _type;
infoDefs set [_type, ["StructReady.sqf"] ];
_type = _type + 1;

mtStructDestroyed = _type;
infoDefs set [_type, ["StructDestroyed.sqf"] ];
_type = _type + 1;

mtUpgState = _type;
infoDefs set [_type, ["UpgState.sqf"] ];
_type = _type + 1;

mtStructUndone = _type;
infoDefs set [_type, ["StructUndone.sqf"] ];
_type = _type + 1;

mtMHQDestroyed = _type;
infoDefs set [_type, ["MHQDestroyed.sqf"] ];
_type = _type + 1;

mtWorkerStuck = _type;
infoDefs set [_type, ["WorkerStuck.sqf"] ];
_type = _type + 1;

mtOrderAck = _type;
infoDefs set [_type, ["OrderAck.sqf"] ];
_type = _type + 1;

mtTimeUntilTownWin = _type;
infoDefs set [_type, ["TimeUntilTownWin.sqf"] ];
_type = _type + 1;

mtMHQRepaired = _type;
infoDefs set [_type, ["MHQRepaired.sqf"] ];
_type = _type + 1;

mtScoreMoney = _type;
infoDefs set [_type, ["ScoreMoney.sqf"] ];
_type = _type + 1;

mtTimeLimitRemind = _type;
infoDefs set [_type, ["TimeLimitRemind.sqf"] ];
_type = _type + 1;

mtCommanderTimeout = _type;
infoDefs set [_type, ["CommanderTimeout.sqf"] ];
_type = _type + 1;

mtTownGroupLoss = _type;
infoDefs set [_type, ["TownGroupLoss.sqf"] ];
_type = _type + 1;

mtTimeLimitExtension = _type;
infoDefs set [_type, ["TimeLimitExtension.sqf"] ];
_type = _type + 1;

mtExtensionRequest = _type;
infoDefs set [_type, ["ExtensionRequest.sqf"] ];
_type = _type + 1;

mtVehicleMessage = _type;
infoDefs set [_type, ["VehicleMessage.sqf"] ];
_type = _type + 1;

mtMoneyRequest = _type;
infoDefs set [_type, ["MoneyRequest.sqf"] ];
_type = _type + 1;
