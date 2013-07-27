package com.NJSquared.state
{
	import com.NJSquared.gameCore.Map;
	import com.NJSquared.gameCore.Tile;
	import com.citrusengine.core.StarlingState;
	
	import starling.events.Event;
	
	public class TestThreeGameState extends StarlingState
	{
		private var level1:Array;
		private var map:Map;
		
		public function TestThreeGameState()
		{
			
			level1 = [
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
				[1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1],
				[1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1],
				[1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			];
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			map = new Map();
			map.buildMap(level1, new Tile());
			addChild(map);
		}
	}
}