	package com.NJSquared.state
{
		import Box2D.Dynamics.Contacts.b2Contact;
		
		import citrus.objects.CitrusSprite;
		
		import com.NJSquared.gameCore.Assets;
		import com.citrusengine.core.CitrusEngine;
		import com.citrusengine.core.StarlingState;
		import com.citrusengine.math.MathVector;
		import com.citrusengine.objects.platformer.box2d.Coin;
		import com.citrusengine.objects.platformer.box2d.Crate;
		import com.citrusengine.objects.platformer.box2d.Enemy;
		import com.citrusengine.objects.platformer.box2d.Hero;
		import com.citrusengine.objects.platformer.box2d.Platform;
		import com.citrusengine.physics.box2d.Box2D;
		import com.citrusengine.utils.ObjectMaker2D;
		
		import flash.display.Bitmap;
		import flash.events.Event;
		import flash.geom.Rectangle;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		
		import starling.display.Image;
		import starling.textures.Texture;
		import starling.textures.TextureAtlas;
	
	public class TestMapGameState extends StarlingState
	{
		[Embed(source="assets/tmx/Map.xml", mimeType="application/octet-stream")]
		private const _Tilemap:Class;
		
		private var _ce:CitrusEngine;

		private var _bg:Image;
		private var _hero:Hero;
		
		public function TestMapGameState() 
		{
			super();
			_ce = CitrusEngine.getInstance();
		}
		
		override public function initialize():void 
		{
			
			super.initialize();
			
			Assets.init();
			
			_bg= new Image(Assets.gameBGTexture);
			addChild(_bg);
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			//add(new Platform("platform", {x:1200, y:1504, height:70, width:1540}));
			
			parseXML();
			
		}			
		
		private function parseXML():void
		{
			var xml:XML = XML(new _Tilemap());
			trace(xml);
			
			for each(var object:XML in xml.object)
			{
				if(object.@name == "platform")
				{
					add(new Platform("platform", {x:object.@x, y:object.@y, height:object.@height, width:object.@width}));
					trace("platform");
				}
				
				if(object.@name == "tile")
				{
					var coin:Coin = new Coin("coin", {x:object.@x, y:object.@y});
					add(coin);

				}
				
				if(object.@name == "hero")
				{
					_hero = new Hero("hero", {x:object.@x, y:object.@y, height:object.@height, width:object.@width});
					add(_hero);
					trace("hero");
					view.setupCamera(_hero, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 5040, 805.5), new MathVector(.25, .05));
				}
				
				if(object.@name == "Enemy")
				{
					add(new Enemy("enemy", {x:object.@x, y:object.@y, height:object.@height, width:object.@width, leftBound:5, rightBound:10}));
				}
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			trace(_hero.x);
			if(_hero.x >= 660)
			{
				_bg.x = -_hero.x + 10;
			}
			if(_hero.x <=600)
			{
				_bg.x = 0;
			}
			_bg.y = -_hero.y + 268;
		}
	}
}