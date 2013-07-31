package com.NJSquared.state
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import com.NJSquared.gameCore.Assets;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class Menu extends StarlingState
	{
		
		//private var _ce:CitrusEngine;
		
		//[Embed(source = '../assets/images/playBtn.png')] // playBtn
		/*private var _playBtn:Texture;
		public var buttonUpTexture:Texture;*/

		// embed button
		[Embed(source="../assets/images/playBtn.png")]
		private var btn:Class;
		public static var btnTexture:Texture;
		
		public function Menu()
		{
			super();
			_ce = CitrusEngine.getInstance();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			//var button:Button;
			var buttonImage1:Image = new Image(Texture.fromBitmap(new btn()));
			
			var button:Button = new Button(buttonImage1);
			//button.pivotX = _playBtn.width * 0.5;
			button.x = 400;
			button.y = 350;
			addChild(button);	
			button.addEventListener(Event.TRIGGERED, onPlay);
			
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
			if(event.keyCode == 65)
			{
				destroy();
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			stage.removeEventListeners(KeyboardEvent.KEY_DOWN);
			_ce.state = new ArrayGameState();
		}
	}
}