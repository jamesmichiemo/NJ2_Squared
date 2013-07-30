package com.NJSquared.state
{


	public interface IStates 
	{
		//function init(event:Event):void;
		function update(timeDelta:Number):void;
		function destroy():void;
	}
}