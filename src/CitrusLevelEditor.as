package
{
	import com.NJSquared.state.Level1;
	import com.citrusengine.core.StarlingCitrusEngine;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import starling.events.Event;
	
	public class CitrusLevelEditor extends StarlingCitrusEngine
	{
		public function CitrusLevelEditor()
		{
			setUpStarling(true);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _levelLoaded);
			loader.load(new URLRequest("../levels/Level1.swf"));
		}
		private function _levelLoaded(evt:Event):void {
			state = new Level1(evt.target.loader.content);
			
			evt.target.removeEventListener(Event.COMPLETE, _levelLoaded);
			evt.target.loader.unloadAndStop();
		}
	}