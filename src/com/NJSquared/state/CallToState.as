package com.NJSquared.state
{
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.system.Entity;
	import citrus.system.components.ViewComponent;
	import citrus.view.ACitrusView;
	
	import starling.display.Sprite;
	
	public class CallToState extends Sprite implements IState
	{
		public function CallToState()
		{
			super();
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