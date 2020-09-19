params ["_type","_position","_direction","_addToZeus","_enableDamage"];
/*
Spawns a building/object composition of a given type. The composition type is defined in this function.
The composition is spawned in reference to the center object which is spawned on the passed position.
If an unknown composition type is passed the function will simply exit with a warning message and no objects will be spawned.
The function returns an array of all objects in the composition.
*/

if (isNil "_direction") then {_direction = 0};
_composition = switch _type do
{
	default {};
	case "Camp_01_Rad":
	{
		//define relative positions:
		_centerCoordX = _position select 0;
		_centerCoordY = _position select 1;
		_tent_1_pos = [4.81353,0.773681,0];
		_tent_2_pos = [2.48785,2.69433,0];
		_tent_3_pos = [-1.51508,2.49487,0];
		_tent_4_pos = [-3.71869,0.409179,0];
		_wood_pos = [-3.96186,-2.30225,0];
		_fire_pos = [0.0762302,-1.70996,0];
		//Spawn objects:
		_net = createVehicle ["CamoNet_OPFOR_open_F",_position,[],0,"CAN_COLLIDE"];
		_tent_1 = createVehicle ["Land_TentA_F", _position vectorAdd _tent_1_pos,[],0,"CAN_COLLIDE"];
		_tent_2 = createVehicle ["Land_TentA_F", _position vectorAdd _tent_2_pos,[],0,"CAN_COLLIDE"];
		_tent_3 = createVehicle ["Land_TentA_F", _position vectorAdd _tent_3_pos,[],0,"CAN_COLLIDE"];
		_tent_4 = createVehicle ["Land_TentA_F", _position vectorAdd _tent_4_pos,[],0,"CAN_COLLIDE"];
		_wood = createVehicle ["Land_WoodPile_F", _position vectorAdd _wood_pos,[],0,"CAN_COLLIDE"];
		_fire = createVehicle ["Campfire_Burning_F", _position vectorAdd _fire_pos,[],0,"CAN_COLLIDE"];
		//Rotate if needed:
		if (!isNil "_direction" && _direction != 0) then
		{
			_net setDir _direction;
			_tent_1 setPos ([(_net modelToWorld _tent_1_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
			_tent_2 setPos ([(_net modelToWorld _tent_2_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
			_tent_3 setPos ([(_net modelToWorld _tent_3_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
			_tent_4 setPos ([(_net modelToWorld _tent_4_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
			_wood setPos ([(_net modelToWorld _wood_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
			_fire setPos ([(_net modelToWorld _fire_pos),[1,1,0]] call CO_fnc_actualVectorDotProduct);
		};
		_tent_1 setDir _direction + 58.491;
		_tent_2 setDir _direction + 19.502;
		_tent_3 setDir _direction + 343.173;
		_tent_4 setDir _direction + 296.320;
		_wood setDir _direction + 142.657;
		_fire setDir _direction;
		[_net,_tent_1,_tent_2,_tent_3,_tent_4,_fire,_wood];
	};
	case "base_01_Wes":
	{
		[
		   ["Land_Cargo_HQ_V1_F",[-0.765945,0.80196,0],270.522,1,0,[0,0],"","",true,false],
       ["Land_Cargo_House_V1_F",[-2.335,-12.3743,0],89.6803,1,0,[0,0],"","",true,false],
			 ["Land_PortableHelipadLight_01_F",[13.6423,1.90726,-0.00117397],0,1,0,[0,0],"","",true,false],
			 ["Logic",[9,9,9],0,1,0,[0,0],"","",true,false],
			 ["Land_Cargo_House_V1_F",[-12.6137,-12.1526,0],270.939,1,0,[0,0],"","",true,false],
			 ["O_Truck_03_repair_F",[14.7599,14.4389,0.137111],91.6874,1,0,[0,-0],"","",true,false],
			 ["Land_Cargo_House_V1_F",[-2.30131,-21.5918,0],91.3445,1,0,[0,-0],"","",true,false],
			 ["Land_MedicalTent_01_CSAT_brownhex_generic_outer_F",[-12.504,19.011,0],89.259,1,0,[0,0],"","",true,false],
			 ["O_Truck_02_Ammo_F",[13.479,18.593,0.217446],89.858,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.4747,0.291509,0],273.019,1,0,[0,0],"","",true,false],
			 ["Land_HelipadSquare_F",[13.1995,-20.4073,0],180.363,1,0,[0,0],"","",true,false],
			 ["O_Heli_Light_02_unarmed_F",[13.1233,-20.381,-0.130931],213.761,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.4665,-7.80828,0],270.132,1,0,[0,0],"","",true,false],
			 ["Land_Cargo_House_V1_F",[-12.5058,-21.6527,0],270.939,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.4058,8.56208,0],270.799,1,0,[0,0],"","",true,false],
			 ["O_Truck_02_transport_F",[13.5792,22.893,0.2175],91.8658,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall4_F",[-23.3682,-13.9722,0],273.492,1,0,[0,0],"","",true,false],
			 ["CargoNet_01_barrels_F",[25.2884,-12.4466,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.3497,16.8207,0],273.054,1,0,[0,0],"","",true,false],
			 ["CargoNet_01_barrels_F",[25.2517,-14.1838,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.4382,-18.1289,0],269.258,1,0,[0,0],"","",true,false],
			 ["CargoNet_01_barrels_F",[27.2546,-12.4211,0],0,1,0,[0,0],"","",true,false],
			 ["I_E_CargoNet_01_ammo_F",[24.0651,-18.2072,0],0,1,0,[0,0],"","",true,false],
			 ["CargoNet_01_barrels_F",[27.1637,-14.1516,0],0,1,0,[0,0],"","",true,false],
			 ["CamoNet_OPFOR_F",[26.5964,-15.6786,0],92.665,1,0,[0,-0],"","",true,false],
			 ["I_E_CargoNet_01_ammo_F",[24.1118,-20.2887,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.794,-0.367973,0],91.1025,1,0,[0,-0],"","",true,false],
			 ["I_E_CargoNet_01_ammo_F",[26.2301,-18.2196,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[0.384838,-33.2804,0],181.732,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.7302,-8.6224,0],92.4352,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-7.81383,-33.2637,0],181.732,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[8.6386,-33.3049,0],181.732,1,0,[0,0],"","",true,false],
			 ["I_E_CargoNet_01_ammo_F",[26.3147,-20.3071,0],0,1,0,[0,0],"","",true,false],
			 ["Land_MedicalTent_01_CSAT_brownhex_generic_outer_F",[-12.529,31.368,0],270.095,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.2051,-25.575,0],270.985,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.2044,25.087,0],272.132,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierTower_F",[-19.7098,-29.0141,0],49.6921,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.7272,-16.8752,0],92.5702,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[16.9366,-33.2221,0],181.732,1,0,[0,0],"","",true,false],
			 ["Land_HBarrier_Big_F",[32.4404,15.9686,0],270.828,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-16.1551,-33.4078,0],181.732,1,0,[0,0],"","",true,false],
			 ["Land_BarGate_01_open_F",[41.0175,2.57988,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierTower_F",[27.8288,-28.4721,0],314.195,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.4935,-24.9851,0],94.543,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[25.0687,-33.0958,0],181.732,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.1894,33.4663,0],272.054,1,0,[0,0],"","",true,false],
			 ["Land_HBarrier_Big_F",[41.6987,6.79834,0],270.828,1,0,[0,0],"","",true,false],
			 ["Land_Cargo_Tower_V1_No1_F",[13.1036,41.0203,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrier_Big_F",[41.6264,15.3971,0],270.828,1,0,[0,0],"","",true,false],
			 ["Land_MedicalTent_01_CSAT_brownhex_generic_outer_F",[-12.3627,43.1115,0],90.461,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.1356,32.9266,0],91.4287,1,0,[0,-0],"","",true,false],
			 ["Land_BarGate_01_open_F",[40.8069,28.611,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-24.0501,41.4688,0],271.013,1,0,[0,0],"","",true,false],
			 ["Land_HBarrier_Big_F",[41.8085,24.0865,0],270.828,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.2152,41.2312,0],91.4287,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-23.8483,47.3948,0],271.75,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierTower_F",[-19.3547,51.7841,0],128.35,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-0.631733,56.4476,0],1.45235,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-8.89557,56.3115,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[7.65083,56.5421,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[-17.0894,56.1205,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[15.8459,56.749,0],0,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[32.2253,49.5233,0],91.4287,1,0,[0,-0],"","",true,false],
			 ["Land_HBarrierTower_F",[27.7575,52.6758,0],227.624,1,0,[0,0],"","",true,false],
			 ["Land_HBarrierWall6_F",[24.0893,56.9808,0],359.009,1,0,[0,0],"","",true,false]
		];
  };
	case "base_02_Wes":
	{
		[
			["Logic",[9,9,9],0,1,0,[0,0],"","",true,false],
   		["Land_HBarrierWall6_F",[44.8141,5.92304,0],273.618,1,0,[0,0],"","",true,false],
			["Land_HBarrierTower_F",[46.8174,0.247417,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[44.9471,14.1084,0],273.618,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.0008,22.431,0],273.618,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall4_F",[52.8135,-0.275979,0],182.627,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[55.5773,-1.4233,0],183.253,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.079,30.6958,0],273.618,1,0,[0,0],"","",true,false],
			["Land_Research_HQ_F",[58.3776,12.895,0],89.9186,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.171,38.9779,0],273.618,1,0,[0,0],"","",true,false],
			["Land_Research_house_V1_F",[54.995,26.5134,0],269.021,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[62.9972,0.578735,0],152.882,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall4_F",[46.3851,42.1317,0],276.177,1,0,[0,0],"","",true,false],
			["Land_Research_house_V1_F",[55.2994,35.3445,0],270.588,1,0,[0,0],"","",true,false],
			["Land_HBarrierTower_F",[48.6395,48.0305,0],91.1773,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[70.3027,4.40084,0],154.429,1,0,[0,-0],"","",true,false],
			["Land_Research_house_V1_F",[65.4007,26.5377,0],90.1544,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall4_F",[46.6317,53.4744,0],273.525,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.4528,55.5766,0],273.618,1,0,[0,0],"","",true,false],
			["Land_Research_house_V1_F",[65.6256,35.4444,0],89.8745,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[77.2986,8.26582,0],152.876,1,0,[0,-0],"","",true,false],
			["Land_MedicalTent_01_brownhex_closed_F",[61.9202,46.8256,0],271.023,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.6632,63.8664,0],273.618,1,0,[0,0],"","",true,false],
			["Land_WoodenTable_02_large_F",[78.293,28.3398,0],0,1,0,[0,0],"","",true,false],
			["Land_CanvasCover_02_F",[78.3562,30.0915,0],268.727,1,0,[0,0],"","",true,false],
			["Land_MedicalTent_01_CSAT_brownhex_generic_inner_F",[57.8375,61.4661,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[84.4522,12.0648,0],152.809,1,0,[0,-0],"","",true,false],
			["Land_WoodenTable_02_large_F",[78.385,32.97,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.8408,72.0989,0],273.618,1,0,[0,0],"","",true,false],
			["Land_MedicalTent_01_brownhex_closed_F",[78.4382,46.5139,0],270.735,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[91.8281,16.2167,0],151.903,1,0,[0,-0],"","",true,false],
			["Land_MedicalTent_01_CSAT_brownhex_generic_inner_F",[69.2741,61.3048,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[45.8315,80.3533,0],273.618,1,0,[0,0],"","",true,false],
			["O_LSV_02_unarmed_F",[54.9518,79.8076,0.0999684],0,1,0,[0,0],"","",true,false],
			["O_LSV_02_armed_F",[57.9869,79.6965,0.0999684],0,1,0,[0,0],"","",true,false],
			["Land_Cargo_HQ_V1_F",[94.1132,34.9201,0],90.292,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[99.2125,20.2582,0],152.666,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[45.8151,88.5519,0],269.412,1,0,[0,0],"","",true,false],
			["Land_MedicalTent_01_CSAT_brownhex_generic_inner_F",[80.8912,61.0424,0],0,1,0,[0,0],"","",true,false],
			["O_MRAP_02_F",[61.6521,81.1807,0.149065],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierTower_F",[47.8788,94.7472,0],181.493,1,0,[0,0],"","",true,false],
			["Land_Cargo_House_V1_F",[94.4723,50.4315,0],271.093,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[106.342,23.9902,0],155.104,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall4_F",[53.8546,95.2445,0],0,1,0,[0,0],"","",true,false],
			["O_Heli_Attack_02_dynamicLoadout_F",[76.769,78.1989,-0.000644684],311.893,1,0,[0,0],"","",true,false],
			["Land_HelipadSquare_F",[77.1397,77.9301,0],178.966,1,0,[0,-0],"","",true,false],
			["Land_Cargo_House_V1_F",[94.82,57.6137,0],271.093,1,0,[0,0],"","",true,false],
			["Land_BarGate_F",[44.6113,99.2168,0],90.6759,1,0,[0,-0],"","",true,false],
			["Land_Cargo_House_V1_F",[102.923,50.25,0],90.5205,1,0,[0,-0],"","",true,false],
			["Land_HBarrier_1_F",[61.6949,97.3676,0],269.356,1,0,[0,0],"","",true,false],
			["Land_Cargo_House_V1_F",[94.9213,65.2098,0],271.093,1,0,[0,0],"","",true,false],
			["Land_HBarrier_1_F",[63.2008,97.3999,0],268.683,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[113.817,27.8366,0],153.815,1,0,[0,-0],"","",true,false],
			["Land_Cargo_House_V1_F",[103.459,57.5551,0],90.5205,1,0,[0,-0],"","",true,false],
			["Land_HBarrier_Big_F",[49.0993,106.874,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[72.0654,95.186,0],32.1094,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[78.9395,91.2382,0],31.3693,1,0,[0,0],"","",true,false],
			["Land_HBarrier_Big_F",[57.0165,107.089,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[86.093,87.3398,0],32.4771,1,0,[0,0],"","",true,false],
			["Land_Cargo_House_V1_F",[103.962,65.1236,0],90.5205,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[93.3103,82.9756,0],33.9038,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[121.325,32.0102,0],152.624,1,0,[0,-0],"","",true,false],
			["Land_BarGate_01_open_F",[77.1285,102.525,0],302.193,1,0,[0,0],"","",true,false],
			["Land_HBarrier_Big_F",[65.5683,107.362,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[100.2,78.7779,0],33.1204,1,0,[0,0],"","",true,false],
			["Land_HBarrier_Big_F",[73.635,105.214,0],30.7206,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[107.215,74.4165,0],32.9464,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[128.598,35.8824,0],154.355,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[114.277,70.2896,0],31.6038,1,0,[0,0],"","",true,false],
			["Land_Cargo_Tower_V1_No7_F",[126.529,50.2609,0],0,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[121.426,66.0449,0],34.0372,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[135.492,39.4001,0],154.431,1,0,[0,-0],"","",true,false],
			["Land_HBarrierWall6_F",[128.333,61.7588,0],34.3263,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[135.347,57.5002,0],32.592,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[142.78,43.2662,0],155.591,1,0,[0,-0],"","",true,false],
			["Land_HBarrierTower_F",[142.837,47.9288,0],270.97,1,0,[0,0],"","",true,false],
			["Land_HBarrierWall6_F",[142.377,53.2217,0],32.5167,1,0,[0,0],"","",true,false]
		];
	};
	case "base_admin_01_Wes":
	{
		[
			["Land_Mil_WallBig_4m_battered_F",[-3.9917,-0.155273,-0.449558],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-4.01758,3.70068,-0.449558],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.96729,-5.22998,1.6589],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-1.88672,5.95996,-0.449558],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[1.95459,5.95117,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[4.56152,5.95508,1.53887],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.95605,-7.84326,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[9.63525,5.96973,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.94092,-11.6758,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Cargo_Tower_V1_No4_F",[0,0,0],269.575,1,0,[0,0],"kek","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[13.4761,5.97119,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["CargoNet_01_barrels_F",[9.30127,-12.5479,-9.53674e-007],0.000725238,1,0,[-4.59849e-005,0.000111224],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.92969,-15.5122,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["CargoNet_01_barrels_F",[11.105,-12.5571,-9.53674e-007],0.000170677,1,0,[0.000179855,-1.98777e-005],"","",true,false],
			["CargoNet_01_barrels_F",[9.27539,-14.6201,0],0.000309029,1,0,[5.12568e-005,-6.18998e-005],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[17.3218,5.96436,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["CargoNet_01_barrels_F",[13.0107,-12.8613,0],360,1,0,[4.91901e-005,4.28239e-005],"","",true,false],
			["CargoNet_01_barrels_F",[11.0938,-14.6362,0],360,1,0,[4.16347e-005,9.37461e-006],"","",true,false],
			["CamoNet_INDP_F",[14.2202,-13.2158,0],358.621,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.91943,-19.3589,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["CargoNet_01_barrels_F",[13.1733,-14.6782,0],0.000325576,1,0,[5.59662e-005,-6.49563e-005],"","",true,false],
			["CargoNet_01_barrels_F",[15.1851,-12.937,0],7.16773e-005,1,0,[-1.64657e-006,1.71534e-005],"","",true,false],
			["CargoNet_01_barrels_F",[15.1289,-15.1187,-9.53674e-007],0.000725238,1,0,[-4.59849e-005,0.000111224],"","",true,false],
			["CargoNet_01_barrels_F",[17.1011,-13.0313,0],360,1,0,[3.68649e-005,6.34279e-005],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[21.1523,5.96875,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["CargoNet_01_barrels_F",[16.9546,-15.0034,-9.53674e-007],0.000520463,1,0,[-1.02018e-005,-8.51189e-005],"","",true,false],
			["CargoNet_01_barrels_F",[18.8701,-13.0698,0],360,1,0,[-1.16247e-006,-9.02546e-006],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.86621,-23.2065,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["O_Truck_03_fuel_F",[-0.324707,-23.7388,-0.075964],359.996,1,0,[0.216078,-0.192585],"","",true,false],
			["CargoNet_01_barrels_F",[18.7461,-14.9512,-9.53674e-007],7.67637e-005,1,0,[0.000130719,2.26071e-005],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[24.9907,5.97412,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.84277,-27.0376,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[28.8379,5.9707,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.85742,-30.8867,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["O_MRAP_02_F",[3.10205,-32.0605,0.00733328],89.9531,1,0,[0.0328498,-0.0317327],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[32.6885,5.97021,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.83887,-34.7212,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["O_MRAP_02_F",[3.43066,-35.6826,0.00733328],89.9531,1,0,[0.0328548,-0.0317363],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[36.5234,5.98633,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.84131,-38.5669,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[40.3672,5.98096,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.8252,-42.4004,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["O_Truck_02_covered_F",[0.994629,-43.8213,-0.0127788],178.419,1,0,[-0.815102,0.0377301],"","",true,false],
			["O_Truck_02_covered_F",[4.75732,-43.5898,-0.0128031],178.419,1,0,[-0.818013,0.0377667],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[44.2085,5.97949,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.80762,-46.2397,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[48.0615,5.97656,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_MilOffices_V1_F",[35.478,-31.6162,0],269.538,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-3.78613,-50.0659,-0.0119424],89.6952,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[51.9106,5.97168,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-5.36816,-51.6094,-0.0119424],181.503,1,0,[0,0],"","",true,false],
			["Land_BarGate_01_open_F",[-8.17334,-51.9321,0],0,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-17.7764,-51.647,-0.0119424],181.503,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[55.7388,5.9873,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-21.687,-51.5151,-0.0119424],181.503,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.9414,-53.7104,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Cargo_Patrol_V1_F",[-19.7593,-54.1763,0],180.431,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[59.5869,5.99805,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_WoodenTable_02_large_F",[53.3325,-27.9033,0.0129075],359.999,1,0,[0.000237118,-0.193347],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.9277,-57.5801,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_IRMaskingCover_01_F",[53.854,-31.5718,-0.981553],88.841,1,0,[0,0],"","",true,false],
			["Land_WoodenTable_02_large_F",[53.3179,-32.0698,0.0129075],359.999,1,0,[0.000236569,-0.193346],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[63.416,6.00391,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_WoodenTable_02_large_F",[53.2954,-36.0947,0.0129075],359.999,1,0,[0.000237522,-0.193346],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.9282,-61.4033,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[67.2817,6.00488,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[32.3047,-59.8882,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.7124,-61.4526,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.8853,-65.2178,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[36.1445,-59.9102,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_HelipadSquare_F",[20.6831,-66.708,0],0,1,0,[0,0],"","",true,false],
			["O_Heli_Light_02_dynamicLoadout_F",[20.645,-67.0854,-0.125561],328.925,1,0,[3.03608,-0.000210751],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[71.1226,6.02295,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[39.9775,-59.9346,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.7046,-65.3149,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.8823,-69.0498,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[43.8374,-59.9561,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[74.9702,6.05176,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.6714,-69.1353,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_MilOffices_V1_F",[71.542,-31.4805,0],89.6405,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[47.6787,-59.9766,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.8574,-72.9116,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[51.5337,-60.0215,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.6636,-72.9414,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[78.8174,6.05811,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.853,-76.7451,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[55.3584,-60.0352,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Cargo_Patrol_V1_F",[-20.1367,-80.2598,0],0.181833,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[1.46484,-82.8755,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-2.39795,-82.894,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.6567,-76.7793,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[5.31738,-82.8838,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-6.23584,-82.8667,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[82.6895,6.06982,-0.0119424],179.802,1,0,[0,-0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[9.14746,-82.9141,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-10.0796,-82.8613,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[12.9663,-82.9395,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-13.9155,-82.8604,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Cargo_Patrol_V1_F",[27.1152,-80.1582,0],359.831,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-23.8364,-80.5908,-0.0119424],89.8103,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[59.2021,-60.063,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[16.7954,-82.9033,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-17.7534,-82.8511,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[20.6963,-82.8438,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[-21.5806,-82.8442,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[24.5371,-82.854,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[30.6396,-80.6279,-0.0119424],270.227,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[86.5264,6.02783,-0.0119424],180.897,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[63.0376,-60.1143,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[28.3779,-82.8721,-0.0119424],0.0525221,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[66.8936,-60.1323,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[90.3511,5.97266,-0.0119424],180.897,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[70.7344,-60.1626,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Cargo_Patrol_V1_F",[92.6846,3.34521,0],180.431,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[94.1909,5.92139,-0.0119424],180.897,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[74.5894,-60.186,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4844,-0.646484,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.5044,3.22705,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4585,-4.49561,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4976,3.63428,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.457,-8.33252,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4443,-12.1704,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4229,-16.0122,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.4116,-19.8516,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[78.46,-60.2441,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3931,-23.6948,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3774,-27.5166,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3584,-31.3496,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[82.3145,-60.2896,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3462,-35.1865,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3242,-39.0278,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[86.2012,-60.3428,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.3037,-42.8545,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.2686,-46.6855,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[90.0981,-60.3696,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.2617,-50.5068,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Cargo_Patrol_V1_F",[92.6787,-57.7524,0],0.279543,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.2437,-54.3433,-0.0119424],270.211,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[93.9805,-60.4141,-0.0119424],0.585901,1,0,[0,0],"","",true,false],
			["Land_Mil_WallBig_4m_battered_F",[96.2388,-58.1846,-0.0119424],270.211,1,0,[0,0],"","",true,false]
		];
	};
};

_composition_objects = [_position, _direction, _composition, 0] call BIS_fnc_objectsMapper;

if (_addToZeus) then {{_x addCuratorEditableObjects [_composition_objects]} forEach allCurators;};
if (!_enableDamage) then {{_x allowDamage false} forEach _composition_objects};


_composition_objects
