package
{
	import citrus.sounds.CitrusSoundGroup;
	
	import com.NJSquared.state.ArrayGameState;
	import com.NJSquared.state.BridgeGameState;
	import com.citrusengine.core.StarlingCitrusEngine;
	
	import flash.display.Sprite;
	
	[SWF(frameRate="60", width="1240", height="720", backgroundColor="0xe8f2fe")]
	public class Main extends StarlingCitrusEngine
	{
		
		public function Main()
		{
			setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			state = new BridgeGameState();
			
			sound.addSound("Hurt", "../sounds/hurt.mp3");
			sound.addSound("Kill", "../sounds/kill.mp3");
		}
	}
}