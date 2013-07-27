package com.NJSquared.gameCore
{
	import flash.display.Bitmap;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
		
	public class Tile extends Sprite
	{
			
		[Embed(source="assets/tmx/texturepacker-tiles-atlas.xml", mimeType="application/octet-stream")]
		public const SpriteSheetXML:Class;
		
		[Embed(source="assets/tmx/texturepacker-tiles-atlas.png", mimeType="image/png")]
		public const TileSheet:Class;
			
		private var tileMovie:MovieClip;
		private var frame:uint;
			
		public function Tile(frame:uint=0)
		{
			this.frame = frame;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
			
		private function onAdded(event:Event):void
		{
			tileMovie = createClip();
			addChild(tileMovie);
			tileMovie.currentFrame = this.frame;
		}
			
		private function createClip():MovieClip
		{
			var bitmap:Bitmap = new TileSheet();
			trace("BIT ",bitmap);
			var texture:Texture = Texture.fromBitmap(bitmap);
			trace("texture ",texture);
			var xml:XML = XML(new SpriteSheetXML());
			trace("xml ",xml);
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			trace("stext ",sTextureAtlas);
			var frames:Vector.<Texture> = sTextureAtlas.getTextures("tile_");
			trace("frame ",frames);
				
			return new MovieClip(frames);
		}
	}
}