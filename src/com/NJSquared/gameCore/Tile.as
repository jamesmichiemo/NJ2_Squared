package com.NJSquared.gameCore
{
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	import com.NJSquared.state.ConcreteHero;
	
	import flash.utils.getDefinitionByName;
	
	public class Tile extends Coin
	{
		//protected var _collectorClass:Class = Hero;
		
		private var _color:String;
		
		public function Tile(color:String, name:String, params:Object=null)
		{
			super(name, params);
			
			_color = color;
		}
		
		override public function handleBeginContact(contact:b2Contact):void
		{
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			trace("COLLIDER ", collider);
			
			if(collider is Hero)
			{
				trace("collected tile");
				super.handleBeginContact(contact);	
				TileManager.increaseTileCount(_color);
			}
		}
	}
}