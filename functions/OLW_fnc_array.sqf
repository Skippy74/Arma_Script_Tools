/* ************************************************************************** */
	["OLW_fnc_array.sqf (1.06)", 1] call OLW_fnc_debug;
/* ************************************************************************** */




// [array1 (Array), array2 (Array), ...]
// Return mergedArray (Array)
OLW_fnc_arrayMerge = {
	["%1 OLW_fnc_arrayMerge (1.0)", _this , 2] call OLW_fnc_debug;
	
	
	_outputArray 			= [];

	{
		if ((typeName _x) != "ARRAY") exitWith { };

		for [{ _i = 0 }, { _i < count _x }, { _i = _i + 1 }] do {
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
		_item 				= _x select 0;
		_number 			= _x select 1;

		for [{ _i = _number }, { _i > 0 }, { _i = _i - 1 }] do {
			_outputArray set [count _outputArray, _item];
		};
	} foreach _this;
	
	_outputArray
};