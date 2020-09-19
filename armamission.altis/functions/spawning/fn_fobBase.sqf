params ["_type", "_side", "_faction","_groupName","_position"];

if (_type == "random" || _type == "RANDOM") then {
   _type = selectRandom ["base_01_Wes", "base_02_Wes", "base_admin_01_Wes"];
};

_enemies = [];

_fobBase = [_type, _position, random 360, true, false] call CO_fnc_spawnComposition;

_groupIterator = 0;
{
  _enemies_garrisoned = [_x, _side, format ["garrisonedGroup_%1_%2", _groupName, _groupIterator], selectRandom [0, 1, 2, 3, 4, 5 ,6], _faction, "STANDARD"] call CO_fnc_garrisonBuilding;
  _groupIterator = _groupIterator + 1;
  _enemies append _enemies_garrisoned;
} forEach _fobBase;

_enemies_patrol = [["PATROL", selectRandom [10, 25, 50, 80, 125, 250], "YELLOW", _position, "SAFE", [""], [""]], 50 , 200, selectRandom [3, 4, 5, 6], "patrolGroup_" + _groupName, _side, _faction, "MEN", "STANDARD", "AAPLANE", "CAR", selectRandom [4, 5, 6],"STAG COLUMN",true] call CO_fnc_enemyAssault;
_enemies append _enemies_patrol;

[_enemies, _fobBase];
