params ["_side","_faction"];

_town = call CO_fnc_selectTown;
_townPos = locationPosition _town;
_center = [_townPos select 0, _townPos select 1, 0];

_task = ["townDefend",_center] call CO_fnc_taskCreator;
_title = format ["Go to %1", text _town];
_description = format ["We have received intel that hostile forces are preparing to attack <marker name='%2'>%1</marker>. Go to the <marker name='%2'>%1</marker> and prepare to defend it!", text _town, _town];
[_task, [_description, _title,""]] call BIS_fnc_taskSetDescription;
[_task, 'Created'] call BIS_fnc_taskSetState;


_waveCount = 0;
_waveDistance = 0;
_waveSize = 0;
_radius  = 0;

switch type _town do
{
	case "NameVillage": {_waveCount = 3; _waveDistance = 350; _waveSize = 5;_radius = 150;};
	case "NameCity": {_waveCount = 4 + random 1; _waveDistance = 500; _waveSize = 6;_radius = 250;};
	case "NameCityCapital": {_waveCount = 5 + random 2; _waveDistance = 750; _waveSize = 7;_radius = 450;};
};

_townZone = [_task,"zone",_center,"ELLIPSE","FDiagonal","ColorWEST",1,[_radius,_radius]] call CO_fnc_createMarker;

waitUntil{_center distance2D ([_center] call CO_fnc_nearestPlayer) <= _radius};
sleep 30;

_title = format ["Defend %1", text _town];
_description = format ["The enemy attack on %1 has begun. Stay in %1 and defend it!", text _town];
[_task, [_description, _title,""]] call BIS_fnc_taskSetDescription;
[_task, 'Created'] call BIS_fnc_taskSetState;


_isFailed = createTrigger ["EmptyDetector", _center];
_isFailed setTriggerArea [250, 250, 0, false];
_isFailed setTriggerTimeout [15, 15, 15, true];
_isFailed setTriggerActivation ["WEST", "NOT PRESENT", false];
_isFailed setTriggerStatements ["this",format ["['%1', 'Failed'] call BIS_fnc_taskSetState; deleteVehicle thisTrigger", _task],""];

private _enemies = [];
private _wave = [];
_i = 0;
while {_i < _waveCount} do
{
	if ((_task call BIS_fnc_taskState) == "FAILED") exitWith {};
	_groupName = format ["%1_%2_ATTACKER", _task, _i];
	_minDistance = _waveDistance - 50;
	_maxDistance = _waveDistance + 50;
	if (random 100 <= 25) then {_wave = [["SAD",10, "YELLOW", _center, "AWARE", [""], [5, "CIRCLE_L"]], _minDistance, _maxDistance, 2, _groupName, _side, _faction, "GROUND", "STANDARD", "AAPLANE", selectRandom ["CAR","APC"], 1 + round random 1, selectRandom ["COLUMN","LINE"], false] call CO_fnc_enemyAssault;} else {
	_wave = [["SAD",10, "YELLOW", _center, "AWARE", [""], [5, "CIRCLE_L"]], _minDistance, _maxDistance, _waveSize, _groupName, _side, _faction, "MEN", selectRandom ["STANDARD","RECON"], "AAPLANE", "CAR", 4 + round random 2, selectRandom ["STAG COLUMN","WEDGE","LINE","VEE"], false] call CO_fnc_enemyAssault;};
	_i = _i + 1;
	_enemies = _enemies + _wave;
	sleep 180;
};
if ((_task call BIS_fnc_taskState) != "FAILED") then {
	_title = format ["Clear %1", text _town];
	_description = format ["The enemy attack on %1 is almost over. Clear %1 of the remaining attackers!", text _town];
	[_task, [_description, _title,""]] call BIS_fnc_taskSetDescription;
	[_task, 'Created'] call BIS_fnc_taskSetState;
};

_onClear = format ["['%1', 'Succeeded'] call BIS_fnc_taskSetState;[%2,%3,(thisTrigger getVariable 'garbage'), (thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup; deleteVehicle thisTrigger", _task, _center, _waveDistance + 100];
_condition = "count thisList < 10";
_isClear = createTrigger ["EmptyDetector", _center];
_isClear setTriggerArea [250, 250, 0, false];
_isClear setVariable ["markers",[_townZone]];
_isClear setVariable ["garbage",_enemies];
_isClear setTriggerTimeout [10, 10, 10, true];
if ((_task call BIS_fnc_taskState) == "FAILED") then {_onClear = format ["[%1,%2,400,[],(thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup; deleteVehicle thisTrigger", _center, _cleanup]; _condition = "true"};
_isClear setTriggerActivation [str _side, "PRESENT", false];
_isClear setTriggerStatements [_condition,_onClear,""];
