package  
{
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
		
		
		
		public static function tutstuts():Sequence
		{
			var seq:Sequence = new Sequence;
			seq.patternLen = uint(4.0*60.0*44100.0/random(110.0, 145.0));
			var onebeat :uint = seq.patternLen / 16;
			var count:int = 0;
			seq.clear();
			
			for (var i:int = 0; i < 4; i++ )
			{
				var e:SequenceEvent = new SequenceEvent;
				e.amp = 1.0;
				e.type = InstrumentType.BD_;
				e.time = onebeat * (i*4);
				seq.seqArray.push(e);	
				
				e = new SequenceEvent;
				e.amp = 2.0;
				e.type = InstrumentType.HH_;
				e.time = onebeat * (i*4 + 2);			
				seq.seqArray.push(e);	
			}
			
			if (randi(0,2)%2)
			{
				e = new SequenceEvent;
				e.amp = random(0.0, 0.02);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * random(13.8, 15.1));			
				seq.seqArray.push(e);				
				count++;
			}
			
			//main snares:
			if (randi(0,2)%2)
			{
				e = new SequenceEvent;
				e.amp = random(0.6, 1.0);
				e.type = InstrumentType.SD_;
				e.time = uint(onebeat * 4);			
				seq.seqArray.push(e);		
				
				e = new SequenceEvent;
				e.amp = random(0.6, 1.0);
				e.type = InstrumentType.SD_;
				e.time = uint(onebeat * 12);			
				seq.seqArray.push(e);					
			}		
			
			if (randi(0,2)%2)
			{	
				var pos:int = randi(1, 4);
				
				e = new SequenceEvent;
				e.amp = random(0.001, 0.01);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (0+pos));			
				seq.seqArray.push(e);				
				
				e = new SequenceEvent;
				e.amp = random(0.001, 0.01);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (4+pos));			
				seq.seqArray.push(e);	
				e = new SequenceEvent;
				e.amp = random(0.001, 0.01);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (8+pos));			
				seq.seqArray.push(e);	
				
				pos = randi(1, 4);
				e = new SequenceEvent;
				e.amp = random(0.001, 0.01);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (12+pos));			
				seq.seqArray.push(e);					
			}			
			if (randi(0,2)%2)
			{	
				pos = Generator.randi(1, 4);
				e = new SequenceEvent;
				e.amp = random(0.001, 0.05);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (4+pos+random(-0.1, 0.1)));			
				seq.seqArray.push(e);		
				e = new SequenceEvent;
				e.amp = random(0.001, 0.05);
				e.type = InstrumentType.BD_;
				e.time = uint(onebeat * (12+pos+random(-0.1, 0.1)));			
				seq.seqArray.push(e);					
				
			}			
			//hh polyrythmic addies
			var nuum:Number, tempo:Number;
			if (randi(0,2)%2)
			{	
				pos = 4.0*(randi(0,3));
				tempo = 1.0 + Number(randi(0,4));
				nuum = int(random(0.0, (16.0 - pos)/tempo));
				if (nuum != 0.0)
					for (i=0; i<nuum; i++)
					{
						e = new SequenceEvent;
						e.amp = random(0.1, 0.8);
						e.type = InstrumentType.HH_;
						e.time = uint(Number(onebeat) * (pos + i * tempo + random( -0.1, 0.1)));	
						seq.seqArray.push(e);							
					}	
			}			
			//hh odd addies:
			if (randi(0,2)%2) {
				for (i=0; i<4; i++)
				{
					e = new SequenceEvent;
					e.amp = random(0.1, 0.5);
					e.type = InstrumentType.HH_;
					e.time = uint(Number(onebeat)*(i*4));			
					seq.seqArray.push(e);						
				}	
			}

			//hh micro addies:
			if (randi(0,2)%2)
			{	
				for (i=0; i<16; i++)
				{
					e = new SequenceEvent;
					e.amp = random(0.3, 0.7);
					e.type = InstrumentType.HH_;
					e.time = uint(Number(onebeat)*Number(random(-0.3, 0.1) + i));			
					seq.seqArray.push(e);							
				}	
			}			
			if (randi(0,2)%2)
			{	
				pos = 4.0*(randi(0,3));
				tempo = 3.0 + Number(randi(0,2));				
				nuum = int(random(0.0, (16.0 - pos)/tempo));
				if (nuum != 0.0)
					for (i=0; i<nuum; i++)
					{
						e = new SequenceEvent;
						e.amp = random(0.1, 0.5);
						e.type = InstrumentType.SD_;
						e.time = uint(Number(onebeat)*(pos + i*tempo + random(-0.1, 0.1)));
						seq.seqArray.push(e);							
					}	
			}			
			seq.sort();
			return seq;			
		}	
	}
	

}