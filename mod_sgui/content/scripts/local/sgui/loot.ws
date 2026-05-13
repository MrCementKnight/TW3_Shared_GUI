/*
exec function sgui_loot()
{
	var popupData : SGUI_W3LootPopupData = new SGUI_W3LootPopupData in theGame;
	var contents : SGUI_Loot_Struct_EntryContents;
	var item : SItemUniqueId;
	
	
	//popupData.title = "TITLE";
	//popupData.x = 1900;
	//popupData.y = 1080;
	
	contents.SGUI_LSEC_id_str = "A";
	contents.SGUI_LSEC_id_name = 'a';
	contents.SGUI_LSEC_label = "AAA";
	contents.SGUI_LSEC_subLabel = "aaa";
	contents.SGUI_LSEC_quantity = "a";
	contents.SGUI_LSEC_isIconTransparent = false;
	contents.SGUI_LSEC_isExclamation = false;
	SGUI_Loot_PushContents(popupData, contents);
	
	contents.SGUI_LSEC_id_str = "B";
	contents.SGUI_LSEC_id_name = 'b';
	contents.SGUI_LSEC_label = "BBB";
	contents.SGUI_LSEC_subLabel = "bbb";
	contents.SGUI_LSEC_isIconTransparent = true;
	contents.SGUI_LSEC_isExclamation = true;
	SGUI_Loot_PushContents(popupData, contents);
	
	GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);
	contents.SGUI_LSEC_id_str = "C";
	contents.SGUI_LSEC_id_name = thePlayer.inv.GetItemName(item);
	contents.SGUI_LSEC_id_item = item;
	contents.SGUI_LSEC_label = thePlayer.inv.GetItemName(item);
	contents.SGUI_LSEC_subLabel = "ccc";
	SGUI_Loot_PushContents(popupData, contents);
	
	SGUI_Loot_OpenPopup(popupData);
}
*/

function SGUI_Loot_OpenPopup( popupData : SGUI_W3LootPopupData )
{
	popupData.x = popupData.x * 1900;
	popupData.y = popupData.y * 1080;
	
	theGame.RequestPopup('PsoPopup', popupData);
}

function SGUI_Loot_ClosePopup()
{
	theGame.ClosePopup('PsoPopup');
}

function SGUI_Loot_PushContents( out popupData : SGUI_W3LootPopupData, out contents : SGUI_Loot_Struct_EntryContents )
{
	popupData.entries.PushBack(contents);
	
	contents.SGUI_LSEC_id_str = "";
	contents.SGUI_LSEC_id_name = '';
	contents.SGUI_LSEC_id_item = GetInvalidUniqueId();
	contents.SGUI_LSEC_label = "";
	contents.SGUI_LSEC_subLabel = "";
	contents.SGUI_LSEC_iconPath = "";
	contents.SGUI_LSEC_quantity = "";
	contents.SGUI_LSEC_color = SGUI_LEC_gray;
	contents.SGUI_LSEC_isIconTransparent = false;
	contents.SGUI_LSEC_isExclamation = false;
}

class SGUI_W3LootPopupData extends CObject
{
	var title : string;
	var isBackgroundFilter : bool;
	var scale : SGUI_Loot_Enum_Scale;
	var inputContext : name;
	var scroll : float;
	var index : int;
	var x, y : float;
	default x = 0.3472; default y = 0.8947;
	//default x = 659.65; default y = 966.29;
	
	var entries : array< SGUI_Loot_Struct_EntryContents >;
}

struct SGUI_Loot_Struct_EntryContents
{
	var SGUI_LSEC_id_str : string;
	var SGUI_LSEC_id_name : name;
	var SGUI_LSEC_id_item : SItemUniqueId;
	var SGUI_LSEC_label : string;
	var SGUI_LSEC_subLabel : string;
	var SGUI_LSEC_iconPath : string;
	var SGUI_LSEC_quantity : string;
	var SGUI_LSEC_color : SGUI_Loot_Enum_Colors;
	var SGUI_LSEC_isIconTransparent : bool;
	var SGUI_LSEC_isExclamation : bool;
}

enum SGUI_Loot_Enum_Scale
{
	SGUI_LES_cfg,
	SGUI_LES_small,
	SGUI_LES_large,
}

