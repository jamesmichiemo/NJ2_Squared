package com.NJSquared.state
{
	import citrus.core.starling.StarlingState;
	
	import com.NJSquared.gameCore.Assets;
	
	import starling.display.Image;
	
	public class Menu extends StarlingState
	{
		public function Menu()
		{
			super();
		}
		
		private function init():void
		{
			var background = new Image(Assets("menuBGTexture"));
			addChild(background);
		}
	}
}