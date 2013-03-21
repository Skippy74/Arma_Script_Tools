 
 +---------------------------------------------------------------+
 |                       ARMA_SCRIPT_TOOLS                       |
 +---------------------------------------------------------------+
 |                                                               |
 | a collection of functions for various ArmA2 missions projects |
 |                                                               |
 +---------------------------------------------------------------+


HOW TO USE
----------

1. Copy the folder "functions" into your mission's folder
2. Load the desired file with the command (replace XXXXXXX by the desired library file) :

    _script = [] execVM "scripts\functions\CPC_fnc_XXXXXXX.sqf";  
    waitUntil { scriptDone _script };

3. Call the desired function with the command (replace XXXXXXX by the desired function's name and replace params with the required function's parameters) :

    [params] call CPC_fnc_XXXXXXX


IF YOU WANT TO STAY UP-TO-DATE
------------------------------

1. Sync the online repository with your local copy, using Github or similar software
2. Place a symbolic link into your mission's folder, pointing to your local copy of sync'ed repo, using the following command :
    mklink /d /j TARGET SOURCE