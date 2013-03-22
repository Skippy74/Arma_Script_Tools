/**
 * Set a Group of units to the diametrically opposite point of a given unit, relative to a marker
 * [unit, "MarkerName", group, b(optional)] b is a boolean that will reveal/hide the location of the created group.
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