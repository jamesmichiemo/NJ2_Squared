package com.NJSquared.gameCore
{
	public class LivesManager
	{
		public static var lives:uint = 3;
		
		public function LivesManager()
		{
			super();
		}
		
		public static function decreaseLives():void
		{
			lives--;
			trace("lives ", 3);
		}
	}
}