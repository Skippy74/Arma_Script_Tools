/* ************************************************************************** */
if !(isNil OLW_fnc_debug) then {
	["OLW_fnc_array.sqf (1.06)", 1] call OLW_fnc_debug;
};
/* ************************************************************************** */




// [array1 (Array), array2 (Array), ...]
// Return mergedArray (Array)
OLW_fnc_arrayMerge = {
	["%1 OLW_fnc_arrayMerge (1.0)", _this, 2] call OLW_fnc_debug;
	
	private ["_OutputArray"];
	_outputArray 			= [];

	{
		if ((typeName _x) != "ARRAY") exitWith { };
		
		{
			_outputArray set [count _outputArray, _x];
		} foreach _x;
	} foreach _this;
	
	_outputArray
};




// [[[whatever1, number1 (Number)], [whatever2, number (scalar2)], ...] (Array)]
// return expandedArray (Array)
OLW_fnc_expandArray = {
	["%1 OLW_fnc_expandArray (1.0)", _this, 2] call OLW_fnc_debug;

	private ["_final"];
	_input 					= _this select 0;
	_output 				= [];
	
	{
		_item 				= _x select 0;
		for [{_i = _x select 1}, {_i > 0}, {_i = _i - 1}] do {
			_output set [count _output, _item];
		};
	} foreach _input;
	
	_output
};