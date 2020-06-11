
params ["_task", "_center", "_side", "_radius"];


_onClear = format ["['%1', 'Succeeded'] call BIS_fnc_taskSetState; deleteVehicle thisTrigger", _task];
_isClear = createTrigger ["EmptyDetector", _center];
_isClear setTriggerArea [_radius, _radius, 0, false];
_isClear setTriggerTimeout [30, 30, 30, true];
_isClear setTriggerActivation [str _side, "NOT PRESENT", false];
_isClear setTriggerStatements ["this",_onClear,""];
