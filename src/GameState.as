package
{
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	public class GameState extends StarlingState
	{
		private var _citrusEngine:CitrusEngine;
		
		public function GameState()
		{
			super();
			_citrusEngine = CitrusEngine.getInstance();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:stage.stageWidth}));
			add(new Platform("cloud", {x:170/2, y:600, width:170, oneWay:true}));
			// step:5
			var coin:Coin = new Coin("coin", {x:360, y:500/*, view:"levels/SoundPatchDemo/jewel.png"*/});
			add(coin);
			coin.onBeginContact.add(coinTouched);
			
			var hero:Hero = new Hero("hero", {x:100, y:350, width:60, height:235});
			add(hero);
			hero.onGiveDamage.add(heroAttack);
			hero.onTakeDamage.add(heroHurt);
			
			var enemy:Enemy = new Enemy("enemy", {x:stage.stageWidth - 50, y:350, width:46, height:68, leftBound:20, rightBound:stage.stageWidth - 20});
			add(enemy);
			
			
			// Step:5 For animations embed art and xml and create an AnimationSequence
			/*[Embed(source="/../embed/Hero.xml", mimeType="application/octet-stream")]
			
			private var _heroConfig:Class;
			
			[Embed(source="/../embed/Hero.png")]
			
			private var _heroPng:Class;
			
			var bitmap:Bitmap = new _heroPng();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new _heroConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			hero.view = new AnimationSequence(sTextureAtlas, ["walk", "duck", "idle", "jump", "hurt"], "idle");*/
		}
		
		private function heroHurt():void
		{
			_citrusEngine.sound.playSound("Hurt"); // completely different parameter settings from first tutorial; update here: https://github.com/alamboley/Citrus-Engine-Examples/blob/master/src/soundpatchdemo/Main.as
			trace("trigger hero hurt sound");
		}
		
		private function heroAttack():void
		{
			_citrusEngine.sound.playSound("Kill");
			trace("trigger hero attack sound");
		}
		
		private function coinTouched(contact:b2Contact):void
		{
			trace('coin touched by an object');
		}
	}
}