package com.NJSquared.gameCore
{
	import citrus.input.InputController;

	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	
	import starling.events.Event;
	
	public class Controller extends InputController
	{
		private var gameInput:GameInput;
		
		public function Controller(name:String, params:Object=null)
		{
			super(name, params);
		        
			gameInput = new GameInput();
			gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, inputDeviceAddedEvent);
		}
				
		public function inputDeviceAddedEvent(e:GameInputEvent):void
		{
	/*		GameInputControlName.initialize(device);
			for(var i:int=0; i < device.numControls; i++)
			{
				var control:GameInputControl = device.getControlAt(i);
				if(control.name == DPAD_LEFT)
				{
					control.addEventListener(Event.CHANGE, dpadLeftChangeHandler);
				}
				if(control.name == DPAD_RIGHT)
				{
					control.addEventListener(Event.CHANGE, dpadRightChangeHandler);
				}                              
				if(control.name == DPAD_UP)
				{
					control.addEventListener(Event.CHANGE, dpadUpChangeHandler);
				}
				else if(control.name == DPAD_DOWN)
				{
					control.addEventListener(Event.CHANGE, dpadDownChangeHandler);
				}
			}*/
		}
				
				function dpadLeftChangeHandler(e:Event)
				{
					//Move player left
				}
				
				function dpadRightChangeHandler(e:Event)
				{
					//Move player right
				}
				
				function dpadUpChangeHandler(e:Event)
				{
					//Move player up
				}
				
				function dpadDownChangeHandler(e:Event)
				{
					//Move player down
				}
			}
		}
	}
}