

 
 /**
 * Move a group of units to the diametrically opposite point of a given unit, relative to a marker
 * [unit(object unit), "MarkerName"(string)]
 *
 * @author					Skippy (jean.battistel@gmail.com)
 * @version 				1.02
 * @param 		vehicle 	unit, gives the position of origin
 * @param 		string 		marker's name, gives the center of the rotation 
 * @param 		group 		group of units to move
 * @param 		bool 		if TRUE, a marker is placed at final position
 * @return 		void
 * @see 					CPC_fnc_rotate
 * @see 					CPC_fnc_moveGroup
*/
CPC_fnc_setDiametricallyOpposite = {
	["%1 CPC_fnc_setDiametricallyOpposite (1.02)", _this , 2] call CPC_fnc_debug;
	
	_originPos 				= getPosATL (_this select 0);
	_centerPos 				= getMarkerPos (_this select 1);
	_group 					= _this select 2;
	
	
	// final position is calculated
	_finalPos 				= [_originPos, _centerPos, 180] call CPC_fnc_rotate;
	
	
	// group is moved
	[_group, _finalPos, 10] call CPC_fnc_moveGroup;
	
	
	/*
	 * DEBUG
	 */
	_debug 					= [ _this , 3 , false ] call CBA_fnc_defaultParam;

	if(_debug) then
	{
		_markerPos = createMarker["mkDebugDiametricallyPos", _finalPos];
		_markerPos setMarkerShape "ICON";
		"mkDebugDiametricallyPos" setMarkerType "DOT";
		"mkDebugDiametricallyPos" setMarkerColor "ColorYellow";
		"mkDebugDiametricallyPos" setMarkerSize [2, 2];
		"mkDebugDiametricallyPos"  setMarkerText "Debug Marker Pos fnc_setDiametricallyOpposite";
		
		_markerGroup = createMarker["mkDebugDiametricallyGroup", _group call CPC_fnc_center2D];
		_markerGroup setMarkerShape "ICON";
		"mkDebugDiametricallyGroup" setMarkerType "DOT";
		"mkDebugDiametricallyGroup" setMarkerColor "ColorBlue";
		"mkDebugDiametricallyGroup" setMarkerSize [2, 2];
		"mkDebugDiametricallyGroup"  setMarkerText "Debug Marker Group fnc_setDiametricallyOpposite";
	};
};




/**
 * Move a group of units randomly on a circle 
 *
 * @author					Skippy (jean.battistel@gmail.com)
 * @version 				1.02
 * @param 		array 		position of the rotation's center
 * @param 		group 		group of units to move
 * @param 		number 		max angle to rotate
 * @param 		bool 		if TRUE, a marker is placed at final position
 * @return 		void
 * @see 					CPC_fnc_rotate
 * @see 					CPC_fnc_moveGroup
 * @todo					corriger les erreurs de position finale
*/
CPC_fnc_setGroupOnCircleRandom = {
	["%1 CPC_fnc_setGroupOnCircleRandom (1.02)", _this , 2] call CPC_fnc_debug;
	
	_centerPos 				= _this select 0;
	_group 					= _this select 1;

	_angle 					= _this select 2;
	_angle 					= floor (random (_angle * 2)) - _angle;

	_originPos 				= _group call CPC_fnc_center2D;

	
	// final position is calculated
	_finalPos 				= [_originPos, _centerPos, _angle] call CPC_fnc_rotate;
	
	
	// group is moved
	[_group, _finalPos, 10] call CPC_fnc_moveGroup;
	
	
	/*
	 * DEBUG
	 */
	_debug 					= [ _this , 3 , false ] call CBA_fnc_defaultParam;

	if(_debug) then
	{
		(_group select 0) sideChat format["ancienne distance : %1", _originPos distance _centerPos];
		(_group select 0) sideChat format["nouvelle distance : %1", (_group call CPC_fnc_center2D) distance _centerPos];
				
		_markerOldPos = createMarker["mkDebugOnCircleOldPos", _originPos];
		_markerOldPos setMarkerShape "ICON";
		"mkDebugOnCircleOldPos" setMarkerType "DOT";
		"mkDebugOnCircleOldPos" setMarkerColor "ColorYellow";
		"mkDebugOnCircleOldPos" setMarkerSize [1 , 1];
		"mkDebugOnCircleOldPos"  setMarkerText "Debug Marker oldPos fnc_setRandomGroupOnCircle";
				
		_markerNewPos = createMarker["mkDebugOnCircleNewPos", _finalPos];
		_markerNewPos setMarkerShape "ICON";
		"mkDebugOnCircleNewPos" setMarkerType "DOT";
		"mkDebugOnCircleNewPos" setMarkerColor "ColorYellow";
		"mkDebugOnCircleNewPos" setMarkerSize [2 , 2];
		"mkDebugOnCircleNewPos"  setMarkerText "Debug Marker newPos fnc_setRandomGroupOnCircle";
				
		_markerGroup = createMarker["mkDebugOnCircleGroup", _group call CPC_fnc_center2D];
		_markerGroup setMarkerShape "ICON";
		"mkDebugOnCircleGroup" setMarkerType "DOT";
		"mkDebugOnCircleGroup" setMarkerColor "ColorBlue";
		"mkDebugOnCircleGroup" setMarkerSize [2 , 2];
		"mkDebugOnCircleGroup"  setMarkerText "Debug Marker Group fnc_setRandomGroupOnCircle";
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