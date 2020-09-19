params ["_side","_groupName","_position"];

_leader = "";
_man1 = "";
_man2 = "";
_manUav = "";
_uavType = "";
switch _side do
{
	case EAST: {_leader = "O_recon_TL_F"; _man1 = "O_recon_F"; _man2 = "O_Pathfinder_F"; _manUav = "O_soldier_UAV_F"; _uavType = "O_UAV_01_F";};
	case RESISTANCE: {_leader = "I_Soldier_TL_F"; _man1 = "I_Soldier_lite_F"; _man2 = "I_Soldier_M_F"; _manUav = "I_soldier_UAV_F"; _uavType = "I_UAV_01_F";};
};

_campSite = ["Camp_01_Rad",_position,random 360,true,false] call CO_fnc_spawnComposition;

_group = createGroup [_side,true];
_group setGroupIdGlobal [_groupName];
_group createUnit [_leader,_position,[],10,"NONE"];
_group createUnit [_man1,_position,[],10,"NONE"];
_group createUnit [_man2,_position,[],10,"NONE"];
_group createUnit [_manUav,_position,[],10,"NONE"];
_uav = createVehicle [_uavType,_position vectorAdd [0,0,100],[],25,"FLY"]; createVehicleCrew _uav; crew _uav join _group;
[_group, _position, 3] call BIS_fnc_taskPatrol;
[(units _group) + [_uav],_campSite];
