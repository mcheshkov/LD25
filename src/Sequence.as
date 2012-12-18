package  
{
	public class Sequence
	{
		public var seqArray:Vector.<SequenceEvent> = new Vector.<SequenceEvent>;
		public var patternLen:uint = 40000;
		
		public function Sequence() 
		{}
		
		public function clear():void
		{
			seqArray = new Vector.<SequenceEvent>;
		}
		
		public function sort():void
		{
			seqArray.sort(compare);
		}		
		
		private function compare( a:SequenceEvent,  b:SequenceEvent):Number {
			return Number(a.time)-Number(b.time);
		}
	}

}