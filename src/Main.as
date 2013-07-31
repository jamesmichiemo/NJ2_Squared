package
{	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.sounds.CitrusSoundGroup;
	
	import com.NJSquared.state.ArrayGameState;
	import com.NJSquared.state.BridgeGameState;
	import com.NJSquared.state.GameOver;
	import com.NJSquared.state.Menu;
	
	[SWF(frameRate="60", width="1280", height="720", backgroundColor="0xe8f2fe")]
	public class Main extends StarlingCitrusEngine
	{	
		public function Main()
		{
			setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			// create sound assets
			sound.addSound("Title", {sound:"../sounds/title.mp3", group:CitrusSoundGroup.BGM});
			sound.addSound("Collector", {sound:"../sounds/collector.mp3", group:CitrusSoundGroup.BGM});
			sound.addSound("Puzzle", {sound:"../sounds/puzzle.mp3", group:CitrusSoundGroup.BGM});
			sound.addSound("Gameover", {sound:"../sounds/gameover.mp3", group:CitrusSoundGroup.BGM});
			sound.addSound("Victory", {sound:"../sounds/victory.mp3", group:CitrusSoundGroup.BGM});
			sound.addSound("Start", {sound:"../sounds/start.mp3", group:CitrusSoundGroup.SFX});
			sound.addSound("Hurt", {sound:"../sounds/hurt.mp3", group:CitrusSoundGroup.SFX});
			sound.addSound("Kill", {sound:"../sounds/kill.mp3", group:CitrusSoundGroup.SFX});
			sound.addSound("Sploosh", {sound:"../sounds/sploosh.mp3", group:CitrusSoundGroup.SFX});
			sound.addSound("Jump", {sound:"../sounds/jump.mp3", group:CitrusSoundGroup.SFX});
			sound.addSound("Pick", {sound:"../sounds/pick.mp3", group:CitrusSoundGroup.SFX});

			state = new Menu();

		}	
	}
}