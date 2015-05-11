package
{
	import com.genome2d.Genome2D;
	import examples.basic.BasicExample2Sprite;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			addChild(new BasicExample2Sprite() as Sprite);
		}
		
	}
	
}