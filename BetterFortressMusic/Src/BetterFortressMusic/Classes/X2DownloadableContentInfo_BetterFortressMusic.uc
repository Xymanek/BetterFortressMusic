class X2DownloadableContentInfo_BetterFortressMusic extends X2DownloadableContentInfo;

struct EBFMMissionMusicSetOverride
{
	var string MissionType;
	var name MusicSet;
};

var config array<EBFMMissionMusicSetOverride> MusicOverrides;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame ()
{
	// TODO
}

static function SetMusicOverrideForMission (XComGameState NewGameState, string MissionType)
{
	local XComGameState_Cheats CheatState;
	local int i;

	i = default.MusicOverrides.Find('MissionType', MissionType);
	if (i == INDEX_NONE) return;

	CheatState = class'XComGameState_Cheats'.static.GetCheatsObject(); // We want this only for ObjectID, so don't care about history index
	if (CheatState == none)
	{
		`RedScreen(GetFuncName() @ "CheatState == none");
		return;
	}

	CheatState = XComGameState_Cheats(NewGameState.ModifyStateObject(class'XComGameState_Cheats', CheatState.ObjectID));
	CheatState.TacticalMusicSetOverride = default.MusicOverrides[i].MusicSet;
}
