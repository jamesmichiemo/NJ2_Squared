package com.NJSquared.state
{
	
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import com.NJSquared.gameCore.Key;
	
	import flash.events.KeyboardEvent;
	
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	
	
	
	public class BridgeGameState extends StarlingState implements IState
	{
		private var _bridgeFinished:Boolean = false;
		
		private var _tileXCount:uint = 0;
		private var _tileYCount:uint = 0;
		private var _tileYPos:uint = 665;
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
		[Embed(source = '../assets/images/images_06.png')]
		private var SIX:Class;
		[Embed(source = '../assets/images/waterTile.png')]
		private var EIGHT:Class;
		[Embed(source = '../assets/images/keyYellow.png')]
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
			//_ce.sound.playSound("Puzzle");
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
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12],
				[1, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 5, 1],
				[1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
				[1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1],
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
							image = new Image(starling.textures.Texture.fromBitmap(new ONE()));
						}
						else if(levelOneBridge[i][j] == 5)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new FIVE()));
						}
						else if(levelOneBridge[i][j] == 8)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new EIGHT()));
						}
						else if(levelOneBridge[i][j] == 10)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new TEN()));
						}
						else if(levelOneBridge[i][j] == 11)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new ELEVEN()));
						}
						else if(levelOneBridge[i][j] == 12)
						{
							image = new Image(starling.textures.Texture.fromBitmap(new TWELVE()));
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
//			view.setupCamera(_hero, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1440, 770), new MathVector(.25, .05));
		}
		
		private function onKey(event:com.NJSquared.state.Keyboard):void
		{
		 	if(event.keyCode == 65)
			{
				trace("a");
				buildBridge(_red);
			}
			else if(event.keyCode == 83)
			{
				trace("s");
				buildBridge(_blue);
			}
			else if(event.keyCode == 68)
			{
				trace("d");
				buildBridge(_yellow);
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
			if(_tileYCount <= 1)
			{
				// first tile must be red
				if(_lastColor == 0 && _currentColor == _red)
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
				else if(_lastColor == _red && _currentColor == _blue)
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
				else if(_lastColor == _blue && _currentColor == _yellow)
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
				else if(_lastColor == _yellow && _currentColor == _red)
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
			if(_tileYCount == 1 && _tileXCount == 14)
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
			
			_ce.state = new GameOver();
		}
		
	}
}