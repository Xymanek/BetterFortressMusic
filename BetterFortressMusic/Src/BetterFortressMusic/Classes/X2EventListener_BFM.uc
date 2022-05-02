class X2EventListener_BFM extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates ()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListeners());

	return Templates;
}

static function CHEventListenerTemplate CreateListeners ()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'BetterFortressMusic');
	Template.AddCHEvent('PostAliensSpawned', PostAliensSpawned, ELD_Immediate);
	Template.RegisterInTactical = true;

	return Template;
}

static protected function EventListenerReturn PostAliensSpawned (Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComTacticalMissionManager MissionManager;
	local XComGameState_Cheats CheatState;

	MissionManager = `TACTICALMISSIONMGR;

	if (MissionManager.ActiveMission.sType == "GP_FortressLeadup")
	{
		CheatState = class'XComGameState_Cheats'.static.GetCheatsObject();
		CheatState.TacticalMusicSetOverride = 'LostTowerA';
	}
	else if (MissionManager.ActiveMission.sType == "GP_FortressShowdown")
	{
		CheatState = class'XComGameState_Cheats'.static.GetCheatsObject();
		CheatState.TacticalMusicSetOverride = 'LostTower_BossFight';
	}

	return ELR_NoInterrupt;
}
