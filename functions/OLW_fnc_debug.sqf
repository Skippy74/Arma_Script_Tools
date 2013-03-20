/* ************************************************************************** */ 
	["OLW_fnc_debug.sqf (1.01)", 1] call OLW_fnc_debug;
/* ************************************************************************** */




// [message (String), level (Number)]
OLW_fnc_debug = {


	// 0 : tous les messages
	// 1 : Files Trace
	// 2 : Functions Trace
	// 3 : --
	// 4 : Variables Dump
	_messageLevel 			= _this call BIS_fnc_arrayPop;

	
	// if messageLevel > debugLevel, there is no need to make further tests
	if (_messageLevel > MISSION_debugLevel) exitWith {}; 

	
	// bitwise AND
	_pattern				= _messageLevel;
	_mask					= MISSION_debugLevel;
	_result					= 0;
	_i						= 0;
	
	while {(_pattern != 0) AND (_mask != 0)} do {
		_bit				= (_pattern % 2) * (_mask % 2);
		_result				= _result + ((2 ^ _i) * _bit);

		_pattern			= floor (_pattern / 2);
		_mask				= floor (_mask / 2);
		_i					= _i + 1;
	};
	
	
	// message is printed
	if (_messageLevel != _result) exitWith {}; 
	

	// add blank spaces before the message
	//[errorLevel 0 : foo]
	//[    errorLevel 16 : bar]
	_message 				= format _this;
	for "_j" from 1 to _i do {
		_message 			= format ["  %1", _message];
	};

	
	//send message to sidechat
	player sidechat _message;
};




// [message (String), level (Number), unique ID (Number)]
OLW_debugArray 				= [];
OLW_fnc_debugOnce = {


	_uID 					= _this call BIS_fnc_arrayPop;
	
	if !(_uID in OLW_debugArray) then {
		OLW_debugArray set [count OLW_debugArray, _uID];
		publicVariable "OLW_debugArray";

		_this call OLW_fnc_debug;
	};
};




// [message (String), calling function (String)]
scopeName "OLW_fatal";
OLW_fnc_fatal = {


	_argc 					= count _this;
	_message 				= format _this;

	_message 				= format ["[FATAL in %2] %1", _message, _this select (_argc - 1)];
	
	player sideChat _message;
	breakTo "OLW_fatal";
};




