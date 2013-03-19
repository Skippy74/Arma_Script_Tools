/* ************************************************************************** */
	["OLW_fnc_bitwise.sqf (1.06)", 1] call OLW_fnc_debug;
/* ************************************************************************** */




// [pattern (Number)]
// return NUMBER
OLW_fnc_bitwiseNot = {
	["%1 OLW_fnc_bitwiseNot (1.0)", _this, 2] call OLW_fnc_debug;

	_pattern				= _this select 0;
	_final					= 0;
	_i						= 0;
	
	while {_pattern != 0} do {
		
		// Bitwise NOT is the 1 complement of the least significant bit
		_bit				= 1 - (_pattern % 2);
		_final				= _final + ((2 ^ _i) * _bit);

		_pattern			= floor (_pattern / 2);
		_i					= _i + 1;
	};
	
	_final
};




// [pattern (Number), mask (Number)]
// return NUMBER
OLW_fnc_bitwiseAnd = {
	["%1 OLW_fnc_bitwiseAnd (1.0)", _this, 2] call OLW_fnc_debug;

	_pattern				= _this select 0;
	_mask					= _this select 1;
	_final					= 0;
	_i						= 0;
	
	while {(_pattern != 0) AND (_mask != 0)} do {
		
		// Bitwise NOT is the product of the least significant bits
		_bit				= (_pattern % 2) * (_mask % 2);
		_final				= _final + ((2 ^ _i) * _bit);

		_pattern			= floor (_pattern / 2);
		_mask				= floor (_mask / 2);
		_i					= _i + 1;
	};
	
	_final
};




// [pattern (Number), mask (Number)]
// return NUMBER
OLW_fnc_bitwiseOr = {
	["%1 OLW_fnc_bitwiseOr (1.0)", _this, 2] call OLW_fnc_debug;

	_pattern				= _this select 0;
	_mask					= _this select 1;
	_final					= 0;
	_i						= 0;
	
	while {(_pattern != 0) OR (_mask != 0)} do {
		
		_bit 				= 0;

		if ((_pattern % 2 != 0) OR (_mask % 2 != 0)) then {
			_bit			=  1;
		};

		_final				= _final + ((2 ^ _i) * _bit);
		_pattern			= floor (_pattern / 2);
		_mask				= floor (_mask / 2);
		_i					= _i + 1;
	};
	
	_final
};




// [pattern (Number), mask (Number)]
// return NUMBER
OLW_fnc_bitwiseXor = {
	["%1 OLW_fnc_bitwiseXor (1.0)", _this, 2] call OLW_fnc_debug;

	_pattern				= _this select 0;
	_mask					= _this select 1;
	_final					= 0;
	_i						= 0;
	
	while {(_pattern != 0) OR (_mask != 0)} do {
		
		_bit				= ((_pattern % 2) + (_mask % 2)) % 2;
		_final				= _final + ((2 ^ _i) * _bit);
		
		_pattern			= floor (_pattern / 2);
		_mask				= floor (_mask / 2);
		_i					= _i + 1;
	};
	
	_final
};



