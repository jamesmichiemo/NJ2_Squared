package com.NJSquared.state
{
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	import com.NJSquared.gameCore.Assets;
	import com.citrusengine.core.StarlingState;
	import com.citrusengine.math.MathVector;
	import com.citrusengine.objects.platformer.awayphysics.Hero;
	import com.citrusengine.objects.platformer.awayphysics.Platform;
	import com.citrusengine.physics.box2d.Box2D;
	import com.citrusengine.view.starlingview.StarlingArt;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class TestTwoGameState extends StarlingState
	{
		
		[Embed(source="assets/tmx/tileset-atlas.tmx", mimeType="application/octet-stream")]
		private const _Map:Class;
		
		[Embed(source="assets/tmx/NewTileset.xml", mimeType="application/octet-stream")]
		private const _MapAtlasConfig:Class;

		public function TestTwoGameState()
		{
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero, Platform];
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			Assets.init();
			
			var box2D:Box2D = new Box2D("box2D");
			// box2D.visible = true;
			add(box2D);
			
			//var xml:XML = XML(new _MapAtlasConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(Assets.MapAtlasPngTexture, XML(new _MapAtlasConfig()));
			
			
			ObjectMakerStarling.FromTiledMap(XML(new _Map()), sTextureAtlas);
			
			var hero:Hero = getObjectByName("hero") as Hero;
			
			view.setupCamera(hero, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 5040, 1155), new MathVector(.25, .05));
			
			(view.getArt(getObjectByName("foreground")) as StarlingArt).alpha = 0.3;
		}
	}
}