params ["_side","_faction"];

_town = call CO_fnc_selectTown;
_townPos = locationPosition _town;
_center = [_townPos select 0, _townPos select 1, 0];

_task = ["townDefend",_center] call CO_fnc_taskCreator;
_title = format ["Go to %1", text _town];
_description = format ["We have received intel that hostile forces are preparing to attack <marker name='%2'>%1</marker>. Go to the <marker name='%2'>%1</marker> and prepare to defend it!", text _town, _town];
[_task, [_description, _title,""]] call BIS_fnc_taskSetDescription;


_waveCount = 0;
_waveDistance = 0;
_waveSize = 0;
_radius  = 0;

switch type _town do
{
	case "NameVillage": {_waveCount = 3; _waveDistance = 500; _waveSize = 4;_radius = 150;};
	case "NameCity": {_waveCount = 4 + random 1; _waveDistance = 750; _waveSize = 5;_radius = 250;};
	case "NameCityCapital": {_waveCount = 5 + random 2; _waveDistance = 1000; _waveSize = 6;_radius = 450;};
};


_title = format ["Defend %1", text _town];
_description = format ["The enemy attack on %1 has begun. Stay in %1 and defend it!", text _town];


_onActivation = format ["['%2', ['%10', '%9','']] call BIS_fnc_taskSetDescription;[%1, '%2', %3, '%4', %5, %6, %7, 5, 'MEN', 180] call CO_fnc_waveMaster;[%1, '%2', %3, '%4', 3, 1, %7, 1, 'GROUND', 330] call CO_fnc_waveMaster;[%5, %1, %8, '%2', %3] call CO_fnc_defendFinisher; deleteVehicle thisTrigger", _center, _task, _side, _faction, 3 * _waveCount, _waveSize, _waveDistance, _radius,_title,_description];

_initial = createTrigger ["EmptyDetector", _center];
_initial setTriggerArea [_radius, _radius, 0, false];
_initial setTriggerTimeout [90, 90, 90, false];
_initial setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_initial setTriggerStatements ["this",_onActivation,""];