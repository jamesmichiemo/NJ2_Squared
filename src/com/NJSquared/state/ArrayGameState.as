package com.NJSquared.state
{	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
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
		
		public function ArrayGameState()
		{
			super();

			_ce = CitrusEngine.getInstance();

			_ce.sound.playSound("Collector");
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
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 1],				
			[1, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 8, 8, 8, 8, 0, 0, 5, 5, 5, 5, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 1, 1, 1, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
			[1, 5, 5, 5, 5, 8, 8, 1, 1, 1, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 1],
			[1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 1, 1],
			[1, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 1, 1, 1, 1, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 0, 0, 5, 5, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 9, 1],
			[1, 5, 5, 5, 5, 5, 5, 8, 8, 8, 5, 5, 5, 5, 5, 0, 9, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1],
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

			_hero.jumpHeight = 12;

			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1920, 1500), new Point(.25, .05)); // x should be 1960 however not showing up beyond the bitmap

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
			var tile1:Tile;
			var tile2:Tile;
			var tile3:Tile;
			var tile4:Tile;
			var tile5:Tile;
			var tile6:Tile;
			var tile7:Tile;
			var tile8:Tile;
			var tile9:Tile;
			var tile10:Tile;
			var tile11:Tile;
			var tile12:Tile;
			var tile13:Tile;
			var tile14:Tile;
			
			var tileImage1:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage2:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage3:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage4:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage5:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage6:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage7:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage8:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage9:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage10:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage11:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage12:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage13:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage14:Image = new Image(Texture.fromBitmap(new  NINE()));
			
			
			tile1 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage1});
			add(tile1);
			
			tile2 = new Tile("blue", "coin", {x:420, y:1140, height:70, width:70, view: tileImage2});
			add(tile2);
			
			tile3 = new Tile("red", "coin", {x:350, y:1140, height:70, width:70, view: tileImage3});
			add(tile3);
			
			tile4 = new Tile("yellow", "coin", {x:350, y:840, height:70, width:70, view: tileImage4});
			add(tile4);
			
			tile5 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage5});
			add(tile5);
			
			tile6 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage6});
			add(tile6);
			
			tile7 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage7});
			add(tile7);
			
			tile8 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage8});
			add(tile8);
			
			tile9 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage9});
			add(tile9);
			
			tile10 = new Tile("red", "coin", {x:1050, y:450, height:70, width:70, view: tileImage10});
			add(tile10);
			
			tile11 = new Tile("red", "coin", {x:1400, y:470, height:70, width:70, view: tileImage11});
			add(tile11);
			
			tile12 = new Tile("red", "coin", {x:1680, y:140, height:70, width:70, view: tileImage12});
			add(tile12);
			
			tile13 = new Tile("red", "coin", {x:770, y:280, height:70, width:70, view: tileImage13});
			add(tile13);
			
			tile14 = new Tile("red", "coin", {x:350, y:210, height:70, width:70, view: tileImage14});
			add(tile14);
		}
		
/*		override public function destroy():void
		{
			super.destroy();			
			CitrusEngine.getInstance().state = new BridgeGameState();
		}	*/	
	}
}