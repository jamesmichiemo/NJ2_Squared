package com.NJSquared.state
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	public class ConcreteHero extends Hero
	{
		public function ConcreteHero(name:String, params:Object=null)
		{
			super(name, params);
			_ce.input.keyboard.addKeyAction("jump", citrus.input.controllers.Keyboard.ENTER);
			
		}
			
	}
}