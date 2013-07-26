	package com.NJSquared.state
{
		import citrus.core.State;
		import citrus.core.starling.StarlingState;
		import citrus.objects.platformer.box2d.Hero;
		import citrus.objects.platformer.box2d.Platform;
		import citrus.physics.box2d.Box2D;
		import citrus.utils.objectmakers.ObjectMaker2D;
		import citrus.utils.objectmakers.ObjectMakerStarling;
		import citrus.view.spriteview.SpriteArt;
		import citrus.view.starlingview.StarlingArt;
		
		import flash.display.Bitmap;
		import flash.geom.Point;
		import flash.geom.Rectangle;
		
		import starling.textures.Texture;
		import starling.textures.TextureAtlas;
	
	public class GameState extends State
	{
		[Embed(source="assets/tmx/Tileset.tmx", mimeType="application/octet-stream")]
		private const _Map:Class;
		
		[Embed(source="assets/tmx/Tileset.png")]
		private const _ImgTiles:Class;
		
		public function GameState() {
			
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero, Platform];
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			var bmp:Bitmap = new _ImgTiles();
			// we must add the image name so we know which image is chosen.
			bmp.name = "Tileset.png";
			
			ObjectMaker2D.FromTiledMap(XML(new _Map()), [bmp]);
			
			var hero:Hero = getObjectByName("hero") as Hero;
			
			view.camera.setUp(hero, new Point(stage.stageWidth / 2, 240), new Rectangle(0, 0, 1280, 640), new Point(.25, .05));
			
			(view.getArt(getObjectByName("hero")) as SpriteArt).alpha = 0.3;
		}
		
	}
	}