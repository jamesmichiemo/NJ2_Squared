package com.NJSquared.gameCore
{
	public class TileManager
	{
		public static var _redTileCount:uint = 0;
		public static var _blueTileCount:uint = 0;
		public static var _yellowTileCount:uint = 0;
		
		public static var _totalCollected:uint = 0;
		
		public function TileManager()
		{
		}
		
		public static function increaseTileCount(color:String):void
		{
			if(color == "red")
				_redTileCount++;
			else if(color == "blue")
				_blueTileCount++;
			else if(color == "yellow")
				_yellowTileCount++;
			
			_totalCollected = _redTileCount + _blueTileCount + _yellowTileCount;
			
			trace("red ", _redTileCount);
			trace("blue ", _blueTileCount);
			trace("yellow ", _yellowTileCount);
			
			trace("total collected ", _totalCollected);
		}
		
		public static function decreaseTileCount(color:String):void
		{
			if(color == "red")
				_redTileCount--;
			else if(color == "blue")
				_blueTileCount--;
			else if(color == "yellow")
				_yellowTileCount--;
		}

	}
}