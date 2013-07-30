package com.NJSquared.state
{
	import citrus.input.controllers.Keyboard;
	
	import com.citrusengine.core.CitrusEngine;
	import com.citrusengine.core.StarlingState;
	import com.citrusengine.objects.platformer.box2d.Platform;
	import com.citrusengine.physics.box2d.Box2D;
	
	import starling.events.KeyboardEvent;
	
	public class GameOver extends StarlingState
	{	
		private var _ce:CitrusEngine;
		
		public function GameOver()
		{
			trace("game over state");
			_ce = CitrusEngine.getInstance();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onRestart);
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			var platform:Platform = new Platform("platform", {x:100, y:100, height:70, width:70});
			add(platform);
		}
		
		private function onRestart(event:KeyboardEvent):void
		{	
			if(event.keyCode == 82)
			{
				trace("r");
				destroy();
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			// we need this because this class is an IState
		}
		
		override public function destroy():void
		{
			super.destroy();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onRestart);
			CitrusEngine.getInstance().state = new BridgeGameState();
		}
	}
}