/* ************************************************************************** */
	["CPC_fnc_topo.sqf (1.01)", 1] call CPC_fnc_debug;
/* ************************************************************************** */




/**
 * Gets 2 positions and returns the azimuth between the first and the second, 
 * in degrees, with North = 0.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array 		observer’s position
 * @param 		array 		observed’s position
 * @return 		number 		angle in degrees
 */
CPC_fnc_azimuth = {
	["%1 CPC_fnc_azimuth (1.01)", _this , 2] call CPC_fnc_debug;

	
	private ["_angle"];
	_observer 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_observed 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];
	
	_hypot 					= _observer distance _observed;
	_xAdj 					= (_observed select 0) - (_observer select 0);
	_yAdj 					= (_observed select 1) - (_observer select 1);
	_cos					= _xAdj / _hypot;
	_sin					= _yAdj / _hypot;
	
	switch TRUE do {
		case (_cos > 0 && _sin > 0) : {
			_angle 			= acos _cos;
		};
		case (_cos > 0 && _sin < 0) : {
			_angle 			= asin _sin;
		};
		case (_cos < 0 && _sin > 0) : {
			_angle 			= acos _cos;
		};
		case (_cos < 0 && _sin < 0) : {
			_angle 			= asin _sin + 90;
		};
	};
	
	_angle
};



/**
 * Gets 2 positions (’arrival’ and ’departure’), a ’distance’ and an optional 
 * ’angleOffset’, returns an array of waypoints that starts with ’departure’
 * and finishes with ’arrival’, located at ’distance’ from one another.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array 		arrival’s position
 * @param 		array 		departure’s position
 * @param 		number 		distance
 * @param 		number 		(optional) ’angleOffset’ in degrees ; 
 * 							the stopover’s position is shifted by a randomized 
 * 							angle from its trajectory if ’angleOffset’ is given
 * 							and not zero
 * @return 		array 		array of waypoints positions
 */
CPC_fnc_stopovers = {
	["%1 CPC_fnc_stopovers (1.01)", _this , 2] call CPC_fnc_debug;

	
	private ["_allStopovers"];
	_arrival 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_departure 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];
	_length 				= _this select 2;

	
	_angleOffset			= 0;
	if (count _this > 3) then {
		_angleOffset		= _this select 3;
	};

	
	while {_departure != _arrival} do {
		_departure 			= [_arrival, _departure, _length, _angleOffset] call CPC_fnc_stopover;
		_allStopovers set [count _allStopovers, _departure];
	};
	
	_allStopovers
};




/**
 * Gets 2 positions (’arrival’ and ’departure’) and a ’distance’, returns 
 * a position (’stopover’) located at ’distance’ from ’arrival’ or ’departure’.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.10
 * @param 		array 		arrival’s position
 * @param 		array 		departure’s position
 * @param 		number 		distance ;
 * 							if negative, distance is from ’arrival’, 
 * 							if positive, distance is from ’departure’, 
 * @param 		number 		(optional) ’angleOffset’ in degrees ; 
 * 							the stopover’s position is shifted by a randomized 
 * 							angle from its trajectory if ’angleOffset’ is given
 * 							and not zero
 * @return 		array 		’stopover’ position
 */
CPC_fnc_stopover = {
	["%1 CPC_fnc_stopover (1.10)", _this , 2] call CPC_fnc_debug;


	private ["_stopover", "_o"];
	_arrival 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_departure 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];
	_length 				= _this select 2;
	
	_distance 				= _arrival distance _departure;
	_angle 					= [_arrival, _departure] call CPC_fnc_azimuth;

	
	// Angle offset is between -offset and +offset
	_angleOffset			= 0;
	if ((count _this > 3) AND ((_this select 3) != 0)) then {
		_angleOffset		= random (2 * abs (_this select 3)) - abs (_this select 3);
	};
	_angle 					= _angle + _angleOffset;
	
	
	// If _length < 0, the _length applies to _arrival, else it applies to _departure
	// ex : _length = -20, then _stopover is at 20 meters from _arrival
	// ex : _length = 50, then _stopover is at 50 meters from _departure
	if (_length < 0) then {
		_o 					= _arrival;
	} else {
		_o 					= _departure;
	};
	
	
	// if _length < _distance, then the next _stopover is at the _arrival
	if ((abs _length) < _distance) then {
		_stopover 			= [	(_o select 0) + (_length * cos _angle), 
								(_o select 1) + (_length * sin _angle), 
								0 ];
	} else {
		_stopover 			= _arrival;
	};
	
	_stopover
};




/**
 * Gets some objects and returns the 3D position of the center of the swarm.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		vehicle 	(any number of) object
 * @return 		array		position of the center
 */
CPC_fnc_center3D = {
	["%1 CPC_fnc_center3D (1.01)", _this , 2] call CPC_fnc_debug;

	
	_posX 					= 0;
	_posY 					= 0;
	_posZ					= 0;
	_i 						= count _this;

	{
		_posX 				= _posX + (getPosATL _x select 0);
		_posY 				= _posY + (getPosATL _x select 1);
		_posZ 				= _posZ + (getPosATL _x select 2);
	} foreach _this;

	_posX 					= _posX / _i;
	_posY 					= _posY / _i;
	_posY 					= _posZ / _i;
	
	[_posX, _posY, _posZ]
};




/**
 * Gets some objects and returns the 2D position of the center of the swarm. 
 *
 * Use CPC_fnc_center3D.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				2.01
 * @param 		vehicle 	(any number of) object
 * @return 		array		position of the center
 * @see						CPC_fnc_center3D
 */
CPC_fnc_center2D = {
	["%1 CPC_fnc_center2D (2.01)", _this , 2] call CPC_fnc_debug;

	
	_pos 					= _this call CPC_fnc_center3D;
	
	
	[_pos select 0 , _pos select 1 , 0]
};




