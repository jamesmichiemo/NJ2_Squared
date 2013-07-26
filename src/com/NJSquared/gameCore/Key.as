package com.NJSquared.gameCore
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Key
	{
		public static var keys:Array;
		public function Key()
		{
		}
		
		public static function init(st:Stage):void
		{
			st.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			st.addEventListener(KeyboardEvent.KEY_UP, onUp);
			keys = [];
			
			
		}
		
		protected static function onUp(event:KeyboardEvent):void
		{
			keys[event.keyCode] = 0;	
		}
		
		protected static function onDown(event:KeyboardEvent):void
		{
			keys[event.keyCode] = 1;	
		}
	}
}