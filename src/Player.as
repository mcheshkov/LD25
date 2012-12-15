package  
{
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	public class Player 
	{
		
		private var L:Number;
		private var R:Number;
		private var time:Number;
		private var rev:Reverb = new Reverb;

		
		private var loose:Number;
		
		public static function random(a:Number, b:Number):Number
		{
			return a + (b-a)*Math.random();
		}
		
		
		
		private var omega:Number;
		private var bd:myaHH;
		
		private	function synth(event:SampleDataEvent):void {
			/*
			if (isFirst)
			{
				for ( var c:int = 0; c < 6000; c++ ) {
				//oneSample();
				L = 0;
				R = 0;
				event.data.writeFloat(L);
				event.data.writeFloat(R);
				}
			}			
			else
			*/
			var c:Number;
			for ( c = 0; c < 6000; c++ ) {
				oneSample();
				event.data.writeFloat(L);
				event.data.writeFloat(R);
			}
		}	
		
		
		private var divisor:Number;
		
		
		
		private function oneSample():void
		{
			
			L = 0.1* Math.sin(omega * time) + Math.sin(0.003 * time)+ 0.5* Math.sin(0.01 * time);
			
			if (time % divisor == 0) {
				L = 0.7;
			//loose -= 0.01*Math.abs(loose);
			}
			L += 3*bd.Play();
			
			
			
			var re:Object = rev.Play(L);
			R = re.R;
			L = re.L;			
			time++;

		}	
		
		public function Player() 
		{
			time = 0;
			
			divisor = 1000;
			omega = Math.PI/24;
			loose = 0.9999;
			bd = new myaHH;
			
			
			var mySound:Sound = new Sound();
			mySound.addEventListener(SampleDataEvent.SAMPLE_DATA, synth);
			mySound.play();	
			
		}
		
		public function drug():void {
			divisor = Math.floor(random(200, 1000));
			//if (loose < 0.1) {
			
			var nu:Number = random(1.01, 2);
			var du:Number = Math.floor(random(1.01, 6));
			//omega = random(0.03, 0.07);
			var rnd:Number = random(0, 1);
			if (rnd > 0.5) {
				omega /= nu;
			}
			else if (rnd > 0.2) {
				omega *= nu;
			}
			else omega = Math.PI/24;
			bd.Boom();
			//	trace("loose:" + loose);
			//	loose = random(0.999995, 0.99999);
			//}
			
			
			//trace(divisor);
		}
		
	}

}