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
	import com.NJSquared.gameCore.TileManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	
	public class ArrayGameState extends StarlingState
	{
		private var _levelOne:Array = [];

		private var _hero:ConcreteHero;
		private var _tiles:Vector.<CitrusObject>;
		private var _totalCollectedTiles:TileManager;
		
		
		[Embed(source = '../assets/images/groundTile.png')] // dirt
		private var ONE:Class;
		[Embed(source = '../assets/images/yellowTile.png')] // yellow tile
		private var TWO:Class;
		[Embed(source = '../assets/images/blueTile.png')] // blue tiles
		private var THREE:Class;
		[Embed(source = '../assets/images/images_04.png')] // hero
		private var FOUR:Class;
		[Embed(source = '../assets/images/grassTile.png')] // grass
		private var FIVE:Class;
		[Embed(source = '../assets/images/blockerMad.png')] // enemy
		private var SEVEN:Class;
		[Embed(source = '../assets/images/waterTile.png')] // water
		private var EIGHT:Class;
		[Embed(source = '../assets/images/redTile.png')] // red tiles
		private var NINE:Class;
		[Embed(source = '../assets/images/rightCornerGrassTile.png')] // grass right corner
		private var TEN:Class;
		[Embed(source = '../assets/images/leftCornerGrassTile.png')] // grass left corner
		private var ELEVEN:Class;
		[Embed(source = '../assets/images/rightCornerGroundTile.png')] // ground right corner
		private var TWELVE:Class;
		[Embed(source = '../assets/images/leftCornerGroundTile.png')] // ground left corner
		private var THIRTEEN:Class;
		[Embed(source = '../assets/images/portalTile.png')] // portal
		private var FOURTEEN:Class;
		
		[Embed(source = '../assets/images/livesText.png')] // lives text
		private var LIVES:Class;
		[Embed(source = '../assets/images/lifeHeart.png')] // lives text
		private var HEART:Class;
		
		[Embed(source = '../assets/images/blueTileDisplay.png')] // blue tile display
		private var BLUE_DISPLAY:Class;
		[Embed(source = '../assets/images/redTileDisplay.png')] // red tile display
		private var RED_DISPLAY:Class;
		[Embed(source = '../assets/images/yellowTileDisplay.png')] // blue tile display
		private var YELLOW_DISPLAY:Class;
		
		private var _livesArray:Array = [];

		private var _height2:uint;

		private var _width2:uint;

		private var _enemy:Enemy;
		private var _levelOneTwo:Array;

		private var level:Array;
		private var _tile:Tile;
		private var contact:b2Contact;
		
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
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],				
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 05, 05, 08, 08, 08, 08, 10, 00, 11, 05, 05, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 01, 01, 01, 01, 05, 05, 05, 05, 12, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 11, 05, 05, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 05, 05, 05, 10, 08, 08, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 00, 11, 10, 00, 00, 00, 00, 00, 00, 01],
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 05, 05, 10, 00, 00, 00, 00, 00, 00, 13, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 05, 01, 01, 01, 01, 01, 05, 05, 05, 05, 10, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 11, 05, 05, 05, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 13, 01, 01, 01, 12, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 10, 00, 00, 00, 00, 11, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 10, 00, 00, 00, 05, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 05, 05, 05, 05, 05, 10, 08, 08, 08, 11, 05, 05, 05, 10, 00, 00, 11, 05, 05, 05, 05, 05, 05, 05, 05, 05, 01],
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01]
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
						
						else if(level[i][j] == 10)
						{
							image = new TEN();
						}
						
						else if(level[i][j] == 11)
						{
							image = new ELEVEN();
						}
						
						else if(level[i][j] == 12)
						{
							image = new TWELVE();
						}
						
						else if(level[i][j] == 13)
						{
							image = new THIRTEEN();
						}
					
						if(level[i][j] == 1 || level[i][j] == 5 || level[i][j] == 8 || level[i][j] == 10 || level[i][j] == 11 || level[i][j] == 12 || level[i][j] == 13)
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

			var portal:Platform;
			var portalImage:Image = new Image(Texture.fromBitmap(new  FOURTEEN()));
			portal = new Platform("cloud", {x:1855, y:1365, height:70, width:70, view:portalImage, oneWay:true});
			add(portal);
			

