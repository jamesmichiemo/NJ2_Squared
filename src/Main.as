package
{	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import com.NJSquared.state.ArrayGameState;
	import com.NJSquared.state.BridgeGameState;
	import com.NJSquared.state.Menu;
	
	import flash.events.MouseEvent;
	
	[SWF(frameRate="60", width="1280", height="720", backgroundColor="0xe8f2fe")]
	public class Main extends StarlingCitrusEngine
	{	
		public function Main()
		{
			setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			// create sound assets
//			sound.addSound("Title", "../sounds/title.mp3");
//			sound.addSound("Collector", "../sounds/collector.mp3");
//			sound.addSound("Puzzle", "../sounds/puzzle.mp3");
//			sound.addSound("Gameover", "../sounds/gameover.mp3");
//			sound.addSound("Hurt", "../sounds/hurt.mp3");
//			sound.addSound("Kill", "../sounds/kill.mp3");

<<<<<<< HEAD
			state = new BridgeGameState();
			
=======
			state = new ArrayGameState();

>>>>>>> 12a51e95efc917e09af0022c2998d29e2853274b
		}
	}
}