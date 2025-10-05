public class Chmusick extends Chugraph {

    Notes tool;

    16 => STATIC.DIVISION;

    public static float tempo(float t)
    {
        t => STATIC.TEMPO;
        return STATIC.TEMPO;
    }
    public static float tempo()
    {
        return STATIC.TEMPO;
    }
    private dur convert(float beat)
    // ftod - beat(float) convertion to dur
    {
        60.0/beat => float tempo;
        return tempo::second;
    }
    private dur Dur(float beat, int div)
    {
        (div / 4.0) => float factor;
        (convert(beat) / factor) => dur tempo;
        return tempo;
    }
    // public string file(string name, string letter)
    // {
    //     me.dir() + "Samples/" + name + "/" + letter + ".wav" => string fileName; //Mac/Linux conflict with path
    //     //"Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
    //     return fileName;
    // }
    // public string file(string name, int num)
    // {
    //     me.dir() + "Samples/" + name + "/" + num + ".wav" => string fileName; //Mac/Linux conflict with path
    //     //"Samples/" + name + "/" + num + ".wav" => fileName; //Mac/Linux conflict with path
    //     return fileName;
    // }
    // public string file(string name)
    // {
    //     file(name, 1);
    //     return file(name, 1);
    // }
    public int[] rand(int capacity)
    // randomly fills an array with ones
    {
        int random[capacity];

        for(0 => int i; i < random.cap(); i ++)
        {
            Math.random2(0,1) => random[i];
        }
        return random;
    }
    public int toNote(int note)
    {
        if(maybe)
            return note;
        return 0;
    }
    public int[] trigToNote(int pattern[] ,int note)
    {
        int toReturn[pattern.cap()];

        for(0 => int i; i < toReturn.cap(); i ++)
        {
            if(pattern[i] == 1){
              note => toReturn[i];
            }
        }
        return toReturn;
    }
    public int[] subArray(int pattern[], int toCut[])
    // cuts an array pattern
    // Thanx to Santiago Beta
    {
        toCut.size() => int newsize;
        int sub[newsize];

        for(0 => int i; i < newsize; i++)
        {
            if(toCut[i] < pattern.size() && toCut[i] >= 0) {
                pattern[toCut[i]] => sub[i];
            }
            else {
                0 => sub[i];
            }
        }
        return sub;
    }
    public int[] trunc(int pattern[], float howmany)
    // truncates an array pattern by howmany
    {
        (pattern.size() * howmany)$int => int newsize;
        int truncated[newsize];

        for(0 => int i; i < newsize; i++)
        {
            pattern[i] => truncated[i];
        }
        return truncated;
    }
    public int[] trunc(int pattern[], int from, int to)
    // cuts an array from - to // idea: Santiago Beta
    {
        if(from >= 0 && to <= pattern.cap() && from < to)
        {
            int truncated[0];

            for(from => int i; i < to; i++)
            {
                truncated << pattern[i];
            }
            return truncated;
        }
        else
        {
            <<< "something is wrong, check trunc() parameters" >>>;
            return pattern;
        }
    }
    public int[] reverse(int pattern[])
    // reverse an array
    {
        int reversed[0];

        for((pattern.cap()-1) => int i; i >= 0 ; i - 1 => i)
        {
            reversed << pattern[i];
        }
        return reversed;
    }
    public int[] densify(int pattern[])
    // ramdomly add ones to an int array
    {
        int notes[0];

        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0)
            {
                notes << pattern[i];
            }
        }
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] == 0 && maybe)
            {
                notes[Math.random2(0, (notes.cap() - 1))] => pattern[i];
            }
        }
        return pattern;
    }

    public int[] reverse(SndBuf buffer){
      buffer => outlet;
      buffer.samples() => int total;
      while(true){
        total => buffer.pos;
        total--;
        samp => now;
      }
      return int toReturn[0];;
    }

    public int[] density(int pattern[],int times)
    {
        int toReturn[0];

        for(0 => int i; i < times; i++)
        {
            for(0 => int j; j < pattern.size(); j++)
            {
                toReturn << pattern[j];
            }
        }
        return toReturn;
    }

    public int[] degrade(int pattern[])
    // randomly removes non zero events of an int array
    {
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0 && maybe)
            {
                0 => pattern[i];
            }
        }
        return pattern;
    }

    public int[] every(int parameter)
    // fills an array of parameter size with ones
    {
        int everyArray[parameter];

        if(parameter == 0)
        {
            everyArray << 0;
            return everyArray;
        }
        else
        {
            1 => everyArray[0];

            for(1 => int i; i < everyArray.cap(); i++)
            {
                0 => everyArray[i];
            }
        }
        return everyArray;
    }

    // ==========================================================================
    // pking6 modification
    // ==========================================================================

    public int[] dec2Pos(float val)
    // Takes a decimal value and returns and array of positions
    //  - assumes the position array length is 16 
    {
        int everyArray[16]; 
        if (val > 0){
           for (0 => int i; i < 16; i++) {
                ((val % 2) >= 1) => everyArray[i];
                val / 2 => val;
           }
        }   
        return everyArray;
    }

    public int[] fill(int list[], int patLength)
    // Takes the list of positions of pattern and fills the positions with 1's to generate a pattern
    //  - the order in pattern is not important
    //  - patLength is the length of the resulting pattern
    {
        if (patLength == 0) {
           <<< "Pattern length should be greater than 0" >>>;
           STATIC.DIVISION => patLength;
        }    

        int everyArray[patLength];
        
        for( int i : list)
        {
            1 => everyArray[i];
        }
        
        return everyArray;
    }

    public int[] mask(int midiNote, int list[], int patLength)
    // Takes a list of positions of pattern and fills the midiNote when the position is not 
    // a value in the position list
    //  - patLength is the length of the resulting pattern
    {
        int everyArray[patLength];

        // If the first element greater than 0 then apply the mask
        // otherwise leave fully populated
        if (list[0] >= 0) {
            fill(list, patLength) @=> int pattern[];
            for (0 => int i; i < patLength; i++)
            {
               // Assume only have to deal with 0's in the position 
               // as by default everyArray starts as an array of zeros
               if (pattern[i] == 0)
               {
                  midiNote => everyArray[i];
               }
           }
        }
        else
        {
            ones(patLength,midiNote) @=> everyArray;
        }
       
        return everyArray;
    }

    public int[] join(int pattern1[], int pattern2[])
    // Takes two arrays of patterns and joins them together in order
    // Note: the pattern doesn't have to be of equal length
    {
        int everyArray[pattern1.cap()+pattern2.cap()];
        
        for(0 => int i; i < pattern1.cap(); i++)
        {
            pattern1[i] => everyArray[i];
        }
        for(0 => int i; i < pattern2.cap(); i++)
        {
            pattern2[i] => everyArray[i+pattern1.cap()];
        }
        return everyArray;
    }
    
   public int[] join(int pattern1[], int pattern2[], int pattern3[])
    // Takes three arrays of patterns and joins them together in order
    // Note: the pattern doesn't have to be of equal length
    {
        int everyArray[pattern1.cap()+pattern2.cap()+pattern3.cap()];
        
        for(0 => int i; i < pattern1.cap(); i++)
        {
            pattern1[i] => everyArray[i];
        }
        pattern1.cap() => int offset;
        for(0 => int i; i < pattern2.cap(); i++)
        {
            pattern2[i] => everyArray[i+offset];
        }
        pattern2.cap() +=> offset;
        for(0 => int i; i < pattern3.cap(); i++)
        {
            pattern3[i] => everyArray[i+offset];
        }
        return everyArray;
    }

   public int[] join(int pattern1[], int pattern2[], int pattern3[], int pattern4[])
    // Takes four arrays of patterns and joins them together in order
    // Note: the pattern doesn't have to be of equal length
    {
        int everyArray[pattern1.cap()+pattern2.cap()+pattern3.cap()+pattern4.cap()];
        
        for(0 => int i; i < pattern1.cap(); i++)
        {
            pattern1[i] => everyArray[i];
        }
        pattern1.cap() => int offset;
        for(0 => int i; i < pattern2.cap(); i++)
        {
            pattern2[i] => everyArray[i+offset];
        }
        pattern2.cap() +=> offset;
        for(0 => int i; i < pattern3.cap(); i++)
        {
            pattern3[i] => everyArray[i+offset];
        }
        pattern3.cap() +=> offset;
        for(0 => int i; i < pattern4.cap(); i++)
        {
            pattern4[i] => everyArray[i+offset];
        }
        return everyArray;
    }

    public int[] join(int list1[], int list2[], int patLength)
    // Takes two lists of positions and joins them together to generate a pattern
    //  - patLength is the length of the resulting pattern for an individual lists
    // Note: Assumes both lists generate patterns of the same length 
    {
        // Convert the position lists into patterns 
        fill(list1, patLength) @=> int pattern1[];
        fill(list2, patLength) @=> int pattern2[];

        // Join the two patterns together
        join(pattern1,pattern2) @=> int everyArray[];
        
        return everyArray;
    }
  
    public int[] join(int list1[], int list2[], int patLength1, int patLength2)
    // Takes two lists of positions and joins them together to generate a pattern
    // Note: Lists can generate patterns of different lengths
    // Resulting pattern length is patLength1 + patLength2 
    {
        // Convert the position lists into patterns 
        fill(list1, patLength1) @=> int pattern1[];
        fill(list2, patLength2) @=> int pattern2[];

        // Join the two patterns together
        join(pattern1,pattern2) @=> int everyArray[];
        
        return everyArray;
    }
    
    public int[] copy(int pattern[], int num)
    // Takes a pattern and then copies it num times
    {
        pattern.cap() => int patLength;
        
        int everyArray[patLength*num];

        for(0 => int i; i < num; i++)
        {
           for(0 => int j; j < patLength; j++)
           {
               pattern[j] => everyArray[j+i*patLength];
           }
        }
        return everyArray;
    } 
    
    public int[] zeros(int patLength)
    // Creates an empty pattern array of length patLength
    // Note: if patLength is zero then set it to the default bar length
    {
        if (patLength == 0) {
           <<< "Pattern length should be greater than 0" >>>;
           STATIC.DIVISION => patLength;
        }    
        int everyArray[patLength];
        return everyArray;
    }
    
    public int[] ones(int patLength)
    // Creates a pattern array full of ones of length patLength
    // Note: if patLength is zero then set it to the default bar length
    {
        if (patLength == 0) {
           <<< "Pattern length should be greater than 0" >>>;
           STATIC.DIVISION => patLength;
        }    
        
        int everyArray[patLength];
           
        for(0 => int i; i < patLength; i++)
        {
           1 => everyArray[i];
        }
        return everyArray;
           
    }

    public int[] ones(int patLength, int midiNote)
    // Creates a pattern array full of MIDI note frequency of length patLength
    // Note: if patLength is zero then set it to the default bar length
    {
        if (patLength == 0) {
           <<< "Pattern length should be greater than 0" >>>;
           STATIC.DIVISION => patLength;
        }    
        
        int everyArray[patLength];
           
        for(0 => int i; i < patLength; i++)
        {
           midiNote => everyArray[i];
        }
        return everyArray;
           
    }

    public void play(SndBuf buffer, int sample[])
    {
      buffer => Envelope envelope => outlet;

      while(true)
      {
        for(0 => int i; i < sample.cap(); i++)
        {
          if (sample[i] == 1)
          {
            envelope.keyOn();
             0 => buffer.pos;
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
          else {
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
        }
      }  
    }
    
    public void play(SndBuf buffer, int sample[], float gain)
    {
      buffer => Envelope envelope => outlet;

      while(true)
      {
        for(0 => int i; i < sample.cap(); i++)
        {
          if (sample[i] == 1)
          {
            envelope.keyOn();
             0 => buffer.pos;
             gain => buffer.gain;
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
          else {
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
        }
      } 
    }
    
    public void play(SndBuf buffer, int sample[], float gain, float rate)
    {
      buffer => Envelope envelope => outlet;

      while(true)
      {
        for(0 => int i; i < sample.cap(); i++)
        {
          if (sample[i] == 1)
          {
            envelope.keyOn();
             0 => buffer.pos;
             gain => buffer.gain;
             rate => buffer.rate;
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
          else {
             Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
          }
        }
      }  
    }
    
    
    public void play(Osc instr, int pattern[], float gain)
    {
        instr => outlet;
         while(true){
            for (0 => int i; i < pattern.cap(); i++)
            {
               if(pattern[i] != 0){
                   instr.gain(gain);
                   Std.mtof(pattern[i]) => instr.freq;
                   Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
               }
               else {
                   instr.gain(0);
                   Dur(STATIC.TEMPO,STATIC.DIVISION) => now;
               }
            }
        }
    }

  // ==========================================================================

    public int[] granularize(int array[], int howmany)
    {
        int granularized[0];

        for(0 => int count; count < array.cap(); count++)
        {
            for(0 => int i; i < howmany; i++)
            {
                granularized << array[count];
            }
        }
        return granularized;
    }

}
