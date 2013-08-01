package com.NJSquared.state
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import com.NJSquared.gameCore.Assets;
	
	import flash.display.Bitmap;
	
	import flashx.textLayout.tlf_internal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class Menu extends StarlingState
	{
		// embed button
		[Embed(source="../assets/images/playBtn.png")]
		private var btn:Class;
		
		// embed bg
		[Embed(source="../assets/images/menu_bg.png")]
		private var bg:Class;

		private var button:Button;
		
		public function Menu()
		{
			super();
			_ce = CitrusEngine.getInstance();
			_ce.sound.playSound("Title");
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var bgImage:Texture = Texture.fromBitmap(new bg());
			var bg:Image = new Image(bgImage);
			addChild(bg);	
			
			var buttonImage:Texture = Texture.fromBitmap(new btn());
			button = new Button(buttonImage);
			button.x = 400;
			button.y = 350;
			addChild(button);	

			button.addEventListener(Event.TRIGGERED, onPlayMouse);
			
			trace("menu state");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onPlay);
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			var platform:Platform = new Platform("platform", {x:100, y:100, height:70, width:70});
			add(platform);
		}
		
		private function onPlayMouse(event:Event):void
		{
				_ce.sound.playSound("Start");
				destroy();
		}
		
		private function onPlay(event:KeyboardEvent):void
		{
			
			if(event.keyCode == 13)
			{
			_ce.sound.playSound("Start");
			destroy();
			}
		}
		
		override public function destroy():void
		{
			_ce.sound.stopSound("Title");

			stage.removeEventListeners(KeyboardEvent.KEY_DOWN);

			stage.removeEventListeners(Event.TRIGGERED);

			_ce.state = new ArrayGameState();
		}
	}
}