package
{
	import com.genome2d.Genome2D;
	import examples.basic.*;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			//addChild(new BasicExample1Initialization() as Sprite);
			//addChild(new BasicExample2Assets() as Sprite);
			//addChild(new BasicExample3Sprite() as Sprite);
			//addChild(new BasicExample4Mouse() as Sprite);
			//addChild(new BasicExample5TextureText() as Sprite);
			addChild(new BasicExample6SimpleParticles() as Sprite);
		}
		
	}
	
}