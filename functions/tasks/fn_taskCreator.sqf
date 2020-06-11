
// [owner, taskID, description, destination, state, priority, showNotification, type, visibleIn3D] call BIS_fnc_taskCreate
/*

Tasks:																Task names:											Dev progress:

-Infantry:
	-Hostile takeover (Clear town) + Command hq?					townClear											90%
	-Sabotage (Supply cache)										sabotageInfantry									90%
	-Defend town (conventional)										townDefend											90%
	-Defend ally (Idap/friendly from guerrilla/recon)				personDefend										0%
-Airforce:
	-Troop transport												transportPerson										0%
	-Supply transport (Helicopter)									transportObject										0%
	-Air superiority (Destroy enemy aircraft)						airDestroyAir										0%
	-Ground support (Destroy attacking ground vehicles)				airDestroyGround									0%
-Recon:
	-Sabotage (Enemy LRAA/LRArty)									sabotageRecon										0%
	-UAV Data														recoveryUAV											0%
	-Patrol															patrol												0%
	-Search and rescue												recoverySoldier										0%
	-Anti recon														reconClear											0%
-Logistics:
	-Missing supply crate											recoveryCache										30%
	-Supply transprt (Drive vehicle to random location)				transportVehicle									0%
-Special forces:
	-Hostage rescue													recoveryVIP											0%
	-Assassination													killHVT												0%
	-Snatch and grab												recoveryHVT											0%
	-Intel recovery (From enemy).									recoveryIntel										0%
	-Convoy Interception 											sabotageConvoy										0%
	-Underwater recovery											recoveryUW											0%
	-Underwater EOD													sabotageUW											0%
	-Anti-Piracy.
	-Steal Prototype Technology (Vehicle)
*/
params ["_missionType","_destination"];

_taskID = "task_" + str taskIDGlobal;
_description = [];
_type = "";

switch _missionType do
{
	case "townClear": {_description = ["Clear the fucking town twats", "Clear the town"]; _type = "attack"};
	case "sabotageInfantry": {_description = ["That crate over there go boom", "Destroy the cache"]; _type = "destroy"};
	case "townDefend": {_description = ["Use protection kids"]; _type = "defend"};
	case "personDefend": {_description = ["P R O T E C C B O I"]; _type = "defend"};
};

_task = [true, _taskID, _description, _destination, "CREATED", -1, true, _type, true] call BIS_fnc_taskCreate;

taskIDGlobal = taskIDGlobal + 1;

_task;
