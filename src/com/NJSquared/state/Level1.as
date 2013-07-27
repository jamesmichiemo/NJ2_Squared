package com.NJSquared.state
{
	
	
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import com.citrusengine.core.StarlingState;
	import com.citrusengine.objects.platformer.box2d.Hero;
	import com.citrusengine.objects.platformer.box2d.Platform;
	import com.citrusengine.objects.platformer.box2d.Sensor;
	import com.citrusengine.physics.box2d.Box2D;
	import com.citrusengine.utils.ObjectMaker2D;
	
	import flash.display.MovieClip;
	
	
	
	public class Level1 extends StarlingState
	{
		protected var level:MovieClip;
		
		public function Level1(_level:MovieClip)
		{
			super();
			level = _level;
			var objectsUsed:Array = [Hero, Platform, Sensor];
		}
		
		override public function initialize():void{
			super.initialize()
			
			var physics:Box2D = new Box2D("physics");
			physics.visible = true;
			add(physics);
			
			ObjectMaker2D.FromMovieClip(level);
			
			var hero:Hero = getObjectByName("hero") as Hero;
			hero.acceleration = 0.2;
			
			var sensorGate:Sensor = getObjectByName("sensorGate") as Sensor;
			sensorGate.onBeginContact.add(sensorGateOnBeginContact);
		}
		
		private function sensorGateOnBeginContact(contact:b2PolygonContact):void
		{
			trace("Sensor touched");
		}
	}
}