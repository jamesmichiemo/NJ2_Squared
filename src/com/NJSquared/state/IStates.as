package com.NJSquared.state
{
	import starling.events.Event;

	public interface IStates 
	{
		//function init(event:Event):void;
		function update(timeDelta:Number):void;
		function destroy():void;
	}
}