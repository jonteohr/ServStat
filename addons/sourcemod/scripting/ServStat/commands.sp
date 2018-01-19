/*
 * ServStat - Commands
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

public Action Command_Core(int client, int args) {
	if(!IsValidClient(client))
		return Plugin_Handled;
	if(!IsClientAdmin(client)) {
		CPrintToChat(client, "%s You do not have enough privileges to execute this command.", g_sPrefix);
		return Plugin_Handled;
	}
	
	if(args < 1) {
		CPrintToChat(client, "%s Type", g_sPrefix);
		CPrintToChat(client, "%s {green}!servstat help", g_sPrefix);
		CPrintToChat(client, "%s for syntax guidance", g_sPrefix);
	} else if(args >= 1) {
		char arg[64]; // First argument
		GetCmdArg(1, arg, sizeof(arg));
		
		if(StrEqual(arg, "help", false)) {
			CPrintToChat(client, "%s ----------------------------------------------", g_sPrefix);
			CPrintToChat(client, "%s Available commands:", g_sPrefix);
			CPrintToChat(client, "%s {green}!servstat month", g_sPrefix);
			CPrintToChat(client, "%s    Retrieves player statistics from the last month");
			CPrintToChat(client, "%s {green}!servstat total", g_sPrefix);
			CPrintToChat(client, "%s    Retrieves player statistics from when the plugin started tracking", g_sPrefix);
			CPrintToChat(client, "%s ----------------------------------------------", g_sPrefix);
		}
		
		if(StrEqual(arg, "monthly", false)) {
			
		}
		
		if(StrEqual(arg, "total", false)) {
			int total = getTotalPlayers();
			
			CPrintToChat(client, "%s There's been a total of %d players since the tracking started!", g_sPrefix, total);
		}
		
	}
	
	
	
	return Plugin_Handled;
}