enum SGUI_Loot_Enum_Colors
{
	SGUI_LEC_gray,
	SGUI_LEC_blue,
	SGUI_LEC_yellow,
	SGUI_LEC_orange,
	SGUI_LEC_green
}

statemachine class SGUI_Loot_Class_ContextMoniter
{
	var loot : SGUI_CR4LootPopup;
	
	function Init(loot : SGUI_CR4LootPopup)
	{
		this.loot = loot;
		GotoState('SGUI_Loot_State_ContextMoniter');
	}
}

state SGUI_Loot_State_ContextMoniter in SGUI_Loot_Class_ContextMoniter
{
	event OnEnterState( prevStateName : name )
	{
		EntryContextMoniter();
	}
	
	entry function EntryContextMoniter()
	{
		Sleep(0.1);
		parent.loot.UpdateInputContext();
	}
}

class SGUI_CR4LootPopup extends CR4PopupBase
{
	private const var KEY_LOOT_ITEM_LIST :string; default KEY_LOOT_ITEM_LIST = "LootItemList";
	
	private var m_fxSetWindowTitle 		: CScriptedFlashFunction;
	private var m_fxSetSelectionIndex	: CScriptedFlashFunction;
	private var m_fxSetWindowScale		: CScriptedFlashFunction;
	private var m_fxResizeBackground	:CScriptedFlashFunction;
	private var m_fxSetBackground2Color	: CScriptedFlashFunction;
	private var m_indexToSelect			: int; 							default m_indexToSelect = 0;
	var mcLootItemModule, mcLootItemsList  : CScriptedFlashObject;
	var lootPopupData : SGUI_W3LootPopupData;
	var popupEntries : array< SGUI_Loot_Struct_EntryContents >;
	var inputContext : name;
	var isSmall : bool;
	var mcLootItemsListItem, textField, tfType : CScriptedFlashObject;
	var c_cm : SGUI_Loot_Class_ContextMoniter;
	
	
	event  OnConfigUI()
	{
		var targetSize : float;
		var i : int;		
		
		super.OnConfigUI();
		
		c_cm = new SGUI_Loot_Class_ContextMoniter in this;
		c_cm.Init(this);
		
		this.lootPopupData = (SGUI_W3LootPopupData)GetPopupInitData();
		this.popupEntries = this.lootPopupData.entries;
		
		this.mcLootItemModule = m_flashModule.GetMemberFlashObject("mcLootItemModule");
		this.mcLootItemsList = mcLootItemModule.GetMemberFlashObject("mcLootItemsList");
		
		m_fxSetWindowTitle = m_flashModule.GetMemberFlashFunction( "SetWindowTitle" );
		m_fxSetSelectionIndex = m_flashModule.GetMemberFlashFunction( "SetSelectionIndex" );
		m_fxSetWindowScale = m_flashModule.GetMemberFlashFunction( "SetWindowScale" );
		m_fxResizeBackground = m_flashModule.GetMemberFlashFunction( "resizeBackground" );
		m_fxSetBackground2Color = this.mcLootItemModule.GetMemberFlashFunction( "SetBackground2Color" );
		
		
		for( i=1; i<=8; i+=1 )
		{
			mcLootItemsListItem = this.mcLootItemModule.GetMemberFlashObject("mcLootItemsListItem" + i);
			textField = mcLootItemsListItem.GetMemberFlashObject("textField");
			tfType = mcLootItemsListItem.GetMemberFlashObject("tfType");
			textField.SetMemberFlashNumber("width", 520);
			tfType.SetMemberFlashNumber("width", 520);
		}
		
		
		this.mcLootItemModule.SetMemberFlashNumber("x", this.lootPopupData.x);
		this.mcLootItemModule.SetMemberFlashNumber("y", this.lootPopupData.y);
		
		
		m_fxSetWindowTitle.InvokeSelfOneArg( FlashArgString(this.lootPopupData.title) );
		
		if( this.lootPopupData.isBackgroundFilter )
		{
			m_fxSetBackground2Color.InvokeSelfThreeArgs( FlashArgBool(true), FlashArgInt(0x999999), FlashArgNumber(0.3) );
		}
		
		if( this.lootPopupData.index > 0 )
		{
			m_fxSetSelectionIndex.InvokeSelfOneArg( FlashArgInt(this.lootPopupData.index) );
		}
		
		theGame.ForceUIAnalog(true);
		theGame.GetGuiManager().RequestMouseCursor(true);
		
		
		this.inputContext = this.lootPopupData.inputContext;
		if( this.inputContext == '' )
		{
			this.inputContext = 'EMPTY_CONTEXT';
		}
		theInput.StoreContext( this.inputContext );
		
		
		theSound.SoundEvent("gui_loot_popup_open");
		
		PopulateData();
		
		
		if( this.lootPopupData.scale == SGUI_LES_cfg )
		{
			if( StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('Hud', 'HudSize'), 0) == 0 )
			{
				isSmall = true;
			}
		}
		else
		if( this.lootPopupData.scale == SGUI_LES_small )
		{
			isSmall = true;
		}
		
