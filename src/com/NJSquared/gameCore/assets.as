package com.NJSquared.gameCore
{
	import starling.textures.Texture;

	public class Assets
	{
		public function Assets()
		{
			// get the assets
			
			// embed the background texture
			[Embed(source="assets/images/menubg.png")]
			private static var menuBG:Class;
			public static var menuBGTexture:Texture;
		}
	}
}