package com.NJSquared.gameCore
{
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.citrusengine.objects.platformer.box2d.Coin;

	
	public class Tile extends Coin
	{
		private var _color:String;
		
		public function Tile(color:String, name:String, params:Object=null)
		{
			super(name, params);
			
			_color = color;
		}
		
		override public function handleBeginContact(contact:b2Contact):void
		{
			TileManager.increaseTileCount(_color);

			super.handleBeginContact(contact);	
		}
	}
}