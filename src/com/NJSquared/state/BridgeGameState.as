package com.NJSquared.state
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.sounds.CitrusSoundGroup;
	
	import com.NJSquared.gameCore.TileManager;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;

	

	public class BridgeGameState extends StarlingState
	{
		private var _citrusEngine:CitrusEngine;
		
		private var _bridgeFinished:Boolean = false;
		
		private var _tileXCount:uint = 0;
		private var _tileYCount:uint = 0;
		private var _tileYPos:uint = 595;
		private var _lastColor:uint;
		private var _currentColor:uint;
		
		private var _red:uint = 0xff0000;
		private var _yellow:uint = 0x00ff00;
		private var _blue:uint = 0x0000ff;
		
		private var _barrier:Platform;
		
		private var levelOneBridge:Array = [];
		private var _hero:ConcreteHero;
		
		[Embed(source = '../assets/images/groundTile.png')]
		private var ONE:Class;
		[Embed(source = '../assets/images/images_04.png')]
		private var FOUR:Class;
		[Embed(source = '../assets/images/grassTile.png')]
		private var FIVE:Class;
		[Embed(source = '../assets/images/waterTile.png')]
		private var EIGHT:Class;
		[Embed(source = '../assets/images/redTile.png')]
		private var NINE:Class;
		[Embed(source = '../assets/images/blockerMad.png')]
		private var SEVEN:Class;
		[Embed(source = '../assets/images/rightCornerGrassTile.png')]
		private var TEN:Class;
		[Embed(source = '../assets/images/leftCornerGrassTile.png')]
		private var ELEVEN:Class;
		[Embed(source = '../assets/images/portalTile.png')]
		private var TWELVE:Class;
		
		[Embed(source = '../assets/images/redBridgeTile.png')]
		private var RED:Class;
		[Embed(source = '../assets/images/blueBridgeTile.png')]
		private var BLUE:Class;
		[Embed(source = '../assets/images/yellowBridgeTile.png')]
		private var YELLOW:Class;

		
		public function BridgeGameState()
		{
			super();
			_citrusEngine = CitrusEngine.getInstance();
			_citrusEngine.sound.playSound("Puzzle");
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			trace("bridge state");
			
			stage.color = 0x8becfb;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			levelOneBridge = [
				[01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01],
				[01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 12],
				[01, 05, 10, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 11, 05, 01],
				[01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01],
				[01, 01, 01, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 01, 01, 01],
			];
			
			createLevel();
		}
		
		private function createLevel():void
		{
			for(var i:int = 0; i < levelOneBridge.length; i++)
			{
				
				for(var j:int = 0; j < levelOneBridge[i].length; j++)
				{
					var image:Image;
					
					if(levelOneBridge[i][j] != 0)
					{
						if(levelOneBridge[i][j] == 1)
						{
							image = new Image(Texture.fromBitmap(new ONE()));
						}
						else if(levelOneBridge[i][j] == 5)
						{
							image = new Image(Texture.fromBitmap(new FIVE()));
						}
						else if(levelOneBridge[i][j] == 8)
						{
							image = new Image(Texture.fromBitmap(new EIGHT()));
						}
						else if(levelOneBridge[i][j] == 10)
						{
							image = new Image(Texture.fromBitmap(new TEN()));
						}
						else if(levelOneBridge[i][j] == 11)
						{
							image = new Image(Texture.fromBitmap(new ELEVEN()));
						}
						else if(levelOneBridge[i][j] == 12)
						{
							image = new Image(Texture.fromBitmap(new TWELVE()));
						}
						
						var platform:Platform = new Platform("platform", {x:j*70+35, y:i*70+35, height:70, width:70, view: image});
						add(platform);
					}
				}
			}
			
			_barrier = new Platform ("barrier", {x:245, y:525, height:370, width:70});
			add(_barrier);
			
			addHero();
		}
		
		private function addHero():void
		{
			var heroImage:Image = new Image(starling.textures.Texture.fromBitmap(new FOUR()));
			
			_hero = new ConcreteHero("hero", {x:150, y:200, height:40, width:30, view: heroImage});
			add(_hero);
			

			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1440, 770), new Point(.25, .05));
			
		}
		
		private function onKey(event:KeyboardEvent):void
		{
		 	if(event.keyCode == 65)
			{
				trace("a");
				buildBridge(_red);
				_ce.sound.playSound("Pick");
			}
			else if(event.keyCode == 83)
			{
				trace("s");
				buildBridge(_blue);
				_ce.sound.playSound("Pick");
			}
			else if(event.keyCode == 68)
			{
				trace("d");
				buildBridge(_yellow);
				_ce.sound.playSound("Pick");
			}
		}
		
		private function buildBridge(color:uint):void
		{
			var redTile:Image = new Image(starling.textures.Texture.fromBitmap(new RED()));
			var blueTile:Image = new Image(starling.textures.Texture.fromBitmap(new BLUE()));
			var yellowTile:Image = new Image(starling.textures.Texture.fromBitmap(new YELLOW()));
			
			_currentColor = color;
			
			// if the first row of tiles have been placed
			if(_tileXCount == 14) 
			{
				_tileXCount = 0;
				_tileYCount++;
				_tileYPos = 595;
			}
			
			// if the bridge isn't finished
			if(_tileYCount < 1)
			{
				// first tile must be red
				if(_lastColor == 0 && _currentColor == _red && TileManager.redTileCount != 0)
				{	
					var tileOne:Platform = new Platform("platform", {x:245 + (70*_tileXCount), y:_tileYPos, height:70, width:70, view: redTile});
					add(tileOne);
				
					_tileXCount++;
					_lastColor = color;
					
					TileManager.decreaseTileCount("red");
				}
				else if(_lastColor == 0 && (_currentColor == _blue || _currentColor == _yellow))
				{	
					trace("wrongg");
				}
				// blue can only go after red
				else if(_lastColor == _red && _currentColor == _blue && TileManager.blueTileCount != 0)
				{	
					var tileBlue:Platform = new Platform("platform", {x:245 + (70*_tileXCount), y:_tileYPos, height:70, width:70, view: blueTile});
					add(tileBlue);
					
					_tileXCount++;
					_lastColor = color;
					
					TileManager.decreaseTileCount("blue");
				}
				else if(_lastColor == _red && (_currentColor == _yellow || _currentColor == _red))
				{	
					trace("wrongg");
				}
				// yellow can only go after blue
				else if(_lastColor == _blue && _currentColor == _yellow && TileManager.yellowTileCount != 0)
				{	
					var tileyellow:Platform = new Platform("platform", {x:245 + (70*_tileXCount), y:_tileYPos, height:70, width:70, view: yellowTile});
					add(tileyellow);
					
					_tileXCount++;
					_lastColor = color;
					
					TileManager.decreaseTileCount("yellow");
				}
				else if(_lastColor == _blue && (_currentColor == _blue || _currentColor == _red))
				{	
					trace("wrongg");
				}
				// red can only go after yellow
				else if(_lastColor == _yellow && _currentColor == _red && TileManager.redTileCount != 0)
				{	
					var tileRed:Platform = new Platform("platform", {x:245 + (70*_tileXCount), y:_tileYPos, height:70, width:70, view: redTile});
					add(tileRed);
				
					_tileXCount++;
					_lastColor = color;
					
					TileManager.decreaseTileCount("red");
				}
				else if(_lastColor == _yellow && (_currentColor == _blue || _currentColor == _yellow))
				{	
					trace("wrongg");
				}
			}
			
			// if the bridge is finished	
			if(_tileYCount == 0 && _tileXCount == 14)
			{
				trace("bridge finished");
				remove(_barrier);
				
				_bridgeFinished = true;
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);

			if(_bridgeFinished == true && _hero.x >= 1290)
			{
				trace("game over");
				destroy();
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			_ce.sound.removeSound("Puzzle");
			//_ce.sound.playSound("Victory");
			
			_ce.state = new Menu();
		}
		
	}
}