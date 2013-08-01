package com.NJSquared.state
{	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import com.NJSquared.gameCore.Assets;
	import com.NJSquared.gameCore.LivesManager;
	import com.NJSquared.gameCore.Tile;
	import com.NJSquared.gameCore.TileManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.KeyboardEvent;
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
		[Embed(source = '../assets/images/leftSideCornerGrassTile.png')] // left side round corners 
		private var FIFTEEN:Class;
		[Embed(source = '../assets/images/RightSideCornerGrassTile.png')] // right side round corners 
		private var SIXTEEN:Class;
		[Embed(source = '../assets/images/AllCornerGrassTile.png')] // all round corners
		private var SEVENTEEN:Class;
		
		[Embed(source = '../assets/images/rockWGrass.png')] // rock
		private var ROCK:Class;
		
		[Embed(source = '../assets/images/livesText.png')] // lives text
		private var LIVES:Class;
		[Embed(source = '../assets/images/lifeHeart.png')] // lives text
		private var HEART:Class;
		
		[Embed(source = '../assets/images/blueTileDisplay.png')] // blue tile display
		private var BLUE_DISPLAY:Class;
		[Embed(source = '../assets/images/redTileDisplay.png')] // red tile display
		private var RED_DISPLAY:Class;
		[Embed(source = '../assets/images/yellowTileDisplay.png')] // yellow tile display
		private var YELLOW_DISPLAY:Class;
		
		[Embed(source = '../assets/images/signMainGame.png')]
		private var SIGN:Class;
		
		private var _livesArray:Array = [];

		private var _height2:uint;

		private var _width2:uint;

		private var _enemy:Enemy;
		private var _levelOneTwo:Array;

		private var level:Array;
		private var _tile:Tile;
		private var contact:b2Contact;

		private var _yellowTileCount:TextField;
		private var _redTileCount:TextField;
		private var _blueTileCount:TextField;
		private var _signMessage:Object;
		
		private var _isDead:Boolean = false;
		
		public function ArrayGameState()
		{
			super();
			_ce = CitrusEngine.getInstance();
			_ce.sound.playSound("Collector");
		}
		
		override public function initialize():void 
		{
			super.initialize();
			

			_ce.sound.playSound("Title");

			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			_levelOne = [
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],				
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 02, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 05, 05, 05, 05, 05, 05, 10, 00, 15, 05, 05, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 15, 01, 01, 01, 01, 01, 01, 01, 01, 12, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 11, 05, 05, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 05, 05, 05, 05, 05, 05, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 00, 15, 16, 00, 00, 00, 00, 00, 00, 01],
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 16, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 05, 05, 10, 00, 00, 00, 00, 00, 00, 13, 01, 01, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01, 01, 01, 02, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 15, 05, 05, 01, 01, 01, 01, 01, 05, 05, 05, 05, 16, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 11, 05, 05, 05, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 13, 01, 01, 01, 12, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 15, 05, 16, 00, 00, 00, 00, 15, 05, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 15, 05, 16, 00, 00, 00, 17, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 01],
			[01, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
			[01, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 01],
			[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01]
			];
			
			placeTiles();
		}	
		
		private function placeTiles():void
		{
			level = _levelOne;
			
			_width2 = _levelOne[0].length * 70;
			_height2 = _levelOne.length * 70;

			var bd1:BitmapData=new BitmapData(_width2,_height2, false, 0xaedfe8);
			
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
						else if(level[i][j] == 2)
						{
							image = new ROCK();
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
						
						else if(level[i][j] == 15)
						{
							image = new FIFTEEN();
						}
						
						else if(level[i][j] == 16)
						{
							image = new SIXTEEN();
						}
						
						else if(level[i][j] == 17)
						{
							image = new SEVENTEEN();
						}
						
						if(level[i][j] == 2)
						{
							var rock:Platform = new Platform("cloud", {x:j*70+35, y:i*70+35, height:70, width:70});
							add(rock);
							bd1.draw(image, new Matrix(1, 0, 0, 1, j*70+35, i*70+45));
						}
						else if(level[i][j] == 1 || level[i][j] == 5 || level[i][j] == 10 || level[i][j] == 11 || level[i][j] == 12 || level[i][j] == 13 || level[i][j] == 15 || level[i][j] == 16 || level[i][j] == 17)
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
			
			var sign:Platform;
			var signImage:Image = new Image(Texture.fromBitmap(new  SIGN()));
			sign = new Platform("cloud", {x:210, y:466, height:70, width:70, view:signImage, oneWay:true});
			add(sign);

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
			
			_yellowTileCount = new TextField(100,100,"00", "Helvetica");
			_yellowTileCount.fontSize = 32;
			_yellowTileCount.color = 0x282828;
			_yellowTileCount.x = 885;
			_yellowTileCount.y = 10;
			addChild(_yellowTileCount);
			
			// red tiles
			var redDisplayTexture:Texture = Texture.fromBitmap(new RED_DISPLAY());
			var redDisplayImage:Image = new Image(redDisplayTexture);
			redDisplayImage.x = 980;
			redDisplayImage.y = 20;
			addChild(redDisplayImage);
			
			_redTileCount = new TextField(100,100,"00", "Helvetica");
			_redTileCount.fontSize = 32;
			_redTileCount.color = 0x282828;
			_redTileCount.x = 1025;
			_redTileCount.y = 10;
			addChild(_redTileCount);
			
			// blue tiles
			var blueDisplayTexture:Texture = Texture.fromBitmap(new BLUE_DISPLAY());
			var blueDisplayImage:Image = new Image(blueDisplayTexture);
			blueDisplayImage.x = 1120;
			blueDisplayImage.y = 20;
			addChild(blueDisplayImage);
			
			_blueTileCount = new TextField(100,100,"00", "Helvetica");
			_blueTileCount.fontSize = 32;
			_blueTileCount.color = 0x282828;
			_blueTileCount.x = 1165;
			_blueTileCount.y = 10;
			addChild(_blueTileCount);	
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
		
		
		private function handleHeroJump():void 
		{
			_ce.sound.playSound("Jump");
		}
		
		private function handleHeroGiveDamage():void 
		{
			_ce.sound.playSound("Kill");
		}
		
		private function handleHeroTakeDamage():void 
		{
			_ce.sound.playSound("Hurt");
			
			if(LivesManager.livesCount > 0)
			{
				LivesManager.livesCount--;
				trace("lives", LivesManager.livesCount);
				
				removeChild(_livesArray[LivesManager.livesCount]);
				trace(_livesArray);
			}
			
			if(LivesManager.livesCount <= 0)
			{
				trace("died...");
				_isDead = true;
				destroy();
			}
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
			
			
			tile1 = new Tile("red", "coin", {x:1600, y:1305, height:70, width:70, view: tileImage1});
			add(tile1);
			
			tile2 = new Tile("blue", "coin", {x:1300, y:1305, height:70, width:70, view: tileImage2});
			add(tile2);
			
			tile3 = new Tile("red", "coin", {x:350, y:1280, height:70, width:70, view: tileImage3});
			add(tile3);
			
			tile4 = new Tile("yellow", "coin", {x:1820, y:1050, height:70, width:70, view: tileImage4});
			add(tile4);
			
			tile5 = new Tile("blue", "coin", {x:1740, y:540, height:70, width:70, view: tileImage5});
			add(tile5);
			
			tile6 = new Tile("red", "coin", {x:130, y:1125, height:70, width:70, view: tileImage6});
			add(tile6);
			
			tile7 = new Tile("blue", "coin", {x:380, y:840, height:70, width:70, view: tileImage7});
			add(tile7);
			
			tile8 = new Tile("yellow", "coin", {x:1155, y:1100, height:70, width:70, view: tileImage8});
			add(tile8);
			
			tile9 = new Tile("red", "coin", {x:1150, y:560, height:70, width:70, view: tileImage9});
			add(tile9); 
			
			tile10 = new Tile("yellow", "coin", {x:960, y:560, height:70, width:70, view: tileImage10});
			add(tile10); 
			
			tile11 = new Tile("blue", "coin", {x:1400, y:490, height:70, width:70, view: tileImage11});
			add(tile11);
			
			tile12 = new Tile("yellow", "coin", {x:1680, y:140, height:70, width:70, view: tileImage12});
			add(tile12);
			
			tile13 = new Tile("blue", "coin", {x:770, y:280, height:70, width:70, view: tileImage13});
			add(tile13);
			
			tile14 = new Tile("yellow", "coin", {x:1060, y:190, height:70, width:70, view: tileImage14});
			add(tile14);
			
			tile15 = new Tile("red", "coin", {x:480, y:340, height:70, width:70, view: tileImage15});
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
			
			_yellowTileCount.text = String(TileManager.yellowTileCount);
			_redTileCount.text = String(TileManager.redTileCount);
			_blueTileCount.text = String(TileManager.blueTileCount);
			
			if(_hero.x >= 1820 && _hero.y >= 1330 && TileManager.totalCollected >= 14)
			{
				//trace("game over");
				destroy();
			}
		}
		
		override public function destroy():void
		{
			//super.destroy();
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.playSound("Start");
			
			if(_isDead == true)
			{
				LivesManager.livesCount = 3;
				TileManager.yellowTileCount = 0;
				TileManager.blueTileCount = 0;
				TileManager.redTileCount = 0;
				_ce.state = new GameOver();
			}
			else
			{
				_ce.state = new BridgeGameState();
			}
		}	
	}
}