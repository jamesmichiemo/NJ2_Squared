package com.NJSquared.gameCore
{
	public class TileManager
	{
		public static var redTileCount:uint = 0;
		public static var blueTileCount:uint = 0;
		public static var yellowTileCount:uint = 0;
		
		public static var totalCollected:uint = 0;
		
		public function TileManager()
		{
		}
		
		public static function increaseTileCount(color:String):void
		{
			if(color == "red")
				redTileCount++;
			else if(color == "blue")
				blueTileCount++;
			else if(color == "yellow")
				yellowTileCount++;
			
			totalCollected = redTileCount + blueTileCount + yellowTileCount;
			
			trace("red ", redTileCount);
			trace("blue ", blueTileCount);
			trace("yellow ", yellowTileCount);
			
			trace("total collected ", totalCollected);
		}
		
		public static function decreaseTileCount(color:String):void
		{
			if(color == "red")
				redTileCount--;
			else if(color == "blue")
				blueTileCount--;
			else if(color == "yellow")
				yellowTileCount--;
			
			totalCollected = redTileCount + blueTileCount + yellowTileCount;
			
			trace("red ", redTileCount);
			trace("blue ", blueTileCount);
			trace("yellow ", yellowTileCount);
			
			trace("total collected ", totalCollected);
		}

	}
}