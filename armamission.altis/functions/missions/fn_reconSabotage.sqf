params ["_side","_faction"];

_zonePos = [0,0,0];
_aaPos = [0,0,0];

while {_aaPos select 0 == 0 && _aaPos select 1 == 0} do 
{
	_zonePos = [nil, ["water","base_radius"]] call BIS_fnc_randomPos;
	sleep 1;
	_aaPos = [_zonePos, 0, 2000, 30, 0, 0.25, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
};

_task = ["reconSabotage",_zonePos] call CO_fnc_taskCreator;

_searchZone = [_task,"zone",_zonePos,"ELLIPSE","FDiagonal",format ["Color%1",_side],1,[2500,2500]] call CO_fnc_createMarker;

_aaUnit = createVehicle ["O_SAM_System_04_F",_aaPos,[],5,"NONE"];
createVehicleCrew _aaUnit;
_aaUnit setVehicleReceiveRemoteTargets true;

_radarUnit = createVehicle ["O_Radar_System_02_F",[(_aaPos select 0)+ 10,_aaPos select 1],[],5,"NONE"];
createVehicleCrew _radarUnit;
_radarUnit setVehicleRadar 1;
_radarUnit setVehicleReceiveRemoteTargets true;
_radarUnit setVehicleReportRemoteTargets true;
{_x addCuratorEditableObjects [[_aaUnit,_radarUnit],true];} forEach allCurators;

_taskPos = [_aaPos select 0,_aaPos select 1,0];

sleep 5;
_patrols = [["PATROL", 200, "YELLOW", _zonePos, "AWARE", [""], [5, "CIRCLE_L"]], 1, 2200, 12, format ["%1_Patrol",_task], _side, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", 5, selectRandom ["STAG COLUMN","COLUMN","FILE"], true] call CO_fnc_enemyAssault;
sleep 5;
_guards = [["PATROL", 50, "YELLOW", _taskPos, "AWARE", [""], [5, "CIRCLE_L"]], 1, 100, 3, format ["%1_Guard",_task], _side, _faction, "MEN", "RECON", "AAPLANE", "CAR", 6, selectRandom ["STAG COLUMN","COLUMN","FILE"], true] call CO_fnc_enemyAssault;

_enemies = _patrols + _guards;

_onClear = format ["['%1', 'Succeeded'] call BIS_fnc_taskSetState;[%2,3500,(thisTrigger getVariable 'garbage'),(thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup; deleteVehicle thisTrigger", _task, _zonePos];
_isClear = createTrigger ["EmptyDetector", _taskPos];
_isClear setTriggerArea [250, 250, 0, false];
_isClear setVariable ["aaunits",[_aaUnit,_radarUnit]];
_isClear setTriggerTimeout [10, 10, 10, true];
_isClear setTriggerActivation [str _side, "PRESENT", false];
_isClear setVariable ["markers",[_searchZone]];
_isClear setVariable ["garbage",_enemies];
_isClear setTriggerStatements ["!alive (thisTrigger getVariable 'aaunits' select 0) && !alive (thisTrigger getVariable 'aaunits' select 1)" ,_onClear,""];