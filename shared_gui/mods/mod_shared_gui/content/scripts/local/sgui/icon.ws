function SGUI_Icon_GetScaledIcon( iconName : string, iconSize : int, optional vspace : int ) : string
{
	var height, width : float;
	var folder : string;
	
	SGUI_Icon_OutIconScale( iconName, iconSize, width, height, folder);
	if( folder == "" )
	{
		return "";
	}
	return "<img src='img://icons/sgui/" + folder + "/" + iconName + ".png' height='" + iconSize + "' width='" + RoundMath(width / height * iconSize) + "' vspace='" + vspace + "'/>";
}

function SGUI_Icon_OutIconScale( iconName : string, iconSize : int, out width : float, out height : float, out folder : string )
{
	//keys
	switch( iconName )
	{
		case "ICO_PlayS_Circle" :
		case "ICO_PlayS_Square" :
		case "ICO_PlayS_Triangle" :
		case "ICO_PlayS_X" :
		case "ICO_PlayS_dpad" :
		case "ICO_PlayS_dpad_up_down" :
		case "ICO_PlayS_dpad_left_right" :
		case "ICO_PlayS_dpad_up" :
		case "ICO_PlayS_dpad_down" :
		case "ICO_PlayS_dpad_left" :
		case "ICO_PlayS_dpad_right" :
		case "ICO_Xbox_A" :
		case "ICO_Xbox_B" :
		case "ICO_Xbox_X" :
		case "ICO_Xbox_Y" :
		case "ICO_Xbox_Home" :
			width = 37.f;
			height = 37.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_A" :
		case "ICO_Steam_B" :
		case "ICO_Steam_X" :
		case "ICO_Steam_Y" :
		case "ICO_Steam_dpad_left_right" :
		case "ICO_Steam_dpad_up" :
		case "ICO_Steam_dpad_down" :
		case "ICO_Steam_dpad_left" :
		case "ICO_Steam_dpad_right" :
		case "ICO_Steam_L" :
		case "ICO_Steam_R" :
		case "ICO_Steam_L_hold" :
		case "ICO_Steam_R_down" :
		case "ICO_Steam_R_scroll" :
		case "ICO_Steam_R_tabs" :
		case "ICO_PlayS_L3" :
		case "ICO_PlayS_L3_hold" :
		case "ICO_PlayS_R3" :
		case "ICO_PlayS_R3_hold" :
		case "ICO_Xbox_dpad" :
		case "ICO_Xbox_dpad_double_up" :
		case "ICO_Xbox_dpad_up" :
		case "ICO_Xbox_dpad_down" :
		case "ICO_Xbox_dpad_left" :
		case "ICO_Xbox_dpad_right" :
		case "ICO_Xbox_dpad_left_right" :
		case "ICO_Xbox_L" :
		case "ICO_Xbox_R" :
			width = 38.f;
			height = 38.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_R_hold" :
			width = 38.f;
			height = 40.f;
			folder = "keys";
		return;
		
		case "ICO_Xbox_L_hold" :
		case "ICO_Xbox_R_hold" :
			width = 38.f;
			height = 42.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L3_down" :
		case "ICO_PlayS_R3_down" :
		case "ICO_PlayS_L3_up" :
		case "ICO_PlayS_R3_up" :
		case "ICO_Xbox_L_down" :
		case "ICO_Xbox_R_down" :
		case "ICO_Xbox_L_up" :
		case "ICO_Xbox_R_up" :
			width = 38.f;
			height = 45.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_L_scroll" :
			width = 38.f;
			height = 46.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L3_scroll" :
		case "ICO_PlayS_R3_scroll" :
		case "ICO_Xbox_L_scroll" :
		case "ICO_Xbox_R_scroll" :
			width = 38.f;
			height = 50.f;
			folder = "keys";
		return;
		
		case "Mouse_LeftBtn" :
		case "Mouse_MiddleBtn" :
		case "Mouse_RightBtn" :
			width = 40.f;
			height = 40.f;
			folder = "keys";
		return;
		
		case "Mouse_ScrollDown" :
		case "Mouse_ScrollUp" :
			width = 40.f;
			height = 46.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_Start" :
			width = 41.f;
			height = 23.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_Touchpad" :
			width = 42.f;
			height = 27.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L3_left" :
		case "ICO_PlayS_L3_right" :
		case "ICO_PlayS_R3_left" :
		case "ICO_PlayS_R3_right" :
		case "ICO_Xbox_L_left" :
		case "ICO_Xbox_L_right" :
		case "ICO_Xbox_R_left" :
		case "ICO_Xbox_R_right" :
			width = 45.f;
			height = 38.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_Share" :
			width = 45.f;
			height = 47.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_L_tabs" :
			width = 46.f;
			height = 38.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L3_tabs" :
		case "ICO_PlayS_R3_tabs" :
		case "ICO_Xbox_L_tabs" :
		case "ICO_Xbox_R_tabs" :
			width = 50.f;
			height = 38.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_Options" :
			width = 57.f;
			height = 47.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_LT" :
		case "ICO_Steam_RT" :
			width = 36.f;
			height = 34.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_LB" :
			width = 36.f;
			height = 28.f;
			folder = "keys";
		return;
		
		case "ICO_Steam_RB" :
			width = 36.f;
			height = 28.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L1" :
		case "ICO_PlayS_R1" :
			width = 36.f;
			height = 21.f;
			folder = "keys";
		return;
		
		case "ICO_Xbox_RB" :
			width = 31.f;
			height = 21.f;
			folder = "keys";
		return;
		
		case "ICO_Xbox_LB" :
			width = 30.f;
			height = 21.f;
			folder = "keys";
		return;
		
		case "ICO_Xbox_Back" :
		case "ICO_Xbox_Start" :
			width = 29.f;
			height = 29.f;
			folder = "keys";
		return;
		
		case "ICO_PlayS_L2" :
		case "ICO_PlayS_R2" :
			width = 28.f;
			height = 22.f;
			folder = "keys";
		return;
		
		case "ICO_Xbox_LT" :
		case "ICO_Xbox_RT" :
			width = 23.f;
			height = 22.f;
			folder = "keys";
		return;
		
		default :
		break;
	}
	
	//maps
	switch( iconName )
	{
		case "RoadSign" :
			width = 66.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "Harbor" :
			width = 72.f;
			height = 78.f;
			folder = "maps";
		return;
		
		case "Teleport" :
			width = 83.f;
			height = 81.f;
			folder = "maps";
		return;
		
		case "Rift" :
			width = 83.f;
			height = 81.f;
			folder = "maps";
		return;
		
		case "AlchemyTable" :
			width = 81.f;
			height = 114.f;
			folder = "maps";
		return;
		
		case "Bed" :
			width = 93.f;
			height = 81.f;
			folder = "maps";
		return;
		
		case "Bookshelf" :
			width = 96.f;
			height = 88.f;
			folder = "maps";
		return;
		
		case "Brewery" :
			width = 100.f;
			height = 78.f;
			folder = "maps";
		return;
		
		case "Equipment" :
			width = 83.f;
			height = 98.f;
			folder = "maps";
		return;
		
		case "Fistfight" :
			width = 101.f;
			height = 101.f;
			folder = "maps";
		return;
		
		case "Goal" :
			width = 70.f;
			height = 75.f;
			folder = "maps";
		return;
		
		case "Goal_Boat" :
			width = 94.f;
			height = 78.f;
			folder = "maps";
		return;
		
		case "MagicLamp" :
			width = 53.f;
			height = 79.f;
			folder = "maps";
		return;
		
		case "Stables" :
			width = 95.f;
			height = 95.f;
			folder = "maps";
		return;
		
		case "Tent" :
			width = 97.f;
			height = 79.f;
			folder = "maps";
		return;
		
		case "WolfMedallion_Reacting" :
			width = 94.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "KaerMorhen" :
			width = 115.f;
			height = 101.f;
			folder = "maps";
		return;
		
		case "Novigrad" :
		case "Skellige" :
		case "Toussaint" :
		case "Velen" :
		case "WhiteOrchard" :
		case "Wyzima" :
			width = 100.f;
			height = 105.f;
			folder = "maps";
		return;
		
		case "PlayerMarker" :
			width = 43.f;
			height = 64.f;
			folder = "maps";
		return;
		
		case "CustomMarker_Green" :
			width = 99.f;
			height = 97.f;
			folder = "maps";
		return;
		
		case "CustomMarker_Red" :
		case "CustomMarker_Orange" :
		case "CustomMarker_Blue" :
			width = 83.f;
			height = 83.f;
			folder = "maps";
		return;
		
		case "PlayerStash" :
			width = 84.f ;
			height = 98.f;
			folder = "maps";
		return;
		
		case "NoticeBoard" :
			width = 54.f ;
			height = 66.f;
			folder = "maps";
		return;
		
		case "NoticeBoardFull" :
			width = 78.f ;
			height = 74.f;
			folder = "maps";
		return;
		
		case "Horse" :
			width = 62.f;
			height = 83.f;
			folder = "maps";
		return;
		
		case "Boat" :
			width = 77.f;
			height = 68.f;
			folder = "maps";
		return;
		
		case "Herb" :
			width = 45.f;
			height = 50.f;
			folder = "maps";
		return;
		
		case "Shopkeeper" :
			width = 49.f;
			height = 77.f;
			folder = "maps";
		return;
		
		case "Blacksmith" :
			width = 70.f;
			height = 75.f;
			folder = "maps";
		return;
		
		case "Armorer" :
			width = 60.f;
			height = 88.f;
			folder = "maps";
		return;
		
		case "Hairdresser" :
			width = 82.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "Alchemic" :
			width = 52.f;
			height = 78.f;
			folder = "maps";
		return;
		
		case "Herbalist" :
			width = 66.f;
			height = 74.f;
			folder = "maps";
		return;
		
		case "Innkeeper" :
			width = 57.f;
			height = 65.f;
			folder = "maps";
		return;
		
		case "Enchanter" :
			width = 119.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "Cammerlengo" :
			width = 97.f;
			height = 109.f;
			folder = "maps";
		return;
		
		case "Prostitute" :
			width = 72.f;
			height = 64.f;
			folder = "maps";
		return;
		
		case "Whetstone" :
			width = 85.f;
			height = 70.f;
			folder = "maps";
		return;
		
		case "ArmorRepairTable" :
			width = 73.f;
			height = 67.f;
			folder = "maps";
		return;
		
		case "QuestAvailable" :
			width = 20.f;
			height = 79.f;
			folder = "maps";
		return;
		
		case "QuestAvailableHoS" :
			width = 22.f;
			height = 83.f;
			folder = "maps";
		return;
		
		case "QuestAvailableBaW" :
			width = 19.f;
			height = 72.f;
			folder = "maps";
		return;
		
		case "QuestMarker" :
			width = 69.f;
			height = 69.f;
			folder = "maps";
		return;
		
		case "NotDiscoveredPOI" :
			width = 49.f;
			height = 87.f;
			folder = "maps";
		return;
		
		case "Entrance" :
			width = 61.f;
			height = 59.f;
			folder = "maps";
		return;
		
		case "PlaceOfPower" :
		case "PlaceOfPowerDisabled" :
			width = 75.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "TreasureHuntMappin" :
			width = 62.f;
			height = 96.f;
			folder = "maps";
		return;
		
		case "TreasureHuntMappinDisabled" :
			width = 53.f;
			height = 79.f;
			folder = "maps";
		return;
		
		case "Contraband" :
		case "ContrabandDisabled" :
			width = 77.f;
			height = 81.f;
			folder = "maps";
		return;
		
		case "BanditCamp" :
			width = 58.f;
			height = 86.f;
			folder = "maps";
		return;
		
		case "BanditCampDisabled" :
			width = 51.f;
			height = 77.f;
			folder = "maps";
		return;
		
		case "SpoilsOfWar" :
		case "SpoilsOfWarDisabled" :
			width = 83.f;
			height = 92.f;
			folder = "maps";
		return;
		
		case "BossAndTreasure" :
			width = 57.f;
			height = 87.f;
			folder = "maps";
		return;
		
		case "BossAndTreasureDisabled" :
			width = 61.f;
			height = 94.f;
			folder = "maps";
		return;
		
		case "MonsterNest" :
			width = 65.f;
			height = 87.f;
			folder = "maps";
		return;
		
		case "MonsterNestDisabled" :
			width = 60.f;
			height = 80.f;
			folder = "maps";
		return;
		
		case "BanditCampfire" :
		case "BanditCampfireDisabled" :
			width = 75.f;
			height = 80.f;
			folder = "maps";
		return;
		
		case "RescuingTown" :
		case "RescuingTownDisabled" :
			width = 86.f;
			height = 88.f;
			folder = "maps";
		return;
		
		case "DungeonCrawl" :
			width = 89.f;
			height = 81.f;
			folder = "maps";
		return;
		
		case "DungeonCrawlDisabled" :
			width = 82.f;
			height = 74.f;
			folder = "maps";
		return;
		
		case "Hideout" :
			width = 81.f;
			height = 82.f;
			folder = "maps";
		return;
		
		case "HideoutDisabled" :
			width = 60.f;
			height = 61.f;
			folder = "maps";
		return;
		
		case "Plegmund" :
			width = 48.f;
			height = 95.f;
			folder = "maps";
		return;
		
		case "PlegmundDisabled" :
			width = 42.f;
			height = 90.f;
			folder = "maps";
		return;
		
		case "KnightErrant" :
			width = 81.f;
			height = 85.f;
			folder = "maps";
		return;
		
		case "KnightErrantDisabled" :
			width = 73.f;
			height = 79.f;
			folder = "maps";
		return;
		
		case "InfestedVineyard" :
			width = 93.f;
			height = 108.f;
			folder = "maps";
		return;
		
		case "InfestedVineyardDisabled" :
			width = 62.f;
			height = 93.f;
			folder = "maps";
		return;
		
		case "WineContract" :
			width = 59.f;
			height = 91.f;
			folder = "maps";
		return;
		
		case "WineContractDisabled" :
			width = 63.f;
			height = 89.f;
			folder = "maps";
		return;
		
		case "SignalingStake" :
		case "SignalingStakeDisabled" :
			width = 44.f;
			height = 85.f;
			folder = "maps";
		return;
		
		case "Torch" :
			width = 110.f;
			height = 98.f;
			folder = "maps";
		return;
		
		case "House" :
			width = 111.f;
			height = 99.f;
			folder = "maps";
		return;
		
		case "Footprints" :
			width = 23.f;
			height = 35.f;
			folder = "maps";
		return;
		
		default :
		break;
	}
	
	//others
	switch( iconName )
	{
		case "square_white" :
			width = 12.f;
			height = 12.f;
			folder = "others";
		return;
		
		case "triangle_green" :
		case "triangle_red" :
			width = 22.f;
			height = 16.f;
			folder = "others";
		return;
		
		case "socket_equipped" :
			width = 29.f;
			height = 29.f;
			folder = "others";
		return;
		
		case "socket_empty" :
			width = 30.f;
			height = 30.f;
			folder = "others";
		return;
		
		case "hammer_red" :
			width = 30.f;
			height = 34.f;
			folder = "others";
		return;
		
		case "hammer_green" :
			width = 36.f;
			height = 41.f;
			folder = "others";
		return;
		
		case "enchant" :
			width = 37.f;
			height = 39.f;
			folder = "others";
		return;
		
		case "crown_brown" :
		case "crown_gray" :
		case "hammer_gray" :
		case "weight_gray" :
			width = 40.f;
			height = 40.f;
			folder = "others";
		return;
		
		case "foods_and_trophis_white" :
			width = 43.f;
			height = 45.f;
			folder = "others";
		return;
		
		case "crown_white" :
			width = 44.f;
			height = 42.f;
			folder = "others";
		return;
		
		case "equipments_white.png" :
			width = 45.f;
			height = 43.f;
			folder = "others";
		return;
		
		case "ingredients_white" :
			width = 45.f;
			height = 46.f;
			folder = "others";
		return;
		
		case "alchemy_items_white" :
			width = 46.f;
			height = 48.f;
			folder = "others";
		return;
		
		case "quest_items_white" :
			width = 48.f;
			height = 41.f;
			folder = "others";
		return;
		
		case "eye" :
			width = 36.f;
			height = 22.f;
			folder = "others";
		return;
		
		case "stat_armor" :
			width = 28.f;
			height = 34.f;
			folder = "others";
		return;
		
		case "stat_toxity" :
			width = 30.f;
			height = 38.f;
			folder = "others";
		return;
		
		case "stat_stamina" :
			width = 32.f;
			height = 41.f;
			folder = "others";
		return;
		
		case "stat_vitality" :
			width = 34.f;
			height = 33.f;
			folder = "others";
		return;
		
		case "stat_additional" :
			width = 36.f;
			height = 29.f;
			folder = "others";
		return;
		
		case "stat_sign" :
			width = 37.f;
			height = 34.f;
			folder = "others";
		return;
		
		case "stat_crossbow" :
			width = 37.f;
			height = 35.f;
			folder = "others";
		return;
		
		case "stat_silver" :
		case "stat_steel" :
			width = 38.f;
			height = 37.f;
			folder = "others";
		return;
		
		case "lock_white" :
			width = 41.f;
			height = 53.f;
			folder = "others";
		return;
		
		case "inv_white" :
		case "inv_gray" :
			width = 51.f;
			height = 57.f;
			folder = "others";
		return;
		
		case "stash_white" :
		case "stash_gray" :
			width = 51.f;
			height = 59.f;
			folder = "others";
		return;
		
		default : 
		break;
	}
}