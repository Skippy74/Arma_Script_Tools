/* ************************************************************************** */
	["OLW_fnc_vehicle.sqf (1.01)", 1] call OLW_fnc_debug;
/* ************************************************************************** */




// [object (Vehicle)] 
// return boundingBox based length
OLW_fnc_getObjectSizeX = {
	["%1 OLW_fnc_getObjectSizeX (1.0)", _this, 2] call OLW_fnc_debug;
	
	_object 				= _this select 0;

	_length 				= (((boundingBox _object) select 1) select 0);
	_length 				= _length - (((boundingBox _object) select 0) select 0);
	
	_length 
};




// [object (Vehicle)] 
// return boundingBox based width
OLW_fnc_getObjectSizeY = {
	["%1 OLW_fnc_getObjectSizeY (1.0)", _this, 2] call OLW_fnc_debug;
	
	_object 				= _this select 0;

	_width 					= (((boundingBox _object) select 1) select 1);
	_width 					= _width - (((boundingBox _object) select 0) select 1);
	
	_width 
};




// [object (Vehicle)] 
// return boundingBox based height
OLW_fnc_getObjectSizeZ = {
	["%1 OLW_fnc_getObjectSizeZ (1.0)", _this, 2] call OLW_fnc_debug;
	
	_object 				= _this select 0;

	_height 				= (((boundingBox _object) select 1) select 2);
	_height 				= _height - (((boundingBox _object) select 0) select 2);
	
	_height 
};




// [object (Object)]
// return BOOL
OLW_fnc_isBurried = {
	["%1 OLW_fnc_isBurried (1.0)", _this, 2] call OLW_fnc_debug;

	_object					= _this select 0;
	
	_height					= _this call OLW_fnc_getObjectSizeZ;
	_posZ					= getPos _object select 2;
	_burried				= FALSE;

	

	if ((_height + _posZ) < 0) then {
		_burried = TRUE;
	} else {
		_burried = FALSE;
	};
	
	_burried
};




// [object (Object), offset (Array)]
OLW_fnc_move = {
	["%1 OLW_fnc_move (1.0)", _this, 2] call OLW_fnc_debug;

	_object					= _this select 0;
	_offset					= _this select 1;

	_object setPos [(getPos _object select 0) + (_offset select 0), 
					(getPos _object select 1) + (_offset select 1),
					(getPos _object select 2) + (_offset select 2)];
};




