/*
 * ServStat - Stocks
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

stock bool IsValidClient(int client, bool bAllowBots = false, bool bAllowDead = true) {
	if(!(1 <= client <= MaxClients) || !IsClientInGame(client) || (IsFakeClient(client) && !bAllowBots) || IsClientSourceTV(client) || IsClientReplay(client) || (!bAllowDead && !IsPlayerAlive(client)))
	{
		return false;
	}
	return true;
}

stock bool IsClientAdmin(int client) {
	char admflag[32];
	GetConVarString(gc_sAdmFlag, admflag, sizeof(admflag));
	
	if(IsValidClient(client, false, true)) {
		if((GetUserFlagBits(client) & ReadFlagString(admflag) == ReadFlagString(admflag)) || GetUserFlagBits(client) & ADMFLAG_ROOT)
			return true;
	}
	
	return false;
}