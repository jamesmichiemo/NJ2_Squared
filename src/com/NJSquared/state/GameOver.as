package com.NJSquared.state
{
	import com.NJSquared.state.IStates;
	import com.citrusengine.core.StarlingState;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class GameOver extends StarlingState implements IStates
	{	
		public function GameOver()
		{
			trace("game over state");
		}
		
		public function init(event:Event):void
		{

		}
		
		override public function update(timeDelta:Number):void
		{
			// we need this because this class is an IState
		}
		
		override public function destroy():void
		{
			
		}
		
		private function onPlayAgain():void
		{
			
		}
		
	}
}