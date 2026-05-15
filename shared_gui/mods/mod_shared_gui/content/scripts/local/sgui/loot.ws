// Function for opening the loot popup.
function SGUI_Loot_OpenPopup( popupData : SGUI_W3LootPopupData )
{
	theGame.RequestPopup('PsoPopup', popupData);
}

// Function for closing the loot popup.
function SGUI_Loot_ClosePopup()
{
	theGame.ClosePopup('PsoPopup');
}

// Function for pushing each entry’s settings into an array.
function SGUI_Loot_PushContents( out popupData : SGUI_W3LootPopupData, out contents : SGUI_Loot_Struct_EntryContents )
{
	if( contents.sgui_lsec_color == SGUI_LEC_none )
	{
		contents.sgui_lsec_color = SGUI_LEC_gray;
	}
	
	popupData.entries.PushBack(contents);
	
	contents.sgui_lsec_id_str = "";
	contents.sgui_lsec_id_name = '';
	contents.sgui_lsec_id_item = GetInvalidUniqueId();
	contents.sgui_lsec_label = "";
	contents.sgui_lsec_subLabel = "";
	contents.sgui_lsec_iconPath = "";
	contents.sgui_lsec_quantity = "";
	contents.sgui_lsec_color = SGUI_LEC_gray;
	contents.sgui_lsec_isIconSemiTransparent = false;
	contents.sgui_lsec_isExclamation = false;
}

// Gets the current scroll position and the index of the currently focused entry.
function SGUI_Loot_OutIndex( out index : int, out scroll : float )
{
	var lootPopup : SGUI_CR4LootPopup;
	
	lootPopup = (SGUI_CR4LootPopup)theGame.GetGuiManager().GetPopup('PsoPopup');
	index = lootPopup.mcLootItemsList.GetMemberFlashInt("selectedIndex");
	scroll = lootPopup.mcLootItemsList.GetMemberFlashNumber("scrollPosition");
}

class SGUI_W3LootPopupData extends CObject
{
	var title : string; // Text displayed at the top of the panel.
	var isPause : bool; // Pause the game while the popup is open.
	var isBackgroundFilter : bool; // Applies a semi-transparent black filter to the background.
	var scale : SGUI_Loot_Enum_Scale; // Allows you to choose whether the popup scale follows the game settings or is forced to either Large or Small.
	var inputContext : name; // Input context during the popup.
	var scroll : float; // Scroll position when the popup is opened.
	var index : int; // Index of the entry that will be focused when the popup is opened.
	var x, y : float; // Popup display position. The bottom-left corner is used as the reference point. Set it to a value between 0 and 1. If set to -1, it will be displayed roughly at the center of the screen.
	var entries : array< SGUI_Loot_Struct_EntryContents >; // Settings for each entry.
	default inputContext = 'EMPTY_CONTEXT';
	default x = -1; default y = -1;
}

struct SGUI_Loot_Struct_EntryContents
{
	var sgui_lsec_id_str : string; // ID that can be received by the OnChangedIndex and OnSelect functions.
	var sgui_lsec_id_name : name; // ID that can be received by the OnChangedIndex and OnSelect functions.
	var sgui_lsec_id_item : SItemUniqueId; // ID that can be received by the OnChangedIndex and OnSelect functions.
	var sgui_lsec_label : string; // Main text of the entry.
	var sgui_lsec_subLabel : string; // Subtext displayed below the main text.
	var sgui_lsec_iconPath : string; // Path to the icon displayed to the left of the main text.
	var sgui_lsec_quantity : string; // Text displayed in the bottom-right corner of the icon.
	var sgui_lsec_isIconSemiTransparent : bool; // Makes the icon semi-transparent.
	var sgui_lsec_isExclamation : bool; // Displays an exclamation mark to the left of the icon.
	var sgui_lsec_color : SGUI_Loot_Enum_Colors; // Background color of the entry.
}

enum SGUI_Loot_Enum_Scale
{
	SGUI_LES_cfg, // Follow game settings.
	SGUI_LES_small,
	SGUI_LES_large,
}

enum SGUI_Loot_Enum_Colors
{
	SGUI_LEC_none, // Not available.
	SGUI_LEC_gray,
	SGUI_LEC_blue,
	SGUI_LEC_yellow,
	SGUI_LEC_orange,
	SGUI_LEC_green
}





class SGUI_CR4LootPopup extends CR4PopupBase
{
	private const var KEY_LOOT_ITEM_LIST :string; default KEY_LOOT_ITEM_LIST = "LootItemList";
	
	var m_fxSetWindowTitle 		: CScriptedFlashFunction;
	var m_fxSetSelectionIndex	: CScriptedFlashFunction;
	var m_fxSetWindowScale		: CScriptedFlashFunction;
	var m_fxResizeBackground	:CScriptedFlashFunction;
	var m_fxSetBackground2Color	: CScriptedFlashFunction;
	
	var indexToFocus : int; // Index of the currently focused entry.
	var scrollPosition : float; // Current scroll position.
	
