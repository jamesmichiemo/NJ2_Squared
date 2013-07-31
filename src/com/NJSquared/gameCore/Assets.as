package com.NJSquared.gameCore
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Assets
	{
		
		// get the assets
		
		//menu bg
		[Embed(source="../assets/images/menu_bg.png")]
		private const menuBG:Class;
		public static var menuBGTexture:Texture;
		
		// embed button
		[Embed(source="../assets/images/playBtn.png")]
		private static var btn:Class;
		public static var btnTexture:Texture;
		//public  var btnImage:Image = new Image(Texture.fromBitmap(new btn()));
		
/*		//image_1 png 
		[Embed(source = "assets/images/images_01.png")]
		private static var ONE:Class;*/
		
		//public static var oneImage:Image = new Image(Texture.fromBitmap(new ONE()));

		public function Assets()
		{
			super();
		}
		
		
		public static function init():void
		{
		//	menuBGTexture = Texture.fromBitmap(new menuBG());
			
			btnTexture = Texture.fromBitmap(new btn());
			
			//oneImage = new Image(Texture.fromBitmap(new ONE()));
		}
		
	}
}