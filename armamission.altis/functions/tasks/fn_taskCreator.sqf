
// [owner, taskID, description, destination, state, priority, showNotification, type, visibleIn3D] call BIS_fnc_taskCreate
/*

Tasks:																Task names:											Dev progress:

-Infantry:
	-Hostile takeover (Clear town) + Command hq?					townClear											100%
	-Sabotage (Supply cache)										sabotageInfantry									90%
	-Defend town (conventional)										townDefend											90%
-Airforce:
	-Troop transport												transportPerson										0%
	-Supply transport (Helicopter)									transportObject										0%
	-Air superiority (Destroy enemy aircraft)						airDestroyAir										0%
	-Ground support (Destroy attacking ground vehicles)				airDestroyGround									0%
-Recon:
	-Sabotage (Enemy LRAA/LRArty)									reconSabotage										0%
	-UAV Data														reconRecovery										0%
	-Patrol															patrol												0%
	-Search and rescue												reconRescue											0%
	-Anti recon														reconClear											0%
-Logistics:
	-Missing supply crate											recoveryCache										30%
	-Supply transport (Drive vehicle to random location)			transportVehicle									0%
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
	case "reconSabotage": {_description = ["We have learned that an enemy SAM site has been set up in the AO. We do not know it's exact location but we know it's general area. Recon the area and sabotage the site.","Find and Sabotage the SAM site"]; _type = "destroy"};
	case "reconRescue": {_description = ["A NATO helicopter on patrol has taken fire and reported that they were going down. All communication had ceased after the crash, but we've reason to believe that the crew is still alive. We don't know the exact location of the crash site but we've calculated the approximate area of where it might be. Your job is to find the crash site and bring the crew back to the base.","Find and Rescue the crew"]; _type = "search"};
	case "reconAntirecon": {_description = ["We have received reports about enemy scouts setting up camps in our AO to monitor our troops' movement. They have to be dealt with as soon as possible! Find their camps and neutralize the scouts.", "Find enemy camps and kill the scouts.."]; _type = "Search"};
};

_task = [true, _taskID, _description, _destination, "CREATED", -1, true, _type, true] call BIS_fnc_taskCreate;

taskIDGlobal = taskIDGlobal + 1;

_task;
