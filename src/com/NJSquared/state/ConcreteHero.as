package com.NJSquared.state
{
	import citrus.input.controllers.Keyboard;
	import citrus.objects.platformer.box2d.Hero;
	
	public class ConcreteHero extends Hero
	{
		public function ConcreteHero(name:String, params:Object=null)
		{
			super(name, params);
			_ce.input.keyboard.addKeyAction("jump", citrus.input.controllers.Keyboard.ENTER);
		}
		
		
	}
}