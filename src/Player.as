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
		
		private var mBD:myaBD = new myaBD;
		private var mHH:myaHH = new myaHH;
		private var mSD:myaSD = new myaSD;
		
		private var seq:Sequence = new Sequence;

		
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
		
		var globalLP:LPFilter = new LPFilter;
		
		
		
		private function oneSample():void
		{
			
			
			sequencer();
			
			L = 0.1 * Math.sin(omega * time * 0.5) + 0.8 * Math.sin(0.005 * time)+ 0.8 * Math.sin(0.01 * time);
			
			
			L += Math.abs((0.7+Math.sin(omega * (time+1000) * 0.00001)))*1.1
				*((Math.sin(omega * time * 0.00001) > 0.2)?0.07:0.15) * (mBD.Play() +  0.7 * mHH.Play() + 0.5 * mSD.Play());
			
			
			if (time % divisor == 0) {
				L = 0.7;
			//loose -= 0.01*Math.abs(loose);
			}
			
			
			
			
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
			
			seq = Generator.tutstuts();
			
			
			var mySound:Sound = new Sound();
			mySound.addEventListener(SampleDataEvent.SAMPLE_DATA, synth);
			mySound.play();	
			
		}
		
		
		private var playPosition:uint = 0;
		private var patternNum:int = 0;
		private var seqLine:int = 0;
		private var divid:int = 4;
		
		private function sequencer():void
		{
			if (playPosition == 0) {
				seqLine = 0;
				patternNum++;
				patternNum %= divid;
				//if (patternNum == 0) bassSeqLine = 0;
			}
			if (patternNum == 2) {
				return;
			}
			
			if (seqLine < seq.seqArray.length)
			
			if (seq.seqArray[seqLine].time <= playPosition)
			{
				switch (seq.seqArray[seqLine].type)
				{
				case InstrumentType.BD_:
					mBD.Boom(seq.seqArray[seqLine].amp);
					break;
				case InstrumentType.SD_:
					mSD.Boom(seq.seqArray[seqLine].amp);
					break;
				case InstrumentType.HH_:
					mHH.Boom(seq.seqArray[seqLine].amp);
					break;
				}
				seqLine++;
			}
			
/*
			if (bassSeqLine < bassSeq.seqArray.length)
			if (bassSeq.seqArray[bassSeqLine].time <= playPosition + patternNum*seq.patternLen)
			{
				bass.Boom(bassSeq.seqArray[bassSeqLine].amp, bassSeq.seqArray[bassSeqLine].tone);
				bassSeqLine++;
			}
			*/
			playPosition++;
			playPosition %= seq.patternLen;
		}
		
		public function drug():void {
			divisor = Math.floor(random(200, 1000));
			rev.randomize();
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
			seq = Generator.tutstuts();
			
			playPosition = 0;
					
			seqLine = 0;
			patternNum = 0;
			
			mBD.randomize();
			mSD.randomize();
			mHH.randomize();
			//bd.Boom();
			//	trace("loose:" + loose);
			//	loose = random(0.999995, 0.99999);
			//}
			
			
			//trace(divisor);
		}
		
	}

}