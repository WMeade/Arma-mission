params ["_enemySide", "_faction"];
/* Created by Broken_Algorithm on the 08/04/2020. Arma 3 version 1.96 */
_enemies = [];
_selectableLocations = [];
_locations = [];
switch _enemySide do {
    case east:{
      _locations = nearestLocations [getPos player, ["NameLocal"], 25000];
      {
        if (text _x in ["military", "factory"]) then {
           _selectableLocations append [_x];
        };
      } forEach _locations;
      _selectableLocations append nearestLocations [getPos player, ["NameCityCapital", "NameCity"], 25000];
    };
    case resistance:{
         _selectableLocations = nearestLocations [getPos player, ["NameVillage", "NameCity"], 25000];
    };
};
_cacheArea = selectRandom _selectableLocations;

while {(getPos _cacheArea) distance2D markerPos "base_radius" < 2000} do {
   _cacheArea = selectRandom _selectableLocations;
};

_buildings = nearestObjects [getPos _cacheArea, ["House", "Building"], 700];
_buildingsThreePositions = [];
{_positions = _x buildingPos - 1; _positionCount = count _positions; if (_positionCount >= 3) then {_buildingsThreePositions append [_x];};} forEach _buildings;
while {count _buildingsThreePositions == 0} do {
  _cacheArea = selectRandom _selectableLocations;
  while {(getPos _cacheArea) distance2D markerPos "base_radius" < 2000} do {
     _cacheArea = selectRandom _selectableLocations;
  };
  _buildings = nearestObjects [getPos _cacheArea, ["House", "Building"], 700];
  {_positions = _x buildingPos - 1; _positionCount = count _positions; if (_positionCount >= 3) then {_buildingsThreePositions append [_x];};} forEach _buildings;
};

_cacheBuilding = selectRandom _buildingsThreePositions;

_SabotageTask = ["sabotageInfantry", getPos _cacheBuilding] call CO_fnc_taskCreator;

_groupIterator = 0;
_patrolAmount = selectRandom [4, 5, 6, 7];
_amountInPatrol = selectRandom [3, 4, 5, 6];
_buildings =  nearestObjects [getPos _cacheBuilding, ["House", "Building"], 100];
_buildings deleteAt (_buildings find _cacheBuilding);
{_enemies_one = [getPos _x, _enemySide, format ["garrisonedGroup_%1_%2", _SabotageTask, _groupIterator], selectRandom [0, 1, 2, 3, 4, 5 ,6, 7], _faction, "STANDARD"] call CO_fnc_garrisonBuilding; _buildings deleteAt (_buildings find _x); _enemies append _enemies_one; _enemies append _enemies_one;} forEach _buildings;
_enemies_two = [["PATROL", selectRandom [50, 80, 125, 250], "YELLOW", getPos _cacheBuilding, "SAFE", [""], [""]], 50, 250, _patrolAmount, "patrolGroup_" + _SabotageTask, _enemySide, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", _amountInPatrol,"STAG COLUMN",true] call CO_fnc_enemyAssault;
_enemies_three = [getPos _cacheBuilding, _enemySide, format ["garrisonedGroupInCache_%1_%2", _SabotageTask, _groupIterator], selectRandom [3, 4, 5], _faction, "STANDARD",true] call CO_fnc_garrisonBuilding;
_enemies append _enemies_two;
_enemies append _enemies_three;
_groupIterator = _groupIterator + 1;

_supplyCrate =  createVehicle ["O_supplyCrate_F",[4499.65,20935.4,0], [], 0, "NONE"];
_supplyCrate enableSimulation false;
_supplyCrate setPos (_cacheBuilding buildingPos 1);
_supplyCrate setVehicleVarName format ["supplyCrate_%1", _SabotageTask];
_supplyCrate setVariable ["taskID", [_SabotageTask]];
_supplyCrate setVariable ["crateId", [_supplyCrate]];
_supplyCrate setVariable ["side", [_enemySide]];
_supplyCrate setVariable ["faction", [_faction]];
_supplyCrate setVariable ["_enemies", [_enemies]];
_supplyCrate setVariable ["position2D", [getPos _cacheArea]];
{_x addCuratorEditableObjects [[_supplyCrate]]} forEach allCurators;
_EHsupplyCarte = _supplyCrate addMPEventHandler ['MPkilled', {_taskID = ((_this select 0) getVariable "taskID") select 0; [_taskID, 'Succeeded'] call BIS_fnc_taskSetState}];

[_supplyCrate,
 "Sabotage",
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",
 "_this distance _target < 3",
 "_caller distance _target < 3",
 {},
 {},
 {
   _side =  ((_this select 0) getVariable "side") select 0;
   _factionre = ((_this select 0) getVariable "faction") select 0;
   _taskID = ((_this select 0) getVariable "taskID") select 0;
   _enemieseh = ((_this select 0) getVariable "_enemies") select 0;
   _position2D = ((_this select 0) getVariable "position2D") select 0;
   _crateID = ((_this select 0) getVariable "crateId") select 0;
   _crateID enableSimulation true;
   _crateID setDamage 1;
   _randomChanceReinforments = selectRandom [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
   if(_randomChanceReinforments <= 5) then {
      _enemieseh_one = [["SAD", 150, "YELLOW", player, "AWARE", [""], [""]], 500, 700, selectRandom [2, 3], "ReinforcementGroup_" +  _taskID, _side, _factionre, "MEN", "STANDARD", "AAPLANE", "CAR", 6,"STAG COLUMN",false] call CO_fnc_enemyAssault;
      _enemieseh_two = [["SAD", 150, "YELLOW", player, "AWARE", [""], [""]], 700, 1500, selectRandom [2, 3], "ReinforcementGroup_" +  _taskID, _side, _factionre, "GROUND", "STANDARD", "AAPLANE", "CAR", 1,"STAG COLUMN",false] call CO_fnc_enemyAssault;
      _enemieseh append _enemieseh_one;
      _enemieseh append _enemieseh_two;
      hint "Enemy reinforcements inbound";
   };
   [_position2D, 1500, _enemieseh, []] call CO_fnc_cleanup;
 },
 {},
 [],
 10,
 1,
 true,
 false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _supplyCrate];


_SabotageTask;
