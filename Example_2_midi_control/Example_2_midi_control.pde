/*
  This is part of a set of examples of using Processing for live presentation of
  multiple sketches with controllers (e.g VJ-ing)
  
  You're free to use this code for any purpose.
  
  Author : Ciaron Linstead
  https://github.com/ciaron
  
  Example 2: Building on example 1, this set of sketches can be controlled
             via an Akai LPD-8 MIDI controller.
             (Other MIDI controllers are certainly possible, but you may need
             to modify the Controller class)
             
             Requirements: 
             The MidiBus library by Severin Smith

*/


// We define an interface, which will be implemented for each 
// sketch we want to run.

public interface Sketch {
  public String status();
  public void run();
}

int nsketches = 2;
Sketch active;      // declare a main, active sketch.
Sketch[] sketches;  // an array of available sketches
    
// set up a MIDI controller.
Controller ctrl; 
    
void setup() {
  size(600,600,P2D);
   
  // or, use fullscreen on a second display:
  //fullScreen(P2D, 2);
  
  // define an array of two sketches, one for each implementation
  sketches    = new Sketch[2];
  sketches[0] = new Sketch1(6); // constructor for Sketch1 takes an int.
  sketches[1] = new Sketch2();  
  
  // callback
  ctrl = new Controller(this);

  // initialise the active sketch to one of our implementations
  active = sketches[0];
}

void draw() {

  // check if the controller has got a new Program Change
  // If so, we need to do something (switch sketches).
  // Better: implement this as a callback function & automate.
  if (ctrl.UPDATE) {
    active = sketches[ctrl.msg];
  }
  
  // run the current sketch (update + draw)
  active.run();

}

void midiMessage(MidiMessage message) {
  // there's almost certainly a better way than this.
  ctrl.midiMessage(message);
}

void keyPressed() {
  // switch between sketches with key '1' or '2'
  if (key == '1') {
    active = sketches[0];
  }
  if (key == '2') {
    active = sketches[1];
  }
  println(active.status());
}

public void switcher() {
  active = sketches[ctrl.msg];
}