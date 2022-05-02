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
	local XComGameStateHistory History;

	MissionManager = `TACTICALMISSIONMGR;
	History = `XCOMHISTORY;

	class'X2DownloadableContentInfo_BetterFortressMusic'.static.SetMusicOverrideForMission(
		History.GetStartState(),
		MissionManager.ActiveMission.sType
	);

	return ELR_NoInterrupt;
}
