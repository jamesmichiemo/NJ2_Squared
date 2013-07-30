package com.NJSquared.state
{
	import com.citrusengine.objects.platformer.box2d.Enemy;
	
	public class Enemies extends Enemy
	{
		public function Enemies(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function createFixture():void
		{
			super.createFixture();
			
			_leftSensorFixture = body.CreateFixture(_sensorFixtureDef);
			
			_sensorFixtureDef.shape = _rightSensorShape;
			_rightSensorFixture = body.CreateFixture(_sensorFixtureDef);
		}
		
		override protected function defineFixture():void
		{
			super.defineFixture();
			

			_sensorFixtureDef.isSensor = true;

		}
	}
}