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
	
	
	
	return Plugin_Continue;
}