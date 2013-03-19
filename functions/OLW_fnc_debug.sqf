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
	_messageLevel 			= _this select ((count _this) - 1);

	
	// if messageLevel > debugLevel, there is no need to make further tests
	if (_messageLevel > MISSION_debugLevel) exitWith {}; 

	_pattern				= _messageLevel;
	_mask					= MISSION_debugLevel;
	_result					= 0;
	_i						= 0;
	
	
	// bitwise AND
	while {(_pattern != 0) AND (_mask != 0)} do {
		_bit				= (_pattern % 2) * (_mask % 2);
		_result				= _result + ((2 ^ _i) * _bit);

		_pattern			= floor (_pattern / 2);
		_mask				= floor (_mask / 2);
		_i					= _i + 1;
	};
	
	
	// print message if debugLevel permits it
	if (_messageLevel == _result) then {
		_message 			= format _this;

		// add blank spaces before the message
		//[errorLevel 0 : blabla]
		//[    errorLevel 16 : blabla]
		while {_i > 0} do {
			_message 		= format ["  %1", _message];
			_i 				= _i - 1;
		};

		//send message to sidechat
		player sidechat _message;
	};
};




// [message (String), level (Number), unique ID (Number)]
OLW_debugArray 				= [];
OLW_fnc_debugOnce = {


	_uID 					= _this call BIS_fnc_arrayPop;
	
	if (!(_uID in OLW_debugArray)) then {
		OLW_debugArray set [count OLW_debugArray, _uID];
		publicVariable "OLW_debugArray";

		_this call OLW_fnc_debug;
	};
};




// [message (String)]
OLW_fnc_fatal = {


	_argc 					= count _this;
	_message 				= format _this;

	_message 				= format ["[FATAL in %2] %1", _message, _this select (_argc - 1)];
	
	player sideChat _message;
	breakTo "OLW_mission_floor";
};