//			SPLOOSH!
//			var water:Platform;
//			var waterImage:Image = new Image(Texture.fromBitmap(new  EIGHT()));
//			water = new Platform("cloud", {x:560, y:140, height:70, width:210, view:portalImage, oneWay:true});
//			add(water);

			addHud();

			
			addHero();

			addEnemies();
			addTiles();
		}
		
		private function addHud():void
		{
			// lives display
			var livesTexture:Texture = Texture.fromBitmap(new LIVES());
			var livesImage:Image = new Image(livesTexture);
			livesImage.x = 20;
			livesImage.y = 20;
			addChild(livesImage);
			
			var heartsTexture:Texture = Texture.fromBitmap(new HEART());
			var heartsImageOne:Image = new Image(heartsTexture);
			var heartsImageTwo:Image = new Image(heartsTexture);
			var heartsImageThree:Image = new Image(heartsTexture);
			
			heartsImageOne.y = heartsImageTwo.y = heartsImageThree.y = 34;
			heartsImageOne.x = 140;
			heartsImageTwo.x = 200;
			heartsImageThree.x = 260;
			
			_livesArray = [heartsImageOne, heartsImageTwo, heartsImageThree];
			addChild(heartsImageOne);
			addChild(heartsImageTwo);
			addChild(heartsImageThree);
			
			// tile displays
			// yellow tiles
			var yellowDisplayTexture:Texture = Texture.fromBitmap(new YELLOW_DISPLAY());
			var yellowDisplayImage:Image = new Image(yellowDisplayTexture);
			yellowDisplayImage.x = 840;
			yellowDisplayImage.y = 20;
			addChild(yellowDisplayImage);
			
			var yellowTileCount:TextField = new TextField(100,100,"00", "Helvetica");
			yellowTileCount.fontSize = 32;
			yellowTileCount.color = 0x282828;
			yellowTileCount.x = 885;
			yellowTileCount.y = 10;
			addChild(yellowTileCount);
			
			// red tiles
			var redDisplayTexture:Texture = Texture.fromBitmap(new RED_DISPLAY());
			var redDisplayImage:Image = new Image(redDisplayTexture);
			redDisplayImage.x = 980;
			redDisplayImage.y = 20;
			addChild(redDisplayImage);
			
			var redTileCount:TextField = new TextField(100,100,"00", "Helvetica");
			redTileCount.fontSize = 32;
			redTileCount.color = 0x282828;
			redTileCount.x = 1025;
			redTileCount.y = 10;
			addChild(redTileCount);
			
			// blue tiles
			var blueDisplayTexture:Texture = Texture.fromBitmap(new BLUE_DISPLAY());
			var blueDisplayImage:Image = new Image(blueDisplayTexture);
			blueDisplayImage.x = 1120;
			blueDisplayImage.y = 20;
			addChild(blueDisplayImage);
			
			var blueTileCount:TextField = new TextField(100,100,"00", "Helvetica");
			blueTileCount.fontSize = 32;
			blueTileCount.color = 0x282828;
			blueTileCount.x = 1165;
			blueTileCount.y = 10;
			addChild(blueTileCount);
			
		}
		
		private function addHero():void
		{
			var heroImage:Image = new Image(Texture.fromBitmap(new FOUR()));
			
			_hero = new ConcreteHero("hero", {x:100, y:300, height:40, width:30, view: heroImage});

			add(_hero);
			
			_hero.onJump.add(handleHeroJump);
			_hero.onGiveDamage.add(handleHeroGiveDamage);
			_hero.onTakeDamage.add(handleHeroTakeDamage);
			

			_hero.jumpHeight = 12;

			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1920, 1500), new Point(.25, .05)); // x should be 1960 however not showing up beyond the bitmap
		}
		
		
		private function handleHeroJump():void {
			_ce.sound.playSound("Jump");
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
			
			enemy = new Enemy("enemy", {x:350, y:400, height:68, width:68, view: enemyImage1, leftBound:0});
			add(enemy);
			
			enemyTwo = new Enemy("enemy", {x:630, y:420, height:68, width:68, view: enemyImage2, leftBound:0});
			add(enemyTwo);
			
			enemyThree = new Enemy("enemy", {x:1400, y:140, height:68, width:68, view: enemyImage3, leftBound:0});
			add(enemyThree);
			
			enemyFour = new Enemy("enemy", {x:800, y:840, height:68, width:68, view: enemyImage4, leftBound:0});
			add(enemyFour);
			
			enemyFive = new Enemy("enemy", {x:1610, y:840, height:68, width:68, view: enemyImage5, leftBound:0});
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
			var tile15:Tile;
			
			var tileImage1:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage2:Image = new Image(Texture.fromBitmap(new  THREE()));
			var tileImage3:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage4:Image = new Image(Texture.fromBitmap(new  TWO()));
			var tileImage5:Image = new Image(Texture.fromBitmap(new  THREE()));
			var tileImage6:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage7:Image = new Image(Texture.fromBitmap(new  THREE()));
			var tileImage8:Image = new Image(Texture.fromBitmap(new  TWO()));
			var tileImage9:Image = new Image(Texture.fromBitmap(new  NINE()));
			var tileImage10:Image = new Image(Texture.fromBitmap(new  TWO()));
			var tileImage11:Image = new Image(Texture.fromBitmap(new  THREE()));
			var tileImage12:Image = new Image(Texture.fromBitmap(new  TWO()));
			var tileImage13:Image = new Image(Texture.fromBitmap(new  THREE()));
			var tileImage14:Image = new Image(Texture.fromBitmap(new  TWO()));
			var tileImage15:Image = new Image(Texture.fromBitmap(new  NINE()));
			
			
			tile1 = new Tile("red", "coin", {x:350, y:840, height:70, width:70, view: tileImage1});
			add(tile1);
			
			tile2 = new Tile("blue", "coin", {x:420, y:1210, height:70, width:70, view: tileImage2});
			add(tile2);
			
			tile3 = new Tile("red", "coin", {x:350, y:1210, height:70, width:70, view: tileImage3});
			add(tile3);
			
			tile4 = new Tile("yellow", "coin", {x:1820, y:1050, height:70, width:70, view: tileImage4});
			add(tile4);
			
			tile5 = new Tile("blue", "coin", {x:1220, y:1000, height:70, width:70, view: tileImage5});
			add(tile5);
			
			tile6 = new Tile("red", "coin", {x:140, y:1390, height:70, width:70, view: tileImage6});
			add(tile6);
			
			tile7 = new Tile("blue", "coin", {x:140, y:770, height:70, width:70, view: tileImage7});
			add(tile7);
			
			tile8 = new Tile("yellow", "coin", {x:1680, y:460, height:70, width:70, view: tileImage8});
			add(tile8);
			
			tile9 = new Tile("red", "coin", {x:1190, y:480, height:70, width:70, view: tileImage9});
			add(tile9); 
			
			tile10 = new Tile("yellow", "coin", {x:1050, y:460, height:70, width:70, view: tileImage10});
			add(tile10); 
			
			tile11 = new Tile("blue", "coin", {x:1400, y:470, height:70, width:70, view: tileImage11});
			add(tile11);
			
			tile12 = new Tile("yellow", "coin", {x:1680, y:140, height:70, width:70, view: tileImage12});
			add(tile12);
			
			tile13 = new Tile("blue", "coin", {x:770, y:280, height:70, width:70, view: tileImage13});
			add(tile13);
			
			tile14 = new Tile("yellow", "coin", {x:350, y:210, height:70, width:70, view: tileImage14});
			add(tile14);
			
			tile15 = new Tile("red", "coin", {x:350, y:210, height:70, width:70, view: tileImage15});
			add(tile15);


			_tiles = getObjectsByType(Coin);
			for each (var tile:Coin in _tiles)
			  tile.onBeginContact.add(handleJewelCollected);
		}
		
		private function handleJewelCollected(contact:b2Contact):void
		{
			_ce.sound.playSound("Pick");			
		}
	
	override public function update(timeDelta:Number):void
	{
		super.update(timeDelta);
		
		if(_hero.x >= 1820 && _hero.y >= 1330 && TileManager.totalCollected >= 14)
		{
			trace("game over");
			destroy();
		}
	}
		
		override public function destroy():void
		{
			super.destroy();
			_ce.sound.removeSound("Collector");
			_ce.sound.playSound("Start");
			_ce.state = new BridgeGameState();
			
		}		
	}
}