		if( isSmall )
		{
			targetSize = 0.85;
		}
		else
		{
			targetSize = 1;
		}
		
		if (theInput.LastUsedPCInput() && (theGame.GetGuiManager().mouseCursorRequestStack <= 1 && !theGame.GetGuiManager().GetIngameMenu().isMainMenu) )
		{
			theGame.MoveMouseTo(0.5, 0.5);
		}
		
		m_fxSetWindowScale.InvokeSelfOneArg(FlashArgNumber(targetSize));
		
		//theGame.GetGuiManager().ShowNotification("!<br>" + this.mcLootItemModule.GetMemberFlashNumber("x") +"<br>" + this.mcLootItemModule.GetMemberFlashNumber("y"));
	}
	
	event  OnClosingPopup()
	{
		theSound.SoundEvent("gui_loot_popup_close");
		super.OnClosingPopup();
		if( theInput.GetContext() == this.inputContext )
		{
			theInput.RestoreContext( this.inputContext, false );
		}
		
		theGame.GetGuiManager().RequestMouseCursor(false);
		theGame.ForceUIAnalog(false);
	}
	
	public function UpdateInputContext():void
	{
		var currentContext : name;
		
		currentContext = theInput.GetContext();
		if( currentContext != this.inputContext )
		{
			theInput.RestoreContext(currentContext, true);
			if( theInput.GetContext() == this.inputContext ) 
			{
				theInput.RestoreContext(this.inputContext, true);
			}
			
			theInput.StoreContext(currentContext);
			
			ClosePopup();
		}
	}
	
	function PopulateData()
	{
		var i, j, length					: int;
		var l_lootItemsFlashArray			: CScriptedFlashArray;
		var l_lootItemsDataFlashObject 		: CScriptedFlashObject;
		var l_lootItemStatsFlashArray		: CScriptedFlashArray;
		var l_lootItemStatsDataFlashObject	: CScriptedFlashObject;
		
		var _value							: string;
		var content : SGUI_Loot_Struct_EntryContents;
		
		
		l_lootItemsFlashArray = m_flashValueStorage.CreateTempFlashArray();
		
		length = this.popupEntries.Size();
		if(length > 8)
		{
			m_fxResizeBackground.InvokeSelfOneArg(FlashArgBool(true));
		}
		else
		{
			m_fxResizeBackground.InvokeSelfOneArg(FlashArgBool(false));
		}
		l_lootItemsFlashArray.SetLength( length );
		
		for	( i = 0 ; i < length; i+=1 )
		{
			l_lootItemsDataFlashObject = m_flashValueStorage.CreateTempFlashObject();
			content = this.popupEntries[i];
			
			l_lootItemsDataFlashObject.SetMemberFlashString	( "id_str", content.SGUI_LSEC_id_str );
			l_lootItemsDataFlashObject.SetMemberFlashUInt	( "id_name", NameToFlashUInt(content.SGUI_LSEC_id_name) );
			l_lootItemsDataFlashObject.SetMemberFlashUInt	( "id_item", ItemToFlashUInt(content.SGUI_LSEC_id_item) );
			l_lootItemsDataFlashObject.SetMemberFlashString	( "label", content.SGUI_LSEC_label );
			l_lootItemsDataFlashObject.SetMemberFlashString	( "quantity", content.SGUI_LSEC_quantity );
			l_lootItemsDataFlashObject.SetMemberFlashString ( "iconPath", content.SGUI_LSEC_iconPath );
			l_lootItemsDataFlashObject.SetMemberFlashInt	( "quality", content.SGUI_LSEC_color + 1 );
			l_lootItemsDataFlashObject.SetMemberFlashBool	( "isRead", content.SGUI_LSEC_isIconTransparent);
			l_lootItemsDataFlashObject.SetMemberFlashBool   ( "isQuestItem", content.SGUI_LSEC_isExclamation );
			l_lootItemsDataFlashObject.SetMemberFlashString ( "itemType", content.SGUI_LSEC_subLabel );
			
			l_lootItemsFlashArray.SetElementFlashObject( i, l_lootItemsDataFlashObject );
		}
		
		m_flashValueStorage.SetFlashArray( KEY_LOOT_ITEM_LIST, l_lootItemsFlashArray );
		
		//m_fxSetWindowTitle.InvokeSelfOneArg( FlashArgString( _container.GetDisplayName() ) );		
	}
	
	function CompareItemsStats(itemStats : array<SAttributeTooltip>, compareItemStats : array<SAttributeTooltip>, out compResult : CScriptedFlashArray)
	{
		var l_flashObject	: CScriptedFlashObject;
		var attributeVal 	: SAbilityAttributeValue;
		var strDifference 	: string;		
		var percentDiff 	: float;
		var nDifference 	: float;
		var i, j, price 	: int;
		
		strDifference = "none";
		for( i = 0; i < itemStats.Size(); i += 1 ) 
		{
			l_flashObject = m_flashValueStorage.CreateTempFlashObject();
			l_flashObject.SetMemberFlashString("name",itemStats[i].attributeName);
			l_flashObject.SetMemberFlashString("color",itemStats[i].attributeColor);
			
			
			for( j = 0; j < compareItemStats.Size(); j += 1 )
			{
				if( itemStats[j].attributeName == compareItemStats[i].attributeName )
				{
					nDifference = itemStats[j].value - compareItemStats[i].value;
					percentDiff = AbsF(nDifference/itemStats[j].value);
					
					
					if(nDifference > 0)
					{
						if(percentDiff < 0.25) 
							strDifference = "better";
						else if(percentDiff > 0.75) 
							strDifference = "wayBetter";
						else						
							strDifference = "reallyBetter";
					}
					
					else if(nDifference < 0)
					{
						if(percentDiff < 0.25) 
							strDifference = "worse";
						else if(percentDiff > 0.75) 
							strDifference = "wayWorse";
						else						
							strDifference = "reallyWorse";					
					}
					break;					
				}
			}
			l_flashObject.SetMemberFlashString("icon", strDifference);
			
			if( itemStats[i].percentageValue )
			{
				l_flashObject.SetMemberFlashString("value",NoTrailZeros(itemStats[i].value * 100 ) +" %");
			}
			else
			{
				if(itemStats[i].value < 0)
					l_flashObject.SetMemberFlashString("value",NoTrailZeros(itemStats[i].value));
				else
					l_flashObject.SetMemberFlashString("value","+" + NoTrailZeros(itemStats[i].value));				
			}
			compResult.PushBackFlashObject(l_flashObject);
		}	
	}
	
	function GetItemRarityDescription( item : SItemUniqueId, tooltipInv : CInventoryComponent ) : string
	{
		var itemQuality : int;
		
		itemQuality = tooltipInv.GetItemQuality(item);
		return GetItemRarityDescriptionFromInt(itemQuality);
	}
	
	event OnScrollPosition( scroll : float ) : void
	{
		//theGame.GetGuiManager().ShowNotification("OnScrollPosition: " + scroll);
	}
	
	event OnChangedIndex( index : int, id_str : string, id_name : name, id_item : SItemUniqueId ) : void
	{
		//theGame.GetGuiManager().ShowNotification("OnChangedIndex" + "<br>index: " + index + "<br>id_str: " + id_str + "<br>id_name: " + id_name + "<br>id_item: " + thePlayer.inv.GetItemName(id_item));
	}
	
	event OnSelect( index : int, id_str : string, id_name : name, id_item : SItemUniqueId ) : void
	{
		//theGame.GetGuiManager().ShowNotification("OnSelect" + "<br>index: " + index + "<br>id_str: " + id_str + "<br>id_name: " + id_name + "<br>id_item: " + thePlayer.inv.GetItemName(id_item));
	}
	
	event OnPopulated() : void
	{
		if( this.lootPopupData.scroll > 0 )
		{
			this.mcLootItemsList.SetMemberFlashNumber("scrollPosition", this.lootPopupData.scroll);
		}
	}
	
	event  OnCloseLootWindow()
	{
		ClosePopup();
	}
}