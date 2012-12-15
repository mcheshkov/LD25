package  
{
	/**
	 * ...
	 * @author myahcin
	 */
	public class myaHH
	{
		private var hpf:HPFilter = new HPFilter;
		public function myaHH() 
		{
			energy	= 0.0;
			decay	= 0.999;
			highy	= 0.3;
			envio	= 0.01;		
		}
		
		private var energy:Number;
		private var decay:Number;
		private var highy:Number;
		private var envio:Number;

		
		public function Play():Number {
			var value:Number = energy*(Math.random() - 0.5);
			energy *= decay;
			hpf.cutoff = highy + envio * energy;
			return hpf.Play(value);
		}
		
		public function Boom(_amp:Number = 1.0):void {
			energy += _amp;
		}
		
		public function randomize():void
		{
			highy = Generator.random(0.2, 0.4);
			decay = Generator.random(0.997, 0.9995);
			envio = Generator.random(0.0, 0.2);			
			energy = 0;
		}
	}

}