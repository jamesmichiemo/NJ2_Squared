package com.NJSquared.state
{
	import citrus.core.IState;
	import citrus.core.State;
	import citrus.core.starling.StarlingState;
	
	import com.NJSquared.gameCore.GameAssets;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends State implements IState
	{
		
		public function GameOver()
		{
			
		}
		
		private function init(event:Event):void
		{
			;
		}
		
		private function onPlayAgain():void
		{
			
		}
		
		public function update():void
		{
			// we need this because this class is an IState
		}
		
		public function destroy():void
		{
			
		}
		
	}
}