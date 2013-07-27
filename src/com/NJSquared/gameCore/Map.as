package com.NJSquared.gameCore
{
	import starling.display.Sprite;
	
	public class Map extends Sprite
	{
		private var tiles:Tile;
		private var layout:Array;
		private var tileW:int;
		private var tileH:int;
		
		public function Map()
		{
			tileW = 32;
			tileH = 32;
		}
		
		public function buildMap(layout:Array, tiles:Tile):void
		{
			this.tiles = tiles;
			this.layout = layout;
			drawMap();
		}
		
		private function drawMap():void
		{
			var mapWidth:uint = this.layout[0].length;
			var mapHeight:uint = this.layout.length;
			var tmpTile:Tile;
			for (var i:uint = 0; i<mapHeight; ++i)
			{
				for (var j:uint = 0; j<mapWidth; ++j)
				{
					tmpTile = new Tile(layout[i][j]);
					tmpTile.x = j*tileW;
					tmpTile.y = i*tileH;
					addChild(tmpTile);
				}
			}
		}
	}
}