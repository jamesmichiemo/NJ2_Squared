package com.NJSquared.state
{
	import citrus.input.controllers.Keyboard;
	
	import com.citrusengine.core.CitrusEngine;
	import com.citrusengine.core.StarlingState;
	import com.citrusengine.objects.platformer.box2d.Platform;
	import com.citrusengine.physics.box2d.Box2D;
	
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class Menu extends StarlingState implements IStates
	{
		[Embed(source="assets/images/play_btn.png")]
		private const _playBtn:Class;
		
		private var _ce:CitrusEngine;
		
		public function Menu()
		{
			super();
			_ce = CitrusEngine.getInstance();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			trace("menu state");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onPlay);
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			var platform:Platform = new Platform("platform", {x:100, y:100, height:70, width:70});
			add(platform);
		}
		
		private function onPlay(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.P)
			{
				destroy();
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			// istate
		}
		
		override public function destroy():void
		{
			super.destroy();
			CitrusEngine.getInstance().state = new BridgeGameState();
		}
	}
}