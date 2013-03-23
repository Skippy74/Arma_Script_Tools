/**
 * Move a group of units to the diametrically opposite point of a given unit, relative to a marker
 * [unit(object unit), "MarkerName"(string), group(object group), b(bool, optional)] b is a boolean that will reveal/hide the location of the created group.
 *
 * @author		Skippy (jean.battistel@gmail.com)
 * @version 				1.01
 * @param 		array
 * @return 		void
 * @todo		simplifier les tests
*/

CPC_fnc_setDiametricallyOpposite = {
	 
		private["_i",
			"_unit1PosX",
			"_unit1PosY",
			"_centerX",
			"_centerY",
			"_group",
			"_debug",
			"_marker"];

	_unit1PosX 				= (getPosATL (_this select 0)) select 0;
	_unit1PosY 				= (getPosATL (_this select 0)) select 1;
	_centerX 				= (getMarkerPos (_this select 1)) select 0;
	_centerY 				= (getMarkerPos (_this select 1)) select 1;
	_group 					= _this select 2;
	_debug 					= [_this, 3, false] call CBA_fnc_defaultParam;

	//probablement simplifiable (voir la fonction CPC_fnc_setGroupOnCircleRandom)
	if(_centerX < _unit1PosX) then
	{
		if(_centerY < _unit1PosY) then
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX - (abs(_centerX - _unit1PosX))) + _i, _centerY - (abs(_centerY - _unit1PosY)), 0];
			};
		}
		else
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX - (abs(_centerX - _unit1PosX))) + _i, _centerY + (abs(_centerY - _unit1PosY)), 0];
			};
		};
	}
	else
	{
		if(_centerY > _unit1PosY) then
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX + (abs(_centerX - _unit1PosX))) + _i, _centerY + (abs(_centerY - _unit1PosY)), 0];
			};
		}
		else
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX + (abs(_centerX - _unit1PosX))) + _i, _centerY - (abs(_centerY - _unit1PosY)), 0];
			};
		};
	};


	//debug marker

	if(_debug) then
	{
		_marker = createMarker["mkDebugDiametrically", getPosATL (_group select 1)];
		_marker setMarkerShape "ICON";
		"mkDebugDiametrically" setMarkerType "DOT";
		"mkDebugDiametrically" setMarkerColor "ColorYellow";
		"mkDebugDiametrically" setMarkerSize [2, 2];
		"mkDebugDiametrically"  setMarkerText "Debug Marker fnc_setDiametricallyOpposite"
	};
};



/**
 * Move a group of units randomly on a circle 
 * [center (position), group1 (group), angle(scalar), b(bool, optional)] b is a boolean that will reveal/hide the location of the created group.
 *
 * @author		Skippy (jean.battistel@gmail.com)
 * @version 				1.00
 * @param 		array
 * @return 		void
 * @todo		corriger les erreurs de position finale
*/
CPC_fnc_setGroupOnCircleRandom = {

	private["_centerX",
			"_centerY",
			"_centerArray",
			"_group",
			"_angle",
			"_k1",
			"_distCenterToUnit",
			"_unitX",
			"_unitY",
			"_distCenterToUnit",
			"_debug",
			"_marker",
			"_newAngle"];

	_centerX 						= (_this select 0) select 0;
	_centerY 						= (_this select 0) select 1;
	_centerArray					= [_centerX, _centerY];

	_group							= (_this select 1);

	_angle 							= floor(random(_this select 2)) + 1;

	_debug 							= [_this, 3, false] call CBA_fnc_defaultParam;

	_k1 							= (-1)^(floor(random 2)); //1 or -1

	_unitX 							= (getPosATL (_group select 0)) select 0; //on travail avec la première unité du groupe
	_unitY 							= (getPosATL (_group select 0)) select 1;

	_distCenterXtoUnitX 			= (_unitX - _centerX);
	_distCenterYtoUnitY 			= (_unitY - _centerY);
	_distCenterToUnit 				= _centerArray distance (_group select 0);


	if(_distCenterYtoUnitY >= 0) then //si l'unité est "au nord" du point central
	{
		_newAngle 					= acos(_distCenterXtoUnitX / _distCenterToUnit) + (_k1 * _angle);
	}
	else
	{
		_newAngle 					= (360 - acos(_distCenterXtoUnitX/_distCenterToUnit)) + (_k1 * _angle);
	};

	for "_i" from 0 to ((count _group) - 1) step 1 do
	{
		(_group select _i) setPosATL [_centerX + (_distCenterToUnit * cos(_newAngle)) + _i, _centerY + (_distCenterToUnit * sin(_newAngle)), 0];
	};


	//debug marker

	if(_debug) then
	{
		(_group select 0) sideChat format[" _distCenterXtoUnitX %1", _distCenterXtoUnitX];
		(_group select 0) sideChat format[" _distCenterToUnit %1", _distCenterToUnit];
		(_group select 0) sideChat format[" nouvel angle : %1", _newAngle];
		(_group select 0) sideChat format["ancienne distance %1", _distCenterToUnit];
		(_group select 0) sideChat format["nouvelle distance %1", (_centerArray distance (_group select 0))];
		
		_marker = createMarker["mkDebugOnCircle", getPosATL (_group select 1)];
		_marker setMarkerShape "ICON";
		"mkDebugOnCircle" setMarkerType "DOT";
		"mkDebugOnCircle" setMarkerColor "ColorRed";
		"mkDebugOnCircle" setMarkerSize [2, 2];
		"mkDebugOnCircle"  setMarkerText "Debug Marker fnc_setRandomGroupOnCircle"
	};
};




 /**
 * Gets two position and a number and applies a rotation of 'angle' degrees at 
 * the first argument with second argument as the center of the rotation.
 *
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array 		position of origin
 * @param 		array 		position of the rotation's center
 * @param 		number 		angle to rotate
 * @return 		array 		position, after the rotation
*/
CPC_fnc_rotate = {
	["%1 CPC_fnc_rotate (1.01)", _this , 2] call CPC_fnc_debug;
	
	// z position (altitude) is unwanted
	_origin 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_center 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];

	_angle 					= [_center, _origin] call CPC_fnc_azimuth;
	_angle 					= _angle + (_this select 2);

	_distance 				= _center distance _origin;


	[(_center select 0) + (_distance * cos _angle), 
	 (_center select 1) + (_distance * sin _angle), 
	 0]
};




 /**
 * Gets a group, a position and an optional radius, and move each unit 
 * of 'group' within 'radius' meters around 'position'.
 *
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		group 		
 * @param 		array 		position of the arrival
 * @param 		number 		radius
 * @return 		void
*/
CPC_fnc_moveGroup = {
	["%1 CPC_fnc_moveGroup (1.01)", _this , 2] call CPC_fnc_debug;
	
	
	_group 					= _this select 0;
	_arrival 				= _this select 1;
	_radius 				= [ _this, 2 , 0 ] call CBA_fnc_defaultParam;
	
	
	{
		// _moveTo is _arrival + _offset
		_moveTo 			= [0 , 0 , 0];
		// an offset is added for X and Y component of _finalPos
		for "_i" from 0 to 1 do {
			// position offset is between -_radius and +_radius
			_offset 		= floor (random (_radius * 2)) - _radius;
			_moveTo set [_i, _arrival select _i + _offset];
		};

		// unit is sent to _moveTo
		_x setPosATL _moveTo;
	} foreach _group;
};