package com.NJSquared.state
{	
	import com.NJSquared.gameCore.Assets;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class CallToState extends Sprite
	{
		// Three game states
		public static const MENU_STATE:int = 0;
		public static const PLAY_STATE:int = 1;
		public static const GAME_OVER_STATE:int = 2;
		
		// Current state of game
		private var current_state:IStates;
		
		public function CallToState()
		{
			// initialize the assets
			Assets.init();
			
			// listen for game to be added
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function init(event:Event):void
		{
			changeState(PLAY_STATE); //start game on Menu
		}
		
		public function changeState(state:int):void
		{
			// check current state and empty it before changing state
			if(current_state != null)
			{
				current_state.destroy();
				current_state = null;
			}
			
			switch(state) // different switch states
			{
				case MENU_STATE:
					//current_state = new Menu(this);
					break;
				
				case PLAY_STATE:
					//current_state = new BridgeGameState(this); //change this according to the play game class
					break;
				
				case GAME_OVER_STATE:
					//current_state = new GameOver(this);
					break;
			}
			
			addChild(Sprite(current_state)); // typecast current state and add it to the display
		}
		
		public function update(timeDelta:Number):void
		{
			// whatever state is currently active, update yourself! before you wreck yourself.
			current_state.update(timeDelta);
		}
	}
}