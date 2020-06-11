params ["_building", "_groupSide", "_nameGroup", "_unitCount", "_groupFaction", "_menType"];
private["_building", "_groupSide", "_groupFaction", "_menType", "_units", "_group", "_nameGroup", "_unitType", "_unitCount", "_positionCount"];
/* Created by Broken_Algorithm on the 13/11/2019. Arma 3 version 1.96
This function spawns an enemy group of a chosen side, group, groupsize and faction in a building.
Params:
0. Building:
    Value: Building position array or Building Object
1. Group side
    Value: String // Can be WEST,EAST or RESISTANCE, civilians aren't supported
2. Group Name:
    Value: String // Name used for group identification MUST BE UNIQUE!!!
3. Unit Count:
    Value: Integer // Amount of units to be spawned in building
4. Group Faction:
	Value: String // Classname of the faction from CfgFactionClasses
5. Men Type:
	Value: String // Can be "STANDARD", "RECON" or "SPECIAL". Determines if the infantry group should be of certain kind, i.e. (CSAT, CSAT Recon, Viper).

Example of calling the function:
    enemies = [buildingObject/[buildingLocation], EAST, "WIDOW_1", 5, "OPF_F", "RECON"] call CO_fnc_garrisonBuilding.sqf;
*/
_csatGi = [
	"O_Soldier_TL_F",
    "O_engineer_F",
	"O_soldier_exp_F",
	"O_Soldier_A_F",
	"O_Soldier_AR_F",
	"O_medic_F",
	"O_Soldier_GL_F",
	"O_HeavyGunner_F",
	"O_soldier_M_F",
	"O_Soldier_F",
	"O_Soldier_LAT_F",
	"O_Soldier_HAT_F",
	"O_Soldier_lite_F",
	"O_Sharpshooter_F"
];

_csatRecon = [
	"O_recon_TL_F",
	"O_recon_F",
	"O_recon_M_F",
	"O_recon_medic_F",
	"O_Pathfinder_F",
	"O_recon_JTAC_F",
	"O_recon_LAT_F"
];

_csatSf = [
	"O_V_Soldier_TL_hex_F",
	"O_V_Soldier_LAT_hex_F",
	"O_V_Soldier_Medic_hex_F",
	"O_V_Soldier_hex_F",
	"O_V_Soldier_M_hex_F",
	"O_V_Soldier_JTAC_hex_F",
	"O_V_Soldier_Exp_hex_F"
];

_aafGi = [
	"I_Soldier_TL_F",
	"I_Soldier_A_F",
	"I_Soldier_AR_F",
	"I_medic_F",
	"I_engineer_F",
	"I_Soldier_exp_F",
	"I_Soldier_GL_F",
	"I_Soldier_M_F",
	"I_Soldier_AA_F",
	"I_Soldier_AT_F",
	"I_Soldier_LAT_F",
	"I_Soldier_LAT2_F",
	"I_soldier_F"
];

_syndikatGi = [
	"I_C_Soldier_Bandit_4_F",
	"I_C_Soldier_Bandit_1_F",
	"I_C_Soldier_Bandit_6_F",
	"I_C_Soldier_Bandit_5_F",
	"I_C_Soldier_Bandit_2_F",
	"I_C_Soldier_Bandit_3_F",
	"I_C_Soldier_Bandit_7_F",
	"I_C_Soldier_Para_7_F",
	"I_C_Soldier_Para_2_F",
	"I_C_Soldier_Para_3_F",
	"I_C_Soldier_Para_4_F",
	"I_C_Soldier_Para_6_F",
	"I_C_Soldier_Para_1_F",
	"I_C_Soldier_Para_5_F"
];

_targetBuilding = switch (typeName _building) do {
    case "ARRAY":{
		nearestBuilding _building
	};
	default{
		_building
	};
};

_units = switch _groupSide do {
	case east:{
        switch _groupFaction do 
		{
			case "OPF_F":{
                switch _menType do {
                    case "STANDARD":{
                        _csatGi
					};
					case "RECON":{
                        _csatRecon
					};
					case "SPECIAL":{
                        _csatSf
					};
					default{
                        _csatGi
					};
				};
			};
			default{
                switch _menType do {
                    case "STANDARD":{
                        _csatGi
					};
					case "RECON":{
                        _csatRecon
					};
					case "SPECIAL":{
                        _csatSf
					};
					default{
                        _csatGi
					};
				};
			};
		};
	};
	case resistance:{
		switch _groupFaction do {
			case "IND_F":{
                _aafGi
			};
			case "IND_C_F":{
				_syndikatGi
			};
			default{
                _aafGi
			};
		};
	};
	default{
		switch _menType do {
            case "STANDARD":{
                _csatGi
			};
			case "RECON":{
                _csatRecon
			};
			case "SPECIAL":{
                _csatSf
			};
			default{
                 _csatGi
			};
		};
	};
};

_groupId = [format ["%1", _nameGroup]];
_group = createGroup [_groupSide, true];
_group setGroupIdGlobal _groupId;

_positionsInBuilding = _targetBuilding buildingPos -1;
_positionCount = count _positionsInBuilding;

if (_unitCount > _positionCount || _unitCount <= 0) then {
    _unitCount = _positionCount;
};

for "_positionIndex" from 1 to _unitCount do{
    _unitType = selectRandom _units;
	_posInHouse = selectRandom _positionsInBuilding;
	_positionsInBuilding deleteAt (_positionsInBuilding find _posInHouse);
	_man = _group createUnit [_unitType, _posInHouse, [], 0, "CAN_COLLIDE"];
	_man disableAI "PATH";
};
{_x addCuratorEditableObjects [units _group,true];} forEach allCurators;
_group enableDynamicSimulation true;
units _group;