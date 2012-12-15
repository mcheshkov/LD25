package  
{
	public class Reverb
	{
		private var buffer:Vector.<Number> = new Vector.<Number>();
		private var bufpos:uint = 0;
		public function Reverb() 
		{
			for (var i:int = 0; i < 80000; i++ )
				buffer.push(0);			
		}
		
		private var LL:Number = 0;
		private var RR:Number = 0;
		private var lfn:Number = 0;
		private var lfn2:Number = 0;	
		
		private var len1:int = 4800;
		private var len2:int = 7600;
		private var len3:int = 6900;
		private var len4:int = 5700;

		private var Alpha:Number = 0.9;
		private var Beta:Number = 0.02;
		
		public function Play(value:Number):Object
		{
			bufpos ++;				
			bufpos %= 80000;			
			lfn += 0.00008 * ( Math.random());
			lfn2 += 0.00008 * ( Math.random());
			
			LL = Alpha*-0.45 * buffer[(80000 + bufpos  - int(4800*(2.0+Beta*Math.sin(lfn)))) % 80000];
			RR = Alpha*0.55 * buffer[(80000 + bufpos  - int(7600*(2.0-Beta*Math.sin(lfn)))) % 80000];
			LL += Alpha*0.45 * buffer[(80000 + bufpos  - int(6900*(2.0-Beta*Math.sin(lfn2)))) % 80000];
			RR -= Alpha*0.55 * buffer[(80000 + bufpos  - int(5700*(2.0+Beta*Math.sin(lfn2)))) % 80000];			
			buffer[bufpos] = 0.5 * (value + LL + RR);			
			var a:Object = new Object;
			a.L = LL;
			a.R = RR;
			return a;
		}
		
		public static function random(a:Number, b:Number):Number
		{
			return a + (b-a)*Math.random();
		}
		public static function randi(a:int, b:int):int
		{
			return a + int(random(0, b - a - 0.00001));
		}
		public function randomize():void {
			len1 = randi(4000, 12000);
			len2 = randi(4000, 12000);
			len3 = randi(4000, 12000);
			len4 = randi(4000, 12000);
			Alpha = Math.sqrt(random(0.0, 0.95));
			Beta = random(0.0, 0.3);
		}
	}

}