	var mcLootItemModule, mcLootItemsList  : CScriptedFlashObject;
	var lootPopupData : SGUI_W3LootPopupData;
	var popupEntries : array< SGUI_Loot_Struct_EntryContents >;
	var inputContext : name;
	var isSmall, isRequestMouseCursor : bool;
	var mcLootItemsListItem, textField, tfType : CScriptedFlashObject;
	var c_cm : SGUI_Loot_Class_ContextMoniter;
	
	
	// Event called whenever scrolling occurs. Receives the scroll position.
	event OnScrollPosition( scroll : float ) : void
	{
		this.scrollPosition = scroll;
		//theGame.GetGuiManager().ShowNotification("OnScrollPosition: " + scroll);
	}
	
	// Event called whenever the focused entry changes. Receives the index and IDs.
	event OnChangedIndex( index : int, id_str : string, id_name : name, id_item : SItemUniqueId ) : void
	{
		this.indexToFocus = index;
		//theGame.GetGuiManager().ShowNotification("OnChangedIndex" + "<br>index: " + index + "<br>id_str: " + id_str + "<br>id_name: " + id_name + "<br>id_item: " + thePlayer.inv.GetItemName(id_item));
	}
	
	// Event called when an entry is clicked (or when the E key is pressed). Receives the index and IDs.
	event OnSelect( index : int, id_str : string, id_name : name, id_item : SItemUniqueId ) : void
	{
		//theGame.GetGuiManager().ShowNotification("OnSelect" + "<br>index: " + index + "<br>id_str: " + id_str + "<br>id_name: " + id_name + "<br>id_item: " + thePlayer.inv.GetItemName(id_item));
	}
	
	// Event called when the popup is closed.
	event  OnCloseLootWindow()
	{
		if( theGame.IsPausedForReason("sgui_loot") )
		{
			theGame.Unpause("sgui_loot");
		}
		
		ClosePopup();
	}
	
	
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
		
		m_fxSetWindowTitle.InvokeSelfOneArg( FlashArgString(this.lootPopupData.title) );
		
		if( this.lootPopupData.isBackgroundFilter )
		{
			m_fxSetBackground2Color.InvokeSelfThreeArgs( FlashArgBool(true), FlashArgInt(0x000000), FlashArgNumber(0.6) );
		}
		
		if( this.lootPopupData.index > 0 )
		{
			m_fxSetSelectionIndex.InvokeSelfOneArg( FlashArgInt(this.lootPopupData.index) );
		}
		
		
		this.inputContext = this.lootPopupData.inputContext;
		theInput.StoreContext( this.inputContext );
		
		
		if( this.lootPopupData.isPause )
		{
			theGame.Pause("sgui_loot");
		}
		
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
		
		if( this.lootPopupData.x == -1 )
		{
			if( isSmall )
			{
				this.lootPopupData.x = 0.35;
			}
			else
			{
				this.lootPopupData.x = 0.32;
			}
		} 
		if( this.lootPopupData.y == -1 )
		{
			if( isSmall )
			{
				this.lootPopupData.y = 0.82;
			}
			else
			{
				this.lootPopupData.y = 0.87;
			}
		}
		
		this.lootPopupData.x *= 1900;
		this.lootPopupData.y *= 1080;
		
		this.mcLootItemModule.SetMemberFlashNumber("x", this.lootPopupData.x);
		this.mcLootItemModule.SetMemberFlashNumber("y", this.lootPopupData.y);
		
		if ( theGame.GetGuiManager().mouseCursorRequestStack <= 0 && !theGame.GetGuiManager().GetIngameMenu().isMainMenu )
		{
			theGame.ForceUIAnalog(true);
			theGame.GetGuiManager().RequestMouseCursor(true);
			
			this.isRequestMouseCursor = true;
			
			if( theInput.LastUsedPCInput() )
			{
				theGame.MoveMouseTo(0.5, 0.5);
			}
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
		
		if ( this.isRequestMouseCursor )
		{
			theGame.ForceUIAnalog(false);
			theGame.GetGuiManager().RequestMouseCursor(false);
		}
		
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
			
			l_lootItemsDataFlashObject.SetMemberFlashString	( "id_str", content.sgui_lsec_id_str );
			l_lootItemsDataFlashObject.SetMemberFlashUInt	( "id_name", NameToFlashUInt(content.sgui_lsec_id_name) );
			l_lootItemsDataFlashObject.SetMemberFlashUInt	( "id_item", ItemToFlashUInt(content.sgui_lsec_id_item) );
			l_lootItemsDataFlashObject.SetMemberFlashString	( "label", content.sgui_lsec_label );
			l_lootItemsDataFlashObject.SetMemberFlashString	( "quantity", content.sgui_lsec_quantity );
			l_lootItemsDataFlashObject.SetMemberFlashString ( "iconPath", content.sgui_lsec_iconPath );
			l_lootItemsDataFlashObject.SetMemberFlashInt	( "quality", content.sgui_lsec_color );
			l_lootItemsDataFlashObject.SetMemberFlashBool	( "isRead", content.sgui_lsec_isIconSemiTransparent);
			l_lootItemsDataFlashObject.SetMemberFlashBool   ( "isQuestItem", content.sgui_lsec_isExclamation );
			l_lootItemsDataFlashObject.SetMemberFlashString ( "itemType", content.sgui_lsec_subLabel );
			
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
	
	event OnPopulated() : void
	{
		if( this.lootPopupData.scroll > 0 )
		{
			this.mcLootItemsList.SetMemberFlashNumber("scrollPosition", this.lootPopupData.scroll);
		}
	}
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