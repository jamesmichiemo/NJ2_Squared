package com.NJSquared.state
{
	import com.NJSquared.Core.Enemy;
	import com.NJSquared.gameCore.Assets;
	import com.citrusengine.core.CitrusEngine;
	import com.citrusengine.core.StarlingState;
	import com.citrusengine.math.MathVector;
	import com.citrusengine.objects.platformer.box2d.Coin;
	import com.citrusengine.objects.platformer.box2d.Hero;
	import com.citrusengine.objects.platformer.box2d.Platform;
	import com.citrusengine.physics.box2d.Box2D;
	
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	
	public class BridgeGameState extends StarlingState
	{
		private var levelOne:Array = [];
		private var _hero:Hero;
		
		private var _ce:CitrusEngine;
		
		[Embed(source = '../assets/images/images_01.png')]
		private var ONE:Class;
		[Embed(source = '../assets/images/images_04.png')]
		private var FOUR:Class;
		[Embed(source = '../assets/images/images_05.png')]
		private var FIVE:Class;
		[Embed(source = '../assets/images/images_06.png')]
		private var SIX:Class;
		[Embed(source = '../assets/images/images_08.png')]
		private var EIGHT:Class;
		[Embed(source = '../assets/images/keyYellow.png')]
		private var NINE:Class;
		[Embed(source = '../assets/images/blockerMad.png')]
		private var SEVEN:Class;
		
		public function BridgeGameState()
		{
			super();
			
			// 17 width
			// 10 height 
			
			_ce = CitrusEngine.getInstance();
		}
		
		override public function initialize():void 
		{
			
			super.initialize();
			
			Assets.init();
			stage.color = 0x8becfb;
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			levelOne = [
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1],
			];
			
			placeTiles();
		}
		
		private function placeTiles():void
		{
			for(var i:int = 0; i < levelOne.length; i++)
			{
				
				for(var j:int = 0; j < levelOne[i].length; j++)
				{
					var image:Image;
					
					if(levelOne[i][j] != 0)
					{
						if(levelOne[i][j] == 1)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new ONE()));
						}
						
						var platform:Platform = new Platform("platform", {x:j*70+35, y:i*70+35, height:70, width:70, view: image, oneWay: true});
						add(platform);
					}
				}
			}
			
			addHero();
		}
		
		private function addHero():void
		{
			var heroImage:Image = new Image(starling.textures.Texture.fromBitmap(new FOUR()));
			
			_hero = new Hero("hero", {x:200, y:300, height:40, width:30, view: heroImage});
			add(_hero);
			view.setupCamera(_hero, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1400, 720), new MathVector(.25, .05));
		}
		
	}
}