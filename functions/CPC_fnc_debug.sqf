/* ************************************************************************** */ 
	["CPC_fnc_debug.sqf (1.01)", 1] call CPC_fnc_debug;
/* ************************************************************************** */




/**
 * Gets a ’message’ and send it to sideChat if the associated ’messageLevel’ 
 * complies with the ’MISSION_debugLevel’ global parameter.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		string 		message
 * @param 		any 		(optional) params that can be inserted into 
 * 							’message’ via the ’format’ command 
 * @param 		number 		messageLevel
 */
CPC_fnc_debug = {


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




/**
 * Gets debugMessage (message, optional values, messageLevel) associated to an
 * UID to ensure that the message is displayed only once. 
 * 
 * Great to track variables’ modifications at the start of a loop 
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		string 		message
 * @param 		any 		(optional) params that can be inserted into 
 * 							’message’ via the ’format’ command 
 * @param 		number 		messageLevel
 * @param 		string 		uniqueIdentity
 */
// [message (String), level (Number), unique ID (Number)]
CPC_debugArray 				= [];
CPC_fnc_debugOnce = {


	_uID 					= _this call BIS_fnc_arrayPop;
	
	if !(_uID in CPC_debugArray) then {
		CPC_debugArray set [count CPC_debugArray, _uID];
		publicVariable "CPC_debugArray";

		_this call CPC_fnc_debug;
	};
};




/**
 * Stops execution of a script or a function and send a warning message to 
 * sideChat.
 * 
 * @author 					la_Vieille (laVieille.fr@gmail.com)
 * @version 				1.01
 * @param 		string 		message
 * @param 		any 		(optional) params that can be inserted into 
 * 							’message’ via the ’format’ command 
 * @param 		string 		name of calling function or script
 */
scopeName "CPC_fatal";
CPC_fnc_fatal = {


	_argc 					= count _this;
	_message 				= format _this;

	_message 				= format ["[FATAL in %2] %1", _message, _this select (_argc - 1)];
	
	player sideChat _message;
	breakTo "CPC_fatal";
};




