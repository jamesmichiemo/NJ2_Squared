package com.NJSquared.state
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class GameWin extends StarlingState
	{	
		// embed button
		[Embed(source="../assets/images/replayBtn.png")]
		private var btn:Class;
		
		// embed bg
		[Embed(source="../assets/images/gameWin_bg.png")]
		private var bg:Class;

		public function GameWin()
		{
			// win
			_ce.sound.playSound("Victory");
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var bgImage:Texture = Texture.fromBitmap(new bg());
			
			var bg:Image = new Image(bgImage);
			addChild(bg);
			
			
			var buttonImage:Texture = Texture.fromBitmap(new btn());
			var button:Button = new Button(buttonImage);
			button.x = 400;
			button.y = 350;
			addChild(button);	
			button.addEventListener(Event.TRIGGERED, onRestart);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onRestart);
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			var platform:Platform = new Platform("platform", {x:100, y:100, height:70, width:70});
			add(platform);
		}
		
		private function onRestart(event:Event):void
		{	
			// restart game
			destroy();
		}
		
		override public function destroy():void
		{
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.playSound("Start");
			stage.removeEventListener(Event.TRIGGERED, onRestart);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onRestart);
			_ce.state = new ArrayGameState();
		}
	}
}