package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1240", height="720", backgroundColor="0x333333")]
	public class Main extends StarlingCitrusEngine
	{
		
		public function Main()
		{
			setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			state = new GameState();
		}
		
		
	}
}