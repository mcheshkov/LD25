package  
{
	/**
	 * ...
	 * @author myahcin
	 */
	public class myaBD
	{
		public function myaBD() 
		{
			randomize();
			speed	= 0.0;
			value	= 0.0;
			fric	= 0.001;
			flex	= 0.0001;
			disty   = 4.0;
			noisy	= 0.2;
			decay	= 1.5;
			twelch	= 300;
			huelch	= 300;			
		}
		
		private var psi:Number;
		private var value:Number = 0;
		private var speed:Number;
		private var w:Number;
		private var twelch:Number;
		private var fric:Number;
		private var huelch:Number;
		private var noisy:Number;
		private var disty:Number;
		private var distort:Number;
		private var decay:Number;
		private var flex:Number;
		
		public function Play():Number {
			psi = twelch/(twelch + Math.abs(value));
			value += speed;
			speed *= psi*(1.0 - fric);
			w = Math.pow(Math.abs(value), decay);
			if (value > 0.0) speed -= psi*flex*w*(1.0+Math.sin(huelch*w));
			if (value < 0.0) speed += psi*flex*w*(1.0+Math.sin(huelch*w));
			if (value >  1.0) value = 1.0;
			if (value < -1.0) value = -1.0;
			
			distort = Math.sin(Math.sin(disty*value));
			//distort += noisy*distort*(Math.random() - 0.5);
			return distort;
		}
		
		public function Boom(_amp:Number = 1.0):void {
			speed = 0.25*_amp;			
		}
		
		public function randomize():void
		{
			disty = Generator.random(1.0, 8.0);
			noisy = Generator.random(0.0, 0.7);
			fric  = Generator.random(0.001, 0.005);
			flex = Generator.random(0.0001, 0.0015);
			decay = Generator.random(1.3, 3.0);
			twelch = Generator.random(1.0, 10.0)*Generator.random(1.0, 10.0)*Generator.random(3.0, 10.0);
			huelch = Generator.random(1.0, 10.0) * Generator.random(1.0, 10.0) * Generator.random(1.0, 10.0);		
		}
	}

}