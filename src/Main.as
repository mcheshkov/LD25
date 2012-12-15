package 
{
import avmplus.typeXml;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

/**
	 * ...
	 * @author 
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);


            var tf:TextField = new TextField();
            tf.text = "Hi!";
            tf.x = 100;
            tf.y = 100;
            this.addChild(tf);
			// entry point
		}

	}

}