package com.NJSquared.Core
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;

	
	import com.citrusengine.objects.Box2DPhysicsObject;
	import com.citrusengine.physics.PhysicsCollisionCategories;

	import com.citrusengine.utils.Box2DShapeMaker;
	
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	public class Enemy extends Box2DPhysicsObject
	{
		public function Enemy(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function createShape():void
		{
			super.createShape();
			
			var sensorWidth:Number = 0;
		}
		
		override public function handleBeginContact(contact:b2Contact):void {
//			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
		}
	}
}