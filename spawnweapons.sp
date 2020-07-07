#include <sourcemod>
#include <cstrike>
#include <smlib>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
	name = "Spawn Weapons",
	author = "Clarkey",
	description = "Gives weapons on spawn",
	version = "1.0",
	url = "http://finalrespawn.com"
};

public void OnPluginStart()
{
	HookEvent("player_spawn", Event_PlayerSpawn);
}

public Action Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int ClientUserId = GetEventInt(event, "userid");
	int Client = GetClientOfUserId(ClientUserId);
	
	Client_RemoveAllWeapons(Client);
	CreateTimer(0.1, Timer_GiveWeapons, ClientUserId);
}

public Action Timer_GiveWeapons(Handle timer, any data)
{
	int Client = GetClientOfUserId(data);
	int Team = GetClientTeam(Client);
	
	if (Team == CS_TEAM_CT)
	{
		GivePlayerItem(Client, "weapon_hkp2000");
		GivePlayerItem(Client, "weapon_knife");
	}
	else if (Team == CS_TEAM_T)
	{
		GivePlayerItem(Client, "weapon_glock");
		GivePlayerItem(Client, "weapon_knife_t");
	}
}