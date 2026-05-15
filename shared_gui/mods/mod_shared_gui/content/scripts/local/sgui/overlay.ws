// Function for opening the first notification popup.
function SGUI_Notification_OpenPopup_1( notificationData : SGUI_W3NotificationData )
{
	var overlayPopupRef  : SGUI_CR4OverlayPopup;
	
	
	overlayPopupRef = (SGUI_CR4OverlayPopup)theGame.GetGuiManager().GetPopup('TestPopup');
	if (!overlayPopupRef)
	{
		theGame.RequestPopup( 'TestPopup',  notificationData );
	}
	else
	{
		overlayPopupRef.ShowNotification( notificationData.messageText, notificationData.duration, notificationData.queue, notificationData.x, notificationData.y, notificationData.w, notificationData.color, notificationData.alpha, notificationData.anim );
	}
}

// Function for opening the second notification popup.
function SGUI_Notification_OpenPopup_2( notificationData : SGUI_W3NotificationData )
{
	var overlayPopupRef  : SGUI_CR4OverlayPopup;
	
	
	overlayPopupRef = (SGUI_CR4OverlayPopup)theGame.GetGuiManager().GetPopup('Test2Popup');
	if (!overlayPopupRef)
	{
		theGame.RequestPopup( 'Test2Popup',  notificationData );
	}
	else
	{
		overlayPopupRef.ShowNotification( notificationData.messageText, notificationData.duration, notificationData.queue, notificationData.x, notificationData.y, notificationData.w, notificationData.color, notificationData.alpha, notificationData.anim );
	}
}

// Function for closing the first notification popup.
function SGUI_Notification_ClosePopup_1()
{
	theGame.ClosePopup('TestPopup');
}

// Function for closing the second notification popup.
function SGUI_Notification_ClosePopup_2()
{
	theGame.ClosePopup('Test2Popup');
}

class SGUI_W3NotificationData extends CObject
{
	public var messageText 	: string; // Text.
	public var duration    	: float; // Duration for displaying the popup. Set in milliseconds. If set to -1, it will no longer close automatically over time.
	public var queue		: bool; // Waits until the currently displayed notification popup is closed.
	default duration = 4000;
	
	var x, y : float; // Popup display position. The bottom-left corner is used as the reference point. Set it to a value between 0 and 1.
	var w : float; // Width of the panel. The height is automatically adjusted based on the length of the text. If set to -1, it will use the same width as vanilla (automatically adjusted between 200 and 400).
	var color : int; // Panel color. Set using a hexadecimal value such as `0xFFFFFF`. If set to `-1`, the vanilla color will be used.
	var alpha : float; // Panel opacity. Set it to a value between 0 and 1.
	var anim : bool; // Applies animations when the popup appears and disappears.
	default x = 0.05;
	default y = 0.95;
	default w = -1;
	default color = -1;
	default alpha = 0.95;
	default anim = true;
}

class SGUI_CR4OverlayPopup extends CR4PopupBase
{
	private var m_InitDataObject         : SGUI_W3NotificationData;
	
	private var m_fxShowNotification       : CScriptedFlashFunction;
	private var m_fxHideNotification        : CScriptedFlashFunction;
	private var m_fxClearNotificationsQueue : CScriptedFlashFunction;
	
	private var m_fxShowLoadingIndicator : CScriptedFlashFunction;
	private var m_fxHideLoadingIndicator : CScriptedFlashFunction;
	private var m_fxShowSavingIndicator  : CScriptedFlashFunction;
	private var m_fxHideSavingIndicator  : CScriptedFlashFunction;
	
	private var m_fxAppendButton  		  : CScriptedFlashFunction;
	private var m_fxRemoveButton  		  : CScriptedFlashFunction;
	private var m_fxRemoveContextButtons  : CScriptedFlashFunction;
	private var m_fxUpdateButtons 		  : CScriptedFlashFunction;
	
	private var m_fxSetMouseCursorType 	   : CScriptedFlashFunction;
	private var m_fxShowMouseCursor  	   : CScriptedFlashFunction;
	private var m_fxShowSafeRect 		   : CScriptedFlashFunction;
	private var m_fxSetGamepadTypeOverlay  : CScriptedFlashFunction;
	
	private var m_fxShowEP2Logo				: CScriptedFlashFunction;
	
	
	
	private var m_cursorRequested		   : int;
	private var m_cursorHidden			   : bool;
	
