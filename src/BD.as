package  
{
	/**
	 * ...
	 * @author myahcin
	 */
	public class BD
	{
		public var freqInit:Number = 120;
		public var speedInit:Number = 0.005;
		public var ampInit:Number = 1.0;
		public var ampInitSlow:Number = 1.0;
		
		private var phase:Number = 0;
		public var freq:Number = 220;
		private var amp:Number = 0.1;
		private var user_freq:Number = 220;
		private var user_amp:Number = 0.0;
		private var click_amp:Number = 0.0;	
		
		private var _attackTime:Number = 10.0;
		private var _releaseTime:Number = 50.0;
		
		private var _time:uint = 10000;
		
		public var _speed:Number = 500.0;
		
		public function BD() 
		{
		}
		
		public function Play():Number {
			ampInitSlow = ampInitSlow * 0.99 + 0.01 * ampInit;
			if (freq <= 0) freq = 0;// return 0;
			_time++;
			var lfo:Number = Math.sin(100.0*(2.0*Math.PI*_time)/44100.0);
			var click:Number = Math.sin((5*lfo+1000.0) * (2.0 * Math.PI * _time) / 44100.0);		
			
			if (_time < _attackTime * 44.1){
				user_amp = _time / (_attackTime * 44.1);
			}
			else{
				user_amp *=  Math.pow(0.5, 1.0 / (_releaseTime * 44.1));
			}
			
			if (_time < _attackTime * 44.1 / 13){
				click_amp = 13*_time / (_attackTime * 44.1);
			}
			else{
				click_amp *=  Math.pow(0.5, 13* 1.0 / (_releaseTime * 44.1));
			}
			
			amp = 0.9 * amp + 0.1 * user_amp;
			freq -= _speed;
			phase += (10.0*lfo+freq) / 44100.0;
			if (phase > 1.0) phase -= 1.0;
			
			var value:Number = amp * Math.sin(phase * 2.0 * Math.PI) + click_amp * 0.1 * click;
			/*if (_rampTime > 0)
			{	
				_rampTime--;
				_rampValue = 0.99 * _rampValue + 0.01 * value;
				return ampInitSlow*_rampValue;
			}
			else 
			{
				_rampValue = value;
				return ampInitSlow*value;
			}*/
			return ampInitSlow*value;
		}
		
		private var _rampTime:int = 4000;
		private var _rampValue:Number = 0;
		
		public function Boom(_amp:Number = 1.0):void {
			_rampTime = 4000;
			_time = 0;
			ampInit = _amp;
			freq = freqInit;// 200 * (Number(e.stageX / 300.0));
			_speed = speedInit;// 0.05 * Number(e.stageY / 300.0);
			
		}
		
		public function randomize():void
		{
			_attackTime = Generator.random(0, 0.1);
			_releaseTime = Generator.random(30, 300);
			speedInit = Generator.random(0.0001, 0.005);
			freqInit = Generator.random(30, 100);
		}
	}

}