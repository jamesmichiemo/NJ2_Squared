package com.NJSquared.gameCore	
{
	import citrus.core.IState;
	import citrus.core.State;
	import citrus.core.starling.StarlingState;
	
	import com.NJSquared.gameCore.GameAssets;
	import com.NJSquared.gameCore.Key;
	import com.NJSquared.state.GameOver;
	import com.NJSquared.state.StarGameState;
	
	import flash.events.KeyboardEvent;
	
	import starling.events.Event;
	
	public class Game extends State
	{
		public static const MENU_STATE:int = 0;
		public static const PLAY_STATE:int = 1;
		public static const GAME_OVER_STATE:int = 2;

		private var current_state:IState;
		public function Game()
		{
			// initialize the assets
			GameAssets.init();
			
			// listen for game to be added
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, update);
		}            
		
		private function init(event:Event):void
		{
			changeState(MENU_STATE); //start game on Menu
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
					current_state = new Game(this);
					break;
				
				case PLAY_STATE:
					current_state = new StarGameState(this);
					break;
				
				case GAME_OVER_STATE:
					current_state = new GameOver(this);
					break;
			}
			
			addChild(Sprite(current_state)); // typecast current state and add it to the display
		}

			
	
		
	}
}