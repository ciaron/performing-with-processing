import themidibus.*;
import javax.sound.midi.MidiMessage;

/* This class manages the Akai LPD-8 controller
   For other devices, you'll need to modify this.
*/

class Controller {
  
  MidiBus myBus;
  
  public int[] k  = new int[8];
  public int[] cc = new int[8];
  public int msg;
  String callback;
  
  public Controller(String cb) {
    callback = cb;
    myBus = new MidiBus(this, 0, 1);
    
    // TODO check that MIDI device has been found
    if (1==2) println("MIDI device not found");
  }
  
  void midiMessage(MidiMessage message) {
  
    int value;
    int status = message.getStatus();
    
    if (status == 176) { // controller change, i.e. parameter change
    
      msg = (int)(message.getMessage()[1] & 0xFF);
      value = (int)(message.getMessage()[2] & 0xFF);
      
      if (msg >= 11 & msg <= 18) {
        k[msg-11] = constrain(value, 0, 127);
      } else if (msg >= 1 & msg <= 8) {
        // a pad hit in CONTROLLER CHANGE
        cc[msg-1] = value;//(value > 0) ? 1 : 0;
      }
  
    } else if (status == 192) { // program change, i.e. sketch/mode change
    
      // this can be a momentary signal (PROGRAM CHANGE 192), or multiples 
      // (e.g. pad down, pad up, CONTROLLER CHANGE 176 (see above))
      // in the latter case, there is a pressure value in param 3 (0-127)
      msg = message.getMessage()[1] & 0xFF;
  
      // this is how we switch sketches:
      // if (msg == 0) msg = s1;
      thread(callback);
    }
  }
  
}