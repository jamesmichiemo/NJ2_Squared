package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1240", height="720", backgroundColor="0x333333")]
	public class NJ_Squared extends Sprite
	{
		private var _stats:Stats;
		private var myStartling:Starling;
		public function NJ_Squared()
		{
			initStarling();
		}
		
		private function initStarling():void
		{
			_stats = new Stats();
			this.addChild(_stats);
			
			myStartling = new Starling(Game, stage);
			myStartling.antiAliasing = 1;
			myStartling.start();
		}
	}
}