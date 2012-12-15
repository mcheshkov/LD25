package  
{
	/**
	 * ...
	 * @author myahcin
	 */
	public class Generator
	{
		public static function random(a:Number, b:Number):Number
		{
			return a + (b-a)*Math.random();
		}
		
		public static function randi(a:int, b:int):int
		{
			return a + int(random(0, b - a - 0.00001));
		}
		
		public function Generator() 
		{		
		}
		
		
	}

}