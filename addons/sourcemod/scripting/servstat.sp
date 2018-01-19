/*
 * ServStat
 * By: Hypr
 * https://github.com/condolent/servstat/
 * 
 * Copyright (C) 2017 Jonathan Öhrström (Hypr/Condolent)
 *
 * This file is part of the ServStat SourceMod Plugin.
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License, version 3.0, as published by the
 * Free Software Foundation.
 */

#include <sourcemod>
#include <sdktools>
#include <colorvariables>
#include <autoexecconfig>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "1.0"

// Strings
char g_sPrefix[] = "{gold}[ServStat]{blue}";

// Handles
Database gh_Db;

// CVars
ConVar gc_sAdmFlag;

#include "ServStat/sql.sp"
#include "ServStat/stocks.sp"
#include "ServStat/commands.sp"

public Plugin myinfo = {
	name = "ServStat",
	author = "Hypr",
	description = "Track player statistics on your server!",
	version = PLUGIN_VERSION,
	url = "https://condolent.xyz"
};

public void OnPluginStart() {
	
	// CVars
	AutoExecConfig_SetFile("servstat");
	AutoExecConfig_SetCreateFile(true);
	gc_sAdmFlag = AutoExecConfig_CreateConVar("sm_servstat_admin", "b", "The flag necessary to use the commands for this plugin.", FCVAR_NOTIFY);
	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();

	initSQL(); // init Database
	
	for(int i = 1; i <= MaxClients; i++) { // Check all clients on start, to see if they're registered
		if(!IsValidClient(i))
			continue;
		if(!userExists(i))
			addUser(i);
	}
	
	RegConsoleCmd("sm_servstat", Command_Core);
	
}

public void OnClientPutInServer(int client) {
	if(IsValidClient(client))
		if(!userExists(client)) // If a connecting client is not registered, then register!
			addUser(client);
}