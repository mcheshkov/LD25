package  
{
	/**
	 * ...
	 * @author myahcin
	 */
	public class myaSD
	{
		
		public function myaSD() 
		{
			energy = 0.0;
			value = 0.0;
			decay = 0.999;
			primi = 0.995;
			gummy = 0.001;
			rummy = 0.0;
			rezzy = 0.0;
			harmo = 10.0;
			resss = 0.7;			
		}
		
		private var energy:Number;
		private var value:Number;
		private var decay:Number;
		private var primi:Number;
		private var gummy:Number;
		private var rummy:Number;
		private var rezzy:Number;
		private var harmo:Number;
		private var resss:Number;
		private var ozvuk:Number;
		
		private var hpf1:HPFilter = new HPFilter;
		private var hpf2:HPFilter = new HPFilter;

		public function Play():Number {
			energy *= decay; // 0.9996 .. 0.9990
			value += energy*(Math.random() - 0.5);
			value *= primi; // 0.995 .. 0.99
			if (value >  1.0) value = 1.0;
			if (value < -1.0) value = -1.0;
			
			hpf1.cutoff = gummy + rummy * energy;
			hpf1.reso = rezzy;

			hpf2.cutoff = harmo*gummy;
			hpf2.reso = resss;
			
			value = hpf1.Play(value);
			ozvuk = 0.5*value + 0.5*hpf2.Play(value);
			return ozvuk;
		}
		
		public function Boom(_amp:Number = 1.0):void {
			energy += _amp;
		}
		
		public function randomize():void
		{

			energy = 0;
			decay = Generator.random(0.9980, 0.9996);
			primi = Generator.random(0.985, 0.995);
			gummy = Generator.random(0.0001, 0.0019);
			rummy = Generator.random(-0.5*gummy, 0.0001);
			rezzy = Generator.random(0.0, 0.35);
			harmo = Generator.random(7.0, 20.0);
			resss = Generator.random(0.0, 0.8)*Generator.random(0.0, 1.0);					
		}	
	}
}