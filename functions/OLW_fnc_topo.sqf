/* ************************************************************************** */
if !(isNil OLW_fnc_debug) then {
	["OLW_fnc_topo.sqf (1.01)", 1] call OLW_fnc_debug;
};
/* ************************************************************************** */




// [observer (Position), observed (Position)] 
// return azimuth in degree (from North = 0)
OLW_fnc_azimuth = {
	["%1 OLW_fnc_azimuth (1.0)", _this , 2] call OLW_fnc_debug;

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



// [arrival (Position), departure (Position), segmentLength (Number), angleOffset (Number)]
// return Positions (Arrays)
OLW_fnc_stopovers = {
	["%1 OLW_fnc_stopovers (1.0)", _this , 2] call OLW_fnc_debug;

	private ["_allStopovers"];
	_arrival 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_departure 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];
	_length 				= _this select 2;

	
	_angleOffset			= 0;
	if (count _this > 3) then {
		_angleOffset		= _this select 3;
	};

	
	while {_departure != _arrival} do {
		_departure 			= [_arrival, _departure, _length, _angleOffset] call OLW_fnc_stopover;
		_allStopovers set [count _allStopovers, _departure];
	};
	
	_allStopovers
};




// [arrival (Position), departure (Position), segment length (Number), angle offset (Number)]
// return segment (Position)
// return stopOver's position (Array)
OLW_fnc_stopover = {
	["%1 OLW_fnc_stopover (1.1)", _this , 2] call OLW_fnc_debug;


	private ["_stopover", "_o"];
	_arrival 				= [(_this select 0) select 0 , (_this select 0) select 1 , 0];
	_departure 				= [(_this select 1) select 0 , (_this select 1) select 1 , 0];
	_length 				= _this select 2;
	
	_distance 				= _arrival distance _departure;
	_angle 					= [_arrival, _departure] call OLW_fnc_azimuth;

	
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




// [object (Object), object (Object), ...]
// return position (Array)
OLW_fnc_center2D = {
	["%1 OLW_fnc_center2D (1.0)", _this, 2] call OLW_fnc_debug;

	_posX 					= 0;
	_posY 					= 0;
	_posZ					= 0;
	_i 						= count _this;

	{
		_posX 				= _posX + (getPos _x select 0);
		_posY 				= _posY + (getPos _x select 1);
	} foreach _this;

	_posX 					= _posX / _i;
	_posY 					= _posY / _i;
	
	[_posX, _posY, _posZ]
};




// [object (Object), object (Object), ...]
// return position (Array)
OLW_fnc_center3D = {
	["%1 OLW_fnc_center3D (1.0)", _this, 2] call OLW_fnc_debug;

	_posX 					= 0;
	_posY 					= 0;
	_posZ					= 0;
	_i 						= count _this;

	{
		_posX 				= _posX + (getPos _x select 0);
		_posY 				= _posY + (getPos _x select 1);
		_posZ 				= _posZ + (getPos _x select 2);
	} foreach _this;

	_posX 					= _posX / _i;
	_posY 					= _posY / _i;
	_posY 					= _posZ / _i;
	
	[_posX, _posY, _posZ]
};




