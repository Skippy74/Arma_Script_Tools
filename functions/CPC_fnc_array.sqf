/* ************************************************************************** */
	["CPC_fnc_array.sqf (1.06)", 1] call CPC_fnc_debug;
/* ************************************************************************** */




/**
 * Gets any number of arrays and merges their items in an unique returned array.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array 		(any number of)
 * @return 		array
 */
CPC_fnc_arrayMerge = {
	["%1 CPC_fnc_arrayMerge (1.01)", _this , 2] call CPC_fnc_debug;
	
	
	_outputArray 			= [];

	{
		assert (_x call CPC_fnc_isArray);
		
		for "_i" from 0 to ((count _x) - 1) do {
			_outputArray set [count _outputArray, _x select _i];
		};
	} foreach _this;
	
	_outputArray
};




/**
 * Copies an element by the specified number of times into a new array that is
 * returned.
 * 
 * Useful to quickly associate any element to a probability (see @example).
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array 		(any number of) two items array : [element, number]
 * @return 		array 		the final array contains ’number’ times each
 * 							’element’
 *
 * @example 				we need to spawn a soldier and would like his
 * 							className to be random (say 5% leader, 20% AR,
 * 							25% RPG, 50% soldier). All we have to do is to send
 * 							these values to the function and to select a random
 * 							item in the returned array :
 * 
 * _expandedArray = [["TK_INS_Soldier_TL_EP1", 5], ["TK_INS_Soldier_AR_EP1", 20], ["TK_INS_Soldier_AT_EP1", 25], ["TK_INS_Soldier_EP1", 60]] call CPC_fnc_expandArray;
 * _mySoldier = _expandedArray select (floor (random (count _expandedArray)));
 * 
 */
CPC_fnc_expandArray = {
	["%1 CPC_fnc_expandArray (1.01)", _this , 2] call CPC_fnc_debug;

	
	_outputArray 			= [];
	
	{
		assert (_x call CPC_fnc_isArray);

		_item 				= _x select 0;
		_number 			= _x select 1;

		for "_i" from 1 to _number do {
			_outputArray set [count _outputArray, _item];
		};
	} foreach _this;
	
	_outputArray
};




/**
 * Returns TRUE if argument is an array.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		array
 * @return 		bool
 */
CPC_fnc_isArray = {
	["%1 CPC_fnc_isArray (1.01)", _this , 2] call CPC_fnc_debug;

	
	((typeName _this) == "ARRAY")
};