	event  OnConfigUI()
	{
		super.OnConfigUI();
		
		m_fxShowNotification = m_flashModule.GetMemberFlashFunction( "showNotification" );
		m_fxHideNotification = m_flashModule.GetMemberFlashFunction( "hideNotification" );
		
		m_fxShowLoadingIndicator = m_flashModule.GetMemberFlashFunction( "showLoadIdicator" );
		m_fxHideLoadingIndicator = m_flashModule.GetMemberFlashFunction( "hideLoadIdicator" );
		m_fxShowSavingIndicator = m_flashModule.GetMemberFlashFunction( "showSaveIdicator" );
		m_fxHideSavingIndicator = m_flashModule.GetMemberFlashFunction( "hideSaveIdicator" );
		
		m_fxSetMouseCursorType = m_flashModule.GetMemberFlashFunction( "setMouseCursorType" );
		m_fxAppendButton = m_flashModule.GetMemberFlashFunction( "appendBinding" );
		m_fxRemoveButton = m_flashModule.GetMemberFlashFunction( "removeBinding" );
		m_fxRemoveContextButtons = m_flashModule.GetMemberFlashFunction( "removeAllContextBinding" );
		m_fxUpdateButtons = m_flashModule.GetMemberFlashFunction( "updateInputFeedback" );
		m_fxShowMouseCursor = m_flashModule.GetMemberFlashFunction( "showMouseCursor" );
		m_fxShowSafeRect = m_flashModule.GetMemberFlashFunction( "showSafeRect" );
		m_fxShowEP2Logo = m_flashModule.GetMemberFlashFunction( "showEP2Logo" );
		m_fxSetGamepadTypeOverlay = m_guiManager.GetIngameMenu().GetMenuFlash().GetMemberFlashFunction( "setGamepadType" );
		
		m_fxClearNotificationsQueue = m_flashModule.GetMemberFlashFunction( "clearNotificationsQueue" );
		
		m_InitDataObject = (SGUI_W3NotificationData)GetPopupInitData();
		
		if (m_InitDataObject)
		{
			ShowNotification(m_InitDataObject.messageText, m_InitDataObject.duration, m_InitDataObject.queue, m_InitDataObject.x, m_InitDataObject.y, m_InitDataObject.w, m_InitDataObject.color, m_InitDataObject.alpha, m_InitDataObject.anim );
		}
		
		m_cursorRequested = theGame.GetGuiManager().mouseCursorRequestStack;
		if (m_cursorRequested > 0)
		{
			UpdateCursorVisibility();
		}
		
		UpdateInputDevice();
	}
	
	event OnInputHandled(NavCode:string, KeyCode:int, ActionId:int)
	{
		
	}
	
	public function SetMouseCursorType(value:int):void
	{		
		m_fxSetMouseCursorType.InvokeSelfOneArg( FlashArgInt( value ) );
	}
	
	public function RequestMouseCursor(value:bool):void
	{
		if (value)
		{
			m_cursorRequested+=1;
		}
		else
		if (m_cursorRequested > 0)
		{
			m_cursorRequested-=1;
		}
		
		UpdateCursorVisibility();
	}
	
	public function ForceHideMouseCursor(value:bool):void
	{
		m_cursorHidden = value;
		UpdateCursorVisibility();
	}
	
	public function UpdateGamepadType():void
	{
		UpdateInputDeviceType();
		UpdateInputDevice();
	}
	
	public function UpdateInputDevice():void
	{
		var isGamepad:bool = theInput.LastUsedGamepad();
		
		UpdateCursorVisibility();
		SetControllerType(isGamepad);
		UpdateInputDeviceType();
	}
	
	protected function UpdateInputDeviceType():void
	{
		var deviceType : EInputDeviceType;
		m_fxSetGamepadTypeOverlay = m_guiManager.GetIngameMenu().GetMenuFlash().GetMemberFlashFunction( "setGamepadType" );
		if (m_fxSetGamepadTypeOverlay)
		{
			deviceType = theInput.GetLastUsedGamepadType();
			m_fxSetGamepadTypeOverlay.InvokeSelfOneArg( FlashArgUInt(deviceType) );
		}
	}
	
	private function ShowSoftwareCursor()
	{
		m_fxShowMouseCursor.InvokeSelfOneArg( FlashArgBool( true ) );
	}
	
	private function HideSoftwareCursor()
	{
		m_fxShowMouseCursor.InvokeSelfOneArg( FlashArgBool( false ) );
	}
	
	private function ShowCursor()
	{
		if ( theGame.IsSoftwareCursor() )
		{
			ShowSoftwareCursor();
			theGame.HideHardwareCursor();
		}
		else
		{
			HideSoftwareCursor();
			theGame.ShowHardwareCursor();
		}
	}
	
	private function HideCursor()
	{
		HideSoftwareCursor();
		theGame.HideHardwareCursor();
	}
	
	private function UpdateCursorVisibility():void
	{
		var isGamepad:bool = theInput.LastUsedGamepad();
		
		if (!isGamepad && !m_cursorHidden && m_cursorRequested > 0)
		{
			ShowCursor();
		}
		else
		{
			HideCursor();
		}
	}
	
