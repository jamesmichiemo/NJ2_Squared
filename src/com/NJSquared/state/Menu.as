package com.NJSquared.state
{
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.system.Entity;
	import citrus.system.components.ViewComponent;
	import citrus.view.ACitrusView;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends Sprite implements IState
	{
		[Embed(source="assets/images/play_btn.png")]
		private const _playBtn:Class;
		
		private var background:BackgroundColor;
		private var callToState:CallToState;
		private var background:Image;
		private var play:Button;
		
		public function Menu(callToState:CallToState)
		{
			super();
			
			this.callToState = callToState;
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		public function destroy():void
		{
			
		}
		
		public function get view():ACitrusView
		{
			return null;
		}
		
		public function initialize():void
		{

		}
		
		public function update(timeDelta:Number):void
		{
			// istate
		}
		
		public function add(object:CitrusObject):CitrusObject
		{
			return null;
		}
		
		public function addEntity(entity:Entity, view:ViewComponent=null):Entity
		{
			return null;
		}
		
		public function remove(object:CitrusObject):void
		{
		}
		
		public function getObjectByName(name:String):CitrusObject
		{
			return null;
		}
		
		public function getFirstObjectByType(type:Class):CitrusObject
		{
			return null;
		}
		
		public function getObjectsByType(type:Class):Vector.<CitrusObject>
		{
			return null;
		}
	}
}