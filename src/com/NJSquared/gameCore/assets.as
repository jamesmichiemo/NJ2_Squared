package com.NJSquared.gameCore
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
	    // get the assets
			
			
		// embed the background texture
		[Embed(source="../assets/images/menubg.png")]
		private static var menuBG:Class;
		public static var menuBGTexture:Texture;
		
		
		public static function init():void
		{
			menuBG = Texture.fromBitmapData(new menuBG());
			
			//menuBGTexture = new TextureAtlas(Texture.fromBitmap(new menuBGTexture()), XML(new atlasXML()));
			
		}
		
	}
}