	public function ShowSafeRect(value:bool):void
	{
		m_fxShowSafeRect.InvokeSelfOneArg( FlashArgBool(value) );
	}
	
	public function AppendButton(actionId:int, gpadCode:string, kbCode:int, label:string, optional contextId:name):void
	{
		m_fxAppendButton.InvokeSelfFiveArgs(FlashArgInt(actionId), FlashArgString(gpadCode), FlashArgInt(kbCode), FlashArgString(label), FlashArgUInt(NameToFlashUInt(contextId)));
	}
	
	public function RemoveButton(actionId:int, optional contextId:name):void
	{
		m_fxRemoveButton.InvokeSelfTwoArgs(FlashArgInt(actionId), FlashArgUInt(NameToFlashUInt(contextId)));
	}
	
	public function RemoveContextButtons(contextId:name):void
	{
		m_fxRemoveContextButtons.InvokeSelfOneArg(FlashArgUInt(NameToFlashUInt(contextId)));
	}
	
	public function UpdateButtons():void
	{
		m_fxUpdateButtons.InvokeSelf();		
	}
	
	public function ShowNotification(messageText : string, optional duration : float, optional queue :  bool, optional x : float, optional y : float, optional w : float, optional color : int, optional alpha : float, optional anim : bool ) : void
	{
		m_fxShowNotification.InvokeSelfNineArgs( FlashArgString(messageText), FlashArgNumber(duration), FlashArgBool( queue ), FlashArgNumber(x), FlashArgNumber(y), FlashArgNumber(w), FlashArgInt(color), FlashArgNumber(alpha), FlashArgBool(anim) );
		//m_fxShowNotification.InvokeSelfThreeArgs( FlashArgString(messageText), FlashArgNumber(duration), FlashArgBool( queue ) );
	}
	
	public function HideNotification() : void
	{
		m_fxHideNotification.InvokeSelf();
	}
	
	public function ClearNotificationsQueue() : void
	{
		m_fxClearNotificationsQueue.InvokeSelf();
	}
	
	public function ShowLoadingIndicator():void
	{
		m_fxShowLoadingIndicator.InvokeSelf();
	}
	
	
	public function HideLoadingIndicator(optional immediateHide : bool):void
	{
		m_fxHideLoadingIndicator.InvokeSelfOneArg(FlashArgBool(immediateHide));
	}
	
	public function ShowSavingIndicator():void
	{
		m_fxShowSavingIndicator.InvokeSelf();
	}
	
	
	public function HideSavingIndicator(optional immediateHide : bool):void
	{
		m_fxHideSavingIndicator.InvokeSelfOneArg(FlashArgBool(immediateHide));
	}

	public function ShowEP2Logo( show : bool, fadeInterval : float, x : int, y : int )
	{
		var audio, subtitles : string;
		var path : string;

		if ( show )
		{
			path = "img://logos/ep2/";

			theGame.GetGameLanguageName( audio, subtitles );
			switch ( subtitles )
			{
			case "PL":
				path += "ep2_pl.png";
				break;
			case "CZ":
				path += "ep2_cz.png";
				break;
			case "RU":
				path += "ep2_ru.png";
				break;
			case "ZH":
				path += "ep2_zh.png";
				break;
			case "EN":
			default:
				path += "ep2_en.png";
				break;
			}
		}

		m_fxShowEP2Logo.InvokeSelfFiveArgs( FlashArgBool( show ), FlashArgNumber( fadeInterval ), FlashArgInt( x ), FlashArgInt( y ), FlashArgString( path ) );
	}
}


@wrapMethod(CR4Game) function OnGameStarting(restored : bool )
{
	theGame.RequestPopup( 'TestPopup' );
	theGame.RequestPopup( 'Test2Popup' );
	return wrappedMethod(restored);
}
@wrapMethod(CR4CommonMainMenuBase) function OnConfigUI()
{
	var overlayPopupRef  : SGUI_CR4OverlayPopup;
	
	overlayPopupRef = (SGUI_CR4OverlayPopup)theGame.GetGuiManager().GetPopup('TestPopup');
	if (!overlayPopupRef)
	{
		theGame.RequestPopup( 'TestPopup' );
		theGame.RequestPopup( 'Test2Popup' );
	}
	
	return wrappedMethod();
}
@wrapMethod(CR4UIRescaleMenu) function OnConfigUI()
{
	var overlayPopupRef  : SGUI_CR4OverlayPopup;
	
	overlayPopupRef = (SGUI_CR4OverlayPopup)theGame.GetGuiManager().GetPopup('TestPopup');
	if (!overlayPopupRef)
	{
		theGame.RequestPopup( 'TestPopup' );
		theGame.RequestPopup( 'Test2Popup' );
	}
	
	return wrappedMethod();
}