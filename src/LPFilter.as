package  
{
	/**
	 * ...
	 * @author 1
	 */
	public class LPFilter
	{
		public var cutoff:Number = 0.1;
		public var reso:Number = 0.1;
		
		private var _ip:Number = 0.0;
		private var _ipp:Number = 0.0;
		private var _op:Number = 0.0;
		private var _opp:Number = 0.0;
		
		private var _a0:Number = 0.0;
		private var _a1:Number = 0.0;
		private var _a2:Number = 0.0;
		private var _b0:Number = 0.0;
		private var _b1:Number = 0.0;	
		private var r:Number;
		private var c:Number;
				
		public function LPFilter() 
		{}
		
		public function Play(_in:Number):Number {
			r = (1.0 - reso) * 1.4142135623;
			c = 1.0 / Math.tan(0.5* Math.PI * cutoff);

			_a0 = 1.0 / ( 1.0 + r * c + c * c);
			_a1 = 2.0* _a0;
			_a2 = _a0;
			_b0 = 2.0 * ( 1.0 - c*c) * _a0;
			_b1 = ( 1.0 - r * c + c * c) * _a0;		
		
			var out:Number = _a0 * _in +
							 _a1 * _ip +
							 _a2 * _ipp 
							 -_b0 * _op 
							 -_b1 * _opp;
			_ipp = _ip;
			_ip = _in;
			_opp = _op;
			_op = out;			
			return out;
		}
		
	}
	
	

}