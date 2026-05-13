/*
exec function sgui_test_1()
{
	var popupData : SGUI_W3LootPopupData = new SGUI_W3LootPopupData in theGame;
	var contents : SGUI_Loot_Struct_EntryContents;
	var i : int;
	
	for( i=0; i<16; i+=1 )
	{
		contents.SGUI_LSEC_id_str = "id_str: " + i;
		contents.SGUI_LSEC_label = "Label " + i;
		contents.SGUI_LSEC_subLabel = "subLabel " + i;
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
*/