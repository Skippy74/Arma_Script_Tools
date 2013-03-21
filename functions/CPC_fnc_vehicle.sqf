/* ************************************************************************** */
	["CPC_fnc_vehicle.sqf (1.01)", 1] call CPC_fnc_debug;
/* ************************************************************************** */




/**
 * Gets an object and returns its length.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.03
 * @param 		vehicle		object
 * @return 		number		length of object
 */
CPC_fnc_getObjectSizeX = {
	["%1 CPC_fnc_getObjectSizeX (1.03)", _this , 2] call CPC_fnc_debug;
	
	
	_boundingBox 			= boundingBox _this select 0;
	
	
	(((_boundingBox select 1) select 0) - ((_boundingBox select 0) select 0))
};




/**
 * Gets an object and returns its width.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.03
 * @param 		vehicle		object
 * @return 		number		width of object
 */
CPC_fnc_getObjectSizeY = {
	["%1 CPC_fnc_getObjectSizeY (1.03)", _this , 2] call CPC_fnc_debug;
	
	
	_boundingBox 			= boundingBox _this select 0;
	
	
	(((_boundingBox select 1) select 1) - ((_boundingBox select 0) select 1))
};




/**
 * Gets an object and returns its height.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.03
 * @param 		vehicle		object
 * @return 		number		height of object
 */
CPC_fnc_getObjectSizeZ = {
	["%1 CPC_fnc_getObjectSizeZ (1.03)", _this , 2] call CPC_fnc_debug;
	
	
	_boundingBox 			= boundingBox _this select 0;
	
	
	(((_boundingBox select 1) select 2) - ((_boundingBox select 0) select 2))
};




/**
 * Gets an object and returns its size.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.02
 * @param 		vehicle		object
 * @return 		array		size of object
 */
CPC_fnc_getObjectSize = {
	["%1 CPC_fnc_getObjectSize (1.02)", _this , 2] call CPC_fnc_debug;
	
	
	_boundingBox 			= boundingBox _this select 0;
	
		
	[ ((_boundingBox select 1) select 0) - ((_boundingBox select 0) select 0), 
	  ((_boundingBox select 1) select 1) - ((_boundingBox select 0) select 1), 
	  ((_boundingBox select 1) select 2) - ((_boundingBox select 0) select 2) ]
};




/**
 * Gets an object and check if it is burried and visible or not.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.10
 * @param 		vehicle		object
 * @return 		bool		TRUE if object is burried and not visible
 */
// [object (Vehicle)]
// return BOOL
CPC_fnc_isBurried = {
	["%1 CPC_fnc_isBurried (1.10)", _this , 2] call CPC_fnc_debug;

	
	_object					= _this select 0;
	_height					= [_object] call CPC_fnc_getObjectSizeZ;
	_posZ					= (getPosATL _object) select 2;
	
	
	((_height + _posZ) < 0)
};




/**
 * Gets an object and an array and change 'object' position according to the 
 * values in the array. 
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		vehicle 	object
 * @param 		array 		position offset
 */
// [object (Vehicle), offset (Array)]
CPC_fnc_move = {
	["%1 CPC_fnc_move (1.01)", _this , 2] call CPC_fnc_debug;

	
	_object					= _this select 0;
	_offset					= _this select 1;

	
	_object setPos [(getPosATL _object select 0) + (_offset select 0), 
					(getPosATL _object select 1) + (_offset select 1),
					(getPosATL _object select 2) + (_offset select 2)];
};




