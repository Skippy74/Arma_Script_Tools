/**
 * Move a group of units to the diametrically opposite point of a given unit, relative to a marker
 * [unit(object unit), "MarkerName"(string), group(object group), b(bool, optional)] b is a boolean that will reveal/hide the location of the created group.
 *
 * @author		Skippy (jean.battistel@gmail.com)
 * @version 				1.01
 * @param 		array
 * @return 		void
*/

CPC_fnc_setDiametricallyOpposite = {

		private["_i",
			"_unit1PosX",
			"_unit1PosY",
			"_centerX",
			"_centerY",
			"_group",
			"_debug",
			"_marker"];

	_unit1PosX 				= (getPosATL (_this select 0)) select 0;
	_unit1PosY 				= (getPosATL (_this select 0)) select 1;
	_centerX 				= (getMarkerPos (_this select 1)) select 0;
	_centerY 				= (getMarkerPos (_this select 1)) select 1;
	_group 					= _this select 2;
	_debug 					= [_this, 3, false] call CBA_fnc_defaultParam;

	if(_centerX < _unit1PosX) then
	{
		if(_centerY < _unit1PosY) then
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX - (abs(_centerX - _unit1PosX))) + _i, _centerY - (abs(_centerY - _unit1PosY)), 0];
			};
		}
		else
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX - (abs(_centerX - _unit1PosX))) + _i, _centerY + (abs(_centerY - _unit1PosY)), 0];
			};
		};
	}
	else
	{
		if(_centerY > _unit1PosY) then
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX + (abs(_centerX - _unit1PosX))) + _i, _centerY + (abs(_centerY - _unit1PosY)), 0];
			};
		}
		else
		{
			for "_i" from 0 to ((count _group) - 1) step 1 do
			{
				(_group select _i) setPosATL [(_centerX + (abs(_centerX - _unit1PosX))) + _i, _centerY - (abs(_centerY - _unit1PosY)), 0];
			};
		};
	};


	//debug

	if(_debug) then
	{
		_marker = createMarker["mkDebugDiametrically", getPosATL (_group select 1)];
		_marker setMarkerShape "ICON";
		"mkDebugDiametrically" setMarkerType "DOT";
		"mkDebugDiametrically" setMarkerColor "ColorYellow";
		"mkDebugDiametrically" setMarkerSize [2, 2];
		"mkDebugDiametrically"  setMarkerText "Debug Marker fnc_setDiametricallyOpposite"
	};
};



/**
 * Move a group of units randomly on a circle 
 * [center (position), group1 (group), angle(scalar), b(bool, optional)] b is a boolean that will reveal/hide the location of the created group.
 *
 * @author		Skippy (jean.battistel@gmail.com)
 * @version 				1.00
 * @param 		array
 * @return 		void
*/
CPC_fnc_setGroupOnCircleRandom = {

	private["_centerX",
			"_centerY",
			"_centerArray",
			"_group",
			"_angle",
			"_k1",
			"_distCenterToUnit",
			"_unitX",
			"_unitY",
			"_distCenterToUnit",
			"_debug",
			"_marker",
			"_newAngle"];

	_centerX 						= (_this select 0) select 0;
	_centerY 						= (_this select 0) select 1;

	_centerArray					= [_centerX, _centerY];

	_group							= (_this select 1);

	_angle 							= floor(random(_this select 2)) + 1;

	_debug 							= [_this, 3, false] call CBA_fnc_defaultParam;

	_k1 							= (-1)^(floor(random 2)); //1 or -1

	_unitX 							= (getPosATL (_group select 0)) select 0;
	_unitY 							= (getPosATL (_group select 0)) select 1;

	_distCenterXtoUnitX 			= (_unitX - _centerX);
	_distCenterYtoUnitY 			= (_unitY - _centerY);

	_distCenterToUnit 				= _centerArray distance (_group select 0);


	if(_distCenterYtoUnitY >= 0) then
	{
		_newAngle 					= acos(_distCenterXtoUnitX / _distCenterToUnit) + (_k1 * _angle);
	}
	else
	{
		_newAngle 					= (360 - acos(_distCenterXtoUnitX/_distCenterToUnit)) + (_k1 * _angle);
	};

	for "_i" from 0 to ((count _group) - 1) step 1 do
	{
		(_group select _i) setPosATL [_centerX + (_distCenterToUnit * cos(_newAngle)) + _i, _centerY + (_distCenterToUnit * sin(_newAngle)), 0];
	};


	//debug

	if(_debug) then
	{
		(_group select 0) sideChat format[" _distCenterXtoUnitX %1", _distCenterXtoUnitX];
		(_group select 0) sideChat format[" _distCenterToUnit %1", _distCenterToUnit];
		(_group select 0) sideChat format[" nouvel angle : %1", _newAngle];
		(_group select 0) sideChat format["ancienne distance %1", _distCenterToUnit];
		(_group select 0) sideChat format["nouvelle distance %1", (_centerArray distance (_group select 0))];
		
		_marker = createMarker["mkDebugOnCircle", getPosATL (_group select 1)];
		_marker setMarkerShape "ICON";
		"mkDebugOnCircle" setMarkerType "DOT";
		"mkDebugOnCircle" setMarkerColor "ColorRed";
		"mkDebugOnCircle" setMarkerSize [2, 2];
		"mkDebugOnCircle"  setMarkerText "Debug Marker fnc_setRandomGroupOnCircle"
	};
};