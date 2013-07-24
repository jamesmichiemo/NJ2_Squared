package
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.sounds.CitrusSoundGroup;
	
	import flash.display.Sprite;
	import flash.ui.GameInput;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	import com.NJSquared.state.GameState;
	
	[SWF(frameRate="60", width="1240", height="720", backgroundColor="0x333333")]
	public class Main extends StarlingCitrusEngine
	{
		public static const MENU_STATE:String = "menu_state";
		public static const LEVEL_SELECT_STATE:String = "level_select_state";
		public static const GAME_OVER_STATE:String = "game_over_state";
		
		public function Main()
		{
			setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			state = new GameState();
			
			sound.addSound("Hurt", {sound:"sounds/hurt.mp3",group:CitrusSoundGroup.SFX}); // completely different parameter setting from first tutorial; updated sounds parameters shown here: https://github.com/alamboley/Citrus-Engine-Examples/blob/master/src/soundpatchdemo/Main.as
			sound.addSound("Kill", {sound:"sounds/kill.mp3",group:CitrusSoundGroup.SFX});
		}
	}
}