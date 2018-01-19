/*
 * ServStat - SQL
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

public void initSQL() {
	char sError[255];
	
	gh_Db = SQL_Connect("servstat", true, sError, sizeof(sError));
	
	if(gh_Db != null) { // Success on connection
		char sQuery[255];
		Format(sQuery, sizeof(sQuery), "CREATE TABLE IF NOT EXISTS servstat_players (ID int NOT NULL AUTO_INCREMENT, SteamID varchar(255), Last_online int);");
		
		if(!SQL_FastQuery(gh_Db, sQuery)) { // Something went wrong!
			char err[255];
			SQL_GetError(gh_Db, err, sizeof(err));
			PrintToServer("Error: %s", err);
		}
		
	} else { // DB connection went wrong
		PrintToServer("### Could not connect to the database! ##");
		PrintToServer("%s", sError);
	}
}

public bool userExists(int client) {
	char sQuery[255];
	char sID[64];
	GetClientAuthId(client, AuthId_Steam2, sID, sizeof(sID));
	
	Format(sQuery, sizeof(sQuery), "SELECT * FROM servstat_players WHERE SteamID LIKE '%s'", sID);
	
	DBResultSet SQL = SQL_Query(gh_Db, sQuery);
	
	if(SQL != null) {
		if(SQL_FetchRow(SQL)) {
			CloseHandle(SQL);
			return true;
		}
	}
	
	return false;
}

public void addUser(int client) { // Adds a user to the servstat_players table
	char sQuery[255];
	char sID[64];
	GetClientAuthId(client, AuthId_Steam2, sID, sizeof(sID));
	
	Format(sQuery, sizeof(sQuery), "INSERT INTO servstat_players (SteamID, Last_online) VALUES ('%s', %d);", sID, GetTime());
	
	if(!SQL_FastQuery(gh_Db, sQuery)) { // Something went wrong!
		char err[255];
		SQL_GetError(gh_Db, err, sizeof(err));
		PrintToServer("Database error: %s", err);
	}
}

public void updateUser(int client) {
	char sQuery[255];
	char sID[64];
	GetClientAuthId(client, AuthId_Steam2, sID, sizeof(sID));
	
	Format(sQuery, sizeof(sQuery), "UPDATE servstat_players SET Last_online = %d WHERE SteamID LIKE '%s'", GetTime(), sID);
	
	if(!SQL_FastQuery(gh_Db, sQuery)) {
		char err[255];
		SQL_GetError(gh_Db, err, sizeof(err));
		PrintToServer("Database error: %s", err);
	}
}

public int getTotalPlayers() {
	char sQuery[255];
	
	Format(sQuery, sizeof(sQuery), "SELECT COUNT (*) FROM servstat_players");
	
	DBResultSet SQL = SQL_Query(gh_Db, sQuery);
	
	if(SQL != null) {
		if(SQL_FetchRow(SQL)) {
			int i = SQL_FetchInt(SQL, 0);
			return i;
		}
	}
	
	return -1;
}



public int getLast31Days() {
	char sQuery[255];
	int time = GetTime() - 2678400; // 2678400 is 31 days in seconds
	
	Format(sQuery, sizeof(sQuery), "SELECT COUNT(*) FROM servstat_players WHERE Last_online > %d", time);
	
	DBResultSet SQL = SQL_Query(gh_Db, sQuery);
	
	if(SQL != null) {
		if(SQL_FetchRow(SQL)) {
			int i = SQL_FetchInt(SQL, 0);
			return i;
		}
	}
	
	return -1;
}