/*
exec function sgui_test_1()
{
	var popupData : SGUI_W3LootPopupData = new SGUI_W3LootPopupData in theGame;
	var contents : SGUI_Loot_Struct_EntryContents;
	var i : int;
	
	for( i=0; i<16; i+=1 )
	{
		contents.sgui_lsec_id_str = "id_str: " + i;
		contents.sgui_lsec_label = "Label " + i;
		contents.sgui_lsec_subLabel = "subLabel " + i;
		SGUI_Loot_PushContents(popupData, contents);
	}
	
	SGUI_Loot_OpenPopup(popupData);
}

@wrapMethod(SGUI_CR4LootPopup) function OnSelect( index : int, id_str : string, id_name : name, id_item : SItemUniqueId ) : void
{
	var notificationData : SGUI_W3NotificationData = new SGUI_W3NotificationData in theGame;
	var i : int;
	
	notificationData.messageText = id_str;
	notificationData.x = 0.1;
	notificationData.y = index * 0.1;
	notificationData.alpha = 0.6;
	for( i=0; i<index; i+=1 )
	{
		notificationData.color += 0x111111;
	}
	
	SGUI_Notification_OpenPopup_1(notificationData);
	
	return wrappedMethod( index, id_str, id_name, id_item );
}





exec function sgui_loot_test()
{
	var popupData : SGUI_W3LootPopupData = new SGUI_W3LootPopupData in theGame;
	var contents : SGUI_Loot_Struct_EntryContents;
	var item : SItemUniqueId;
	
	
	//popupData.title = "TITLE";
	//popupData.x = 1900;
	//popupData.y = 1080;
	popupData.isPause = true;
	popupData.isBackgroundFilter = true;
	popupData.scale = 2;
	
	contents.sgui_lsec_id_str = "A";
	contents.sgui_lsec_id_name = 'a';
	contents.sgui_lsec_label = "AAA";
	contents.sgui_lsec_subLabel = "aaa";
	contents.sgui_lsec_quantity = "a";
	contents.sgui_lsec_isIconSemiTransparent = false;
	contents.sgui_lsec_isExclamation = false;
	SGUI_Loot_PushContents(popupData, contents);
	
	contents.sgui_lsec_id_str = "B";
	contents.sgui_lsec_id_name = 'b';
	contents.sgui_lsec_label = "BBB";
	contents.sgui_lsec_subLabel = "bbb";
	contents.sgui_lsec_quantity = " ";
	contents.sgui_lsec_isIconSemiTransparent = true;
	contents.sgui_lsec_isExclamation = true;
	SGUI_Loot_PushContents(popupData, contents);
	
	GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);
	contents.sgui_lsec_id_str = "C";
	contents.sgui_lsec_id_name = thePlayer.inv.GetItemName(item);
	contents.sgui_lsec_id_item = item;
	contents.sgui_lsec_label = thePlayer.inv.GetItemName(item);
	contents.sgui_lsec_subLabel = "ccc";
	SGUI_Loot_PushContents(popupData, contents);
	
	SGUI_Loot_OpenPopup(popupData);
}





exec function sgui_ov_vanilla()
{
	theGame.GetGuiManager().ShowNotification("ov");
}

exec function sgui_ov_test( optional second : bool ) : void
{
	var notificationData : SGUI_W3NotificationData;
	var notificationModule : CScriptedFlashObject;
	
	notificationData = new SGUI_W3NotificationData in theGame.GetGuiManager();
	notificationData.messageText = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
	//notificationData.duration = 4000;
	//notificationData.queue = false;
	notificationData.w = -1;
	//notificationData.color = 0xcccccc;
	//notificationData.alpha = 0.95;
	notificationData.anim = false;
	
	if( second )
	{
		notificationData.x = 0.1;
		notificationData.y = 0.1;
		SGUI_Notification_OpenPopup_2(notificationData);
	}
	else
	{
		notificationData.x = 0.5;
		notificationData.y = 0.5;
		SGUI_Notification_OpenPopup_1(notificationData);
	}
}
*/