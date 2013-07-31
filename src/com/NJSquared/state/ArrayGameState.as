package com.NJSquared.state
{	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import com.NJSquared.gameCore.Assets;
	import com.NJSquared.gameCore.Tile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	
	public class ArrayGameState extends StarlingState
	{
		private var _levelOne:Array = [];
		private var _levelOneBit:BitmapData;
		private var _hero:ConcreteHero;
		private var _tiles:Vector.<CitrusObject>;
		
		private var _citrusEngine:CitrusEngine;
		
		[Embed(source = '../assets/images/groundTile.png')] //dirt
		private var ONE:Class;
		[Embed(source = '../assets/images/images_04.png')] //hero
		private var FOUR:Class;
		[Embed(source = '../assets/images/grassTile.png')] //grass
		private var FIVE:Class;
		[Embed(source = '../assets/images/images_06.png')] //spikes
		private var SIX:Class;
		[Embed(source = '../assets/images/waterTile.png')] //water
		private var EIGHT:Class;
		[Embed(source = '../assets/images/keyYellow.png')] //tiles
		private var NINE:Class;
		[Embed(source = '../assets/images/blockerMad.png')] //enemy
		private var SEVEN:Class;

		private var _height2:uint;

		private var _width2:uint;

		private var _enemy:Enemy;
		private var _levelOneTwo:Array;

		private var level:Array;
		private var _tile:Tile;
		
		public function ArrayGameState()
		{
			super();

			_citrusEngine = CitrusEngine.getInstance();

			_citrusEngine.sound.playSound("Collector");
		}
		
		override public function initialize():void 
		{
			
			super.initialize();
			
			Assets.init();
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			_levelOne = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],				
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 8, 8, 8, 8, 5, 0, 5, 5, 5, 5, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 1, 1, 1, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
			[1, 5, 5, 5, 5, 8, 8, 1, 1, 1, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 0, 0, 5, 5, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
			[1, 5, 5, 5, 5, 5, 5, 8, 8, 8, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			];
			
			placeTiles();
		}	
		
		private function placeTiles():void
		{
			level = _levelOne;
			
			_width2 = _levelOne[0].length * 70;
			_height2 = _levelOne.length * 70;
			
			trace(_height2);
			
			
			trace(_width2);
			
			var bd1:BitmapData=new BitmapData(_width2,_height2, false, 0xeeeeee);
			
			for(var i:int = 0; i < level.length; i++)
			{
				
				for(var j:int = 0; j < level[i].length; j++)
				{
					var image:Bitmap;
					
					if(level[i][j] != 0)
					{
						if(level[i][j] == 1)
						{
							image = new ONE();
						}
						else if(level[i][j] == 5)
						{
							image = new FIVE();
						}
						
						else if(level[i][j] == 8)
						{
							image = new EIGHT();
						}
					
						if(level[i][j] == 1 || level[i][j] == 5 || level[i][j] == 8)
						{
							var platform:Platform = new Platform("platform", {x:j*70+35, y:i*70+35, height:70, width:70});
							add(platform);
							bd1.draw(image, new Matrix(1, 0, 0, 1, j*70+35, i*70+35));
						} 
					}
				}
			}
			
			var bitmapImage:Bitmap = new Bitmap(bd1);
			var bg:Platform = new Platform("platform", {x:0, y:0, height:_height2, width:_width2, view:bitmapImage, oneWay:true});
			bg.x = _width2/2 - 35;
			bg.y = _height2 / 2 - 35;
			add(bg);

			addHero();
			addEnemies();
			addTiles();
		}
		
		private function addHero():void
		{
			var heroImage:Image = new Image(Texture.fromBitmap(new FOUR()));
			
			_hero = new ConcreteHero("hero", {x:200, y:300, height:40, width:30, view: heroImage});

			add(_hero);
			
			_hero.onJump.add(handleHeroJump);
			_hero.onGiveDamage.add(handleHeroGiveDamage);
			_hero.onTakeDamage.add(handleHeroTakeDamage);

			
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 5040, 1540), new Point(.25, .05));

		}
		
		private function handleHeroJump():void {
			//_ce.sound.playSound("Jump");
		}
		
		private function handleHeroGiveDamage():void {
			_ce.sound.playSound("Kill");
		}
		
		private function handleHeroTakeDamage():void {
			_ce.sound.playSound("Hurt");
		}
		
		private function addEnemies():void
		{
			var enemy:Enemy;
			var enemyTwo:Enemy;
			var enemyThree:Enemy;
			var enemyFour:Enemy;
			var enemyFive:Enemy;
			
			var enemyImage1:Image = new Image(Texture.fromBitmap(new SEVEN()));
			var enemyImage2:Image = new Image(Texture.fromBitmap(new SEVEN()));
			var enemyImage3:Image = new Image(Texture.fromBitmap(new SEVEN()));
			var enemyImage4:Image = new Image(Texture.fromBitmap(new SEVEN()));
			var enemyImage5:Image = new Image(Texture.fromBitmap(new SEVEN()));
			
			enemy = new Enemy("enemy", {x:350, y:400, height:70, width:70, view: enemyImage1, leftBound:0});
			add(enemy);
			
			enemyTwo = new Enemy("enemy", {x:630, y:420, height:70, width:70, view: enemyImage2, leftBound:0});
			add(enemyTwo);
			
			enemyThree = new Enemy("enemy", {x:1400, y:140, height:70, width:70, view: enemyImage3, leftBound:0});
			add(enemyThree);
			
			enemyFour = new Enemy("enemy", {x:800, y:840, height:70, width:70, view: enemyImage4, leftBound:0});
			add(enemyFour);
			
			enemyFive = new Enemy("enemy", {x:1610, y:840, height:70, width:70, view: enemyImage5, leftBound:0});
			add(enemyFive);
			
		}
		
		private function addTiles():void
		{
			
			
			var tileImage1:Image = new Image(Texture.fromBitmap(new  NINE()));
			_tile = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage1});
			add(_tile);
			
			_tiles = getObjectsByType(Coin);
			for each (var tile:Coin in _tiles)
			  tile.onBeginContact.add(handleJewelCollected);
		}
		
		private function handleJewelCollected(contact:b2Contact):void
		{
			_citrusEngine.sound.playSound("Hurt");
			
		}
		
/*		override public function destroy():void
		{
			super.destroy();			
			CitrusEngine.getInstance().state = new BridgeGameState();
		}	*/	
	}
}