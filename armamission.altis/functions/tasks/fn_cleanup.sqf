params ["_position","_minDistance","_objects","_markers"];



//_nearestPlayer = [_position] call CO_fnc_nearestPlayer;

/*
while {_position distance2D _nearestPlayer < _minDistance;} do
{
	_nearestPlayer = [_position] call CO_fnc_nearestPlayer;
	sleep 1;
};*/
waitUntil {_position distance2D ([_position] call CO_fnc_nearestPlayer) > _minDistance;};

{
  if (!isNil "_x") then {
    private _vehicle = _x;
    {_vehicle deleteVehicleCrew _x } forEach (crew _vehicle);
  };
} forEach _objects;
if (count _objects > 0) then {{if (alive _X) then {deleteVehicle _x}} forEach _objects;};
if (count _markers > 0) then {{deleteMarker _x} forEach _markers;} else {systemChat "There are no markers to delete"};
true;