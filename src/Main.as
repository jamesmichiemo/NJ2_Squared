package
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.sounds.CitrusSoundGroup;
	
	import com.NJSquared.state.GameOver;
	import com.NJSquared.state.GameState;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.GameInput;
	import flash.utils.getDefinitionByName;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1240", height="720", backgroundColor="0x333333")]
	public class Main extends CitrusEngine
	{
		
		public function Main()
		{
			//setUpStarling(true); //http://citrusengine.com/getting-started-citrus-starling-box2d/
			
			state = new GameState();
			
			sound.addSound("Hurt", {sound:"sounds/hurt.mp3",group:CitrusSoundGroup.SFX}); // completely different parameter setting from first tutorial; updated sounds parameters shown here: https://github.com/alamboley/Citrus-Engine-Examples/blob/master/src/soundpatchdemo/Main.as
			sound.addSound("Kill", {sound:"sounds/kill.mp3",group:CitrusSoundGroup.SFX});
		}
		
		
		
		public function changeState(state:State):void
		{
			this.state = state
		}
		
		
	}
}