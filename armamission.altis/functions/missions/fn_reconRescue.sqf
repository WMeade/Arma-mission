params ["_side","_faction"];

_zonePos = [0,0,0];
_crashPos = [0,0,0];

while {_crashPos select 0 == 0 && _crashPos select 1 == 0} do
{
	_zonePos = [nil, ["water","base_radius"]] call BIS_fnc_randomPos;
	sleep 1;
	_crashPos = [_zonePos, 0, 1800, 20, 0, 0.25, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
};

_task = ["reconRescue",_zonePos] call CO_fnc_taskCreator;

_searchZone = [_task,"zone",_zonePos,"ELLIPSE","FDiagonal",format ["Color%1",_side],1,[2000,2000]] call CO_fnc_createMarker;

_wreck = createVehicle ["Land_Wreck_Heli_Attack_01_F",_crashPos,[],5,"NONE"];
systemChat str _crashPos;

_pilotId = [format ["%1_Pilot",_task]];
_group = createGroup [WEST, false];
_group setGroupIdGlobal _pilotId;
_pilot = _group createUnit ["B_HeliPilot_F",(_wreck getRelPos [5,100]),[],2,"NONE"];
_pilot switchMove "AinjPpneMstpSnonWrflDnon";
_pilot disableAI "MOVE";
_pilot setCaptive true;

{_x addCuratorEditableObjects [[_pilot,_wreck]]} forEach allCurators;

[_pilot, "Revive", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa", "_this distance _target <= 3.5", "_caller distance _target <= 3.5", {_caller playAction "medicStart"}, {}, {_caller playAction "medicStop";_target playAction "agonyStop"; _target setCaptive false; _target enableAI "MOVE"; _target disableAI "PATH"; [_this select 0] call CO_fnc_leadAI;}, {_caller switchMove "";}, [], 5, 0, true, false, true] call BIS_fnc_holdActionAdd;


_taskPos = [_crashPos select 0,_crashPos select 1,0];

sleep 1;
_patrols = [["PATROL", 200, "YELLOW", _zonePos, "AWARE", [""], [5, "CIRCLE_L"]], 1, 1500, 12, format ["%1_Patrol",_task], _side, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", 5, selectRandom ["STAG COLUMN","COLUMN","FILE"], true] call CO_fnc_enemyAssault;
sleep 1;
_guards = [["PATROL", 50, "YELLOW", _taskPos, "AWARE", [""], [5, "CIRCLE_L"]], 100, 300, 4, format ["%1_NearPatrol",_task], _side, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", 4, selectRandom ["STAG COLUMN","COLUMN","FILE"], true] call CO_fnc_enemyAssault;

_enemies = _patrols + _guards + [_wreck];

//Fail condition:
_onFail = format ["['%1', 'Failed'] call BIS_fnc_taskSetState;[%2,1500,(thisTrigger getVariable 'garbage'),(thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup;deleteVehicle (thisTrigger getVariable 'otherTrigger'); deleteVehicle thisTrigger; ", _task, _zonePos];
_failed = createTrigger ["EmptyDetector", (getPos _pilot)];
_failed setVariable ["pilot",_pilot];
_failed setVariable ["markers",[_searchZone]];
_failed setTriggerArea [5, 5, getDir base_tent, true, 20];
_failed setTriggerTimeout [5, 5, 5, false];
_failed setTriggerActivation [WEST, "PRESENT", false];
_failed setVariable ["garbage",_enemies];
_failed setTriggerStatements ["!alive (thisTrigger getVariable 'pilot')" ,_onFail,""];

//Sucess condition:
_onClear = format ["['%1', 'Succeeded'] call BIS_fnc_taskSetState;[%2,1500,(thisTrigger getVariable 'garbage'),(thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup;deleteVehicle (thisTrigger getVariable 'pilot');deleteVehicle (thisTrigger getVariable 'otherTrigger'); deleteVehicle thisTrigger; ", _task, _zonePos];
_isClear = createTrigger ["EmptyDetector", (getPos base_tent)];
_isClear setVariable ["pilot",_pilot];
_isClear setVariable ["markers",[_searchZone]];
_isClear setTriggerArea [5, 5, getDir base_tent, true, 20];
_isClear setTriggerTimeout [5, 5, 5, false];
_isClear setTriggerActivation [WEST, "PRESENT", false];
_isClear setVariable ["garbage",_enemies];
_isClear setTriggerStatements ["base_tent distance (thisTrigger getVariable 'pilot') <= 6" ,_onClear,""];

_isClear setVariable ["otherTrigger",_failed];
_failed setVariable ["otherTrigger",_isClear];
