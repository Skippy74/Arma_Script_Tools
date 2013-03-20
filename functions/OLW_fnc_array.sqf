/* ************************************************************************** */
	["OLW_fnc_array.sqf (1.06)", 1] call OLW_fnc_debug;
/* ************************************************************************** */




// [array1 (Array), array2 (Array), ...]
// Return mergedArray (Array)
OLW_fnc_arrayMerge = {
	["%1 OLW_fnc_arrayMerge (1.0)", _this , 2] call OLW_fnc_debug;
	
	
	_outputArray 			= [];

	{
		assert (_x call OLW_fnc_isArray);
		
		for "_i" from 0 to ((count _x) - 1) do {
			_outputArray set [count _outputArray, _x select _i];
		};
	} foreach _this;
	
	_outputArray
};




// [[whatever1, number (Number)], [whatever2, number (Number)], ...]
// return expandedArray (Array)
OLW_fnc_expandArray = {
	["%1 OLW_fnc_expandArray (1.0)", _this , 2] call OLW_fnc_debug;

	
	_outputArray 			= [];
	
	{
		assert (_x call OLW_fnc_isArray);

		_item 				= _x select 0;
		_number 			= _x select 1;

		for "_i" from 1 to _number do {
			_outputArray set [count _outputArray, _item];
		};
	} foreach _this;
	
	_outputArray
};




// [array (Array)]
// return BOOL
OLW_fnc_isArray = {
	["%1 OLW_fnc_isArray (1.0)", _this , 2] call OLW_fnc_debug;

	
	((typeName _this) == "ARRAY")
};



