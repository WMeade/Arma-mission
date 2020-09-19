params ["_side","_faction"];

_town = call CO_fnc_selectTown;
_townPos = locationPosition _town;
_center = [_townPos select 0, _townPos select 1, 0];

_task = ["townClear",_center] call CO_fnc_taskCreator;
_title = format ["Clear %1", text _town];
_description = format ["<marker name='%2'>%1</marker> has been occupied by enemy forces. The local population has requested our help. Clear <marker name='%2'>%1</marker> of hostile forces!", text _town, _town];
[_task, [_description, _title,""]] call BIS_fnc_taskSetDescription;

_enemies = [];

_patrolCount = 0;
_patrolDistance = 0;
_vehCount = 0;
_vehType  = "CAR";
_buildingCount = 0;

switch type _town do
{
	case "NameVillage": {_patrolCount = 7; _patrolDistance = 50; _vehCount = 1 + random 2; _vehType = "CAR"; _buildingCount = 6};
	case "NameCity": {_patrolCount = 8 + random 2; _patrolDistance = 75; _vehCount = 2 + random 3; _vehType = "CAR"; _buildingCount = 8 + random 3};
	case "NameCityCapital": {_patrolCount = 10 + random 3; _patrolDistance = 100; _vehCount = 3 + random 3; _vehType = "CAR"; _buildingCount = 10+ random 3};
};
_patrols = [["PATROL", _patrolDistance, "YELLOW", _center, "SAFE", [""], [5, "CIRCLE_L"]], 1, 50, _patrolCount, format ["%1_Patrol",_task], _side, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", 6, selectRandom ["STAG COLUMN","COLUMN","FILE"], true] call CO_fnc_enemyAssault;

_vehPatrols = [["PATROL", _patrolDistance * 2, "YELLOW", _center, "SAFE", [""], [5, "CIRCLE_L"]], 5, 150, _vehCount, format ["%1_Car",_task], _side, _faction, "GROUND", "STANDARD", "AAPLANE", "CAR", 1, "COLUMN", false] call CO_fnc_enemyAssault;

_enemies = _patrols + _vehPatrols;

_townZone = [_task,"zone",_center,"ELLIPSE","FDiagonal",format ["Color%1",_side],1,[150,150]] call CO_fnc_createMarker;
_allBuildings = nearestObjects [_center, ["House","Building"],150];
_possibleBuildings = [];
{
	_positions = _x buildingPos -1;
	_posCount = count _positions;
	if (_posCount >=4) then {_possibleBuildings append [_x]};
} forEach _allBuildings;

if (count _possibleBuildings < _buildingCount) then {_buildingCount = count _possibleBuildings};

for "_i" from 1 to _buildingCount do
{
	_building = selectRandom _possibleBuildings;
	_possibleBuildings = _possibleBuildings - [_building];
	_garrison = [_building,_side, format ["%1_Garrison_%2",_task,_i], 6, _faction, "STANDARD"] call CO_fnc_garrisonBuilding;
	_enemies = _enemies + _garrison;
};

if (type _town == "NameCity" or type _town == "NameCityCapital") then
{
	_airCount = 1;
	if (_airCount >= 1 && _faction == "OPF_F") then {
		_airPatrols = [["PATROL", 400, "YELLOW", _center, "SAFE", [""], [150, "CIRCLE_L"]], 5, 200, 1, format ["%1_CAS",_task], EAST, "OPF_F", "AIR", "STANDARD", "CASHELI", "CAR", 1, "COLUMN", true] call CO_fnc_enemyAssault;
	};
	_armorPatrols = [["PATROL", 150, "YELLOW", _center, "SAFE", [""], [150, "CIRCLE_L"]], 5, 300, 2 + random 2, format ["%1_Armor",_task], _side, _faction, "GROUND", "STANDARD", "CASHELI", selectRandom ["APC","TANK"], 1 + random 2, "COLUMN", true] call CO_fnc_enemyAssault;
	_enemies = _enemies + _armorPatrols
};



{_x addCuratorEditableObjects [_enemies,true];} forEach allCurators;

_completionTreshold = round (count _enemies * 0.1);

_onClear = format ["['%1', 'Succeeded'] call BIS_fnc_taskSetState;[%2,1500,(thisTrigger getVariable 'garbage'),(thisTrigger getVariable 'markers')] spawn CO_fnc_cleanup; deleteVehicle thisTrigger", _task, _center];
_isClear = createTrigger ["EmptyDetector", _center];
_isClear setTriggerArea [250, 250, 0, false];
_isClear setVariable ["markers",[_townZone]];
_isClear setVariable ["garbage",_enemies];
_isClear setTriggerTimeout [10, 10, 10, true];
_isClear setTriggerActivation [str _side, "PRESENT", false];
_isClear setVariable ["trash", _enemies, false];
_isClear setTriggerStatements [format ["count thisList < %1",_completionTreshold],_onClear,""];
