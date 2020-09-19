params ["_target"];
_groupOld = group _target;
_target addAction ["Lead",{_target = _this select 0;_calller = _this select 1;[_target] joinSilent group _calller;_target enableAI "PATH";_target removeAction (_this select 2); [_target,_this select 3] call CO_fnc_stopLeadAI;},_groupOld,0,true,true,"","_this distance _target <= 2 && alive _target"];