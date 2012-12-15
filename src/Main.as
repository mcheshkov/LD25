package 
{
import avmplus.typeXml;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.SampleDataEvent;
import flash.media.Sound;
import flash.events.MouseEvent;
import flash.text.TextField;
import Reverb;

/**
	 * ...
	 * @author 
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		
		
		private var pl:Player= new Player;

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
			
			
			
			
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);	
		}
		
		
		private function onMouseDown(event:Event) {
			pl.drug();
		}

	}

}