package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	public class NJ_Squared extends Sprite
	{
		private var stats:Stats;
		private var myStartling:Starling;
		public function NJ_Squared()
		{
			stats = new Stats();
			this.addChild(stats);
			
			myStartling = new Starling(Game, stage);
			myStartling.antiAliasing = 1;
			myStartling.start();
		}
	}
}