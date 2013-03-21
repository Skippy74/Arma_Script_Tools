/* ************************************************************************** */
	["CPC_fnc_vehicle.sqf (1.01)", 1] call CPC_fnc_debug;
/* ************************************************************************** */




// [object (Vehicle)] 
// return boundingBox based length
CPC_fnc_getObjectSizeX = {
	["%1 CPC_fnc_getObjectSizeX (1.1)", _this , 2] call CPC_fnc_debug;
	
	
	_object 				= _this select 0;
	
	
	((((boundingBox _object) select 1) select 0) - (((boundingBox _object) select 0) select 0))
};




// [object (Vehicle)] 
// return boundingBox based width
CPC_fnc_getObjectSizeY = {
	["%1 CPC_fnc_getObjectSizeY (1.1)", _this , 2] call CPC_fnc_debug;
	
	
	_object 				= _this select 0;
	
	
	((((boundingBox _object) select 1) select 1) - (((boundingBox _object) select 0) select 1))
};




// [object (Vehicle)] 
// return boundingBox based height
CPC_fnc_getObjectSizeZ = {
	["%1 CPC_fnc_getObjectSizeZ (1.1)", _this , 2] call CPC_fnc_debug;
	
	
	_object 				= _this select 0;
	
	
	((((boundingBox _object) select 1) select 2) - (((boundingBox _object) select 0) select 2))
};




// [object (Vehicle)]
// return BOOL
CPC_fnc_isBurried = {
	["%1 CPC_fnc_isBurried (1.1)", _this , 2] call CPC_fnc_debug;

	
	_object					= _this select 0;
	_height					= [_object] call CPC_fnc_getObjectSizeZ;
	_posZ					= (getPosATL _object) select 2;
	
	
	((_height + _posZ) < 0)
};




// [object (Vehicle), offset (Array)]
CPC_fnc_move = {
	["%1 CPC_fnc_move (1.0)", _this , 2] call CPC_fnc_debug;

	
	_object					= _this select 0;
	_offset					= _this select 1;

	
	_object setPos [(getPosATL _object select 0) + (_offset select 0), 
					(getPosATL _object select 1) + (_offset select 1),
					(getPosATL _object select 2) + (_offset select 2)];
};




