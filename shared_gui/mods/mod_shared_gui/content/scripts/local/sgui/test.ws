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
		contents.sgui_lsec_color = SGUI_LEC_gray;
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
	
	
	popupData.title = "TITLE";
	popupData.x = 0.5;
	popupData.y = 0.8;
	popupData.isPause = true;
	popupData.isBackgroundFilter = true;
	popupData.scale = SGUI_LES_large;
	
	contents.sgui_lsec_id_str = "A";
	contents.sgui_lsec_id_name = 'a';
	contents.sgui_lsec_label = "AAA";
	contents.sgui_lsec_subLabel = "aaa";
	contents.sgui_lsec_quantity = "a";
	contents.sgui_lsec_isExclamation = false;
	SGUI_Loot_PushContents(popupData, contents);
	
	contents.sgui_lsec_id_str = "B";
	contents.sgui_lsec_id_name = 'b';
	contents.sgui_lsec_label = "BBB";
	contents.sgui_lsec_subLabel = "bbb";
	contents.sgui_lsec_isExclamation = true;
	SGUI_Loot_PushContents(popupData, contents);
	
	GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);
	contents.sgui_lsec_id_str = "C";
	contents.sgui_lsec_id_name = thePlayer.inv.GetItemName(item);
	contents.sgui_lsec_id_item = item;
	contents.sgui_lsec_label = thePlayer.inv.GetItemName(item);
	contents.sgui_lsec_subLabel = "ccc";
	contents.sgui_lsec_iconPath = thePlayer.inv.GetItemIconPathByUniqueID(item);
	contents.sgui_lsec_isIconSemiTransparent = true;
	contents.sgui_lsec_color = thePlayer.inv.GetItemQuality(item);
	SGUI_Loot_PushContents(popupData, contents);
	
	SGUI_Loot_OpenPopup(popupData);
}





exec function sgui_ov_vanilla()
{
	theGame.GetGuiManager().ShowNotification("ov");
}

exec function sgui_ov_test() : void
{
	var notificationData : SGUI_W3NotificationData;
	
	notificationData = new SGUI_W3NotificationData in theGame.GetGuiManager();
	notificationData.messageText = "<font color='#FFFFFF'>" + "AAAAAAAAAAAAAAAAAA" + "</font>";
	notificationData.w = 800;
	notificationData.color = 0x333333;
	notificationData.alpha = 0.8;
	notificationData.anim = false;
	
	notificationData.x = 0.3;
	notificationData.y = 0.4;
	SGUI_Notification_OpenPopup_1(notificationData);
	
	notificationData.x = 0.3;
	notificationData.y = 0.5;
	SGUI_Notification_OpenPopup_2(notificationData);
}
*/