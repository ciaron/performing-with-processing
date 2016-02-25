/*
  This is part of a set of examples of using Processing for live presentation of
  multiple sketches with controllers (e.g VJing)
  
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

// import what we need for the MidiBus
import themidibus.*;
import javax.sound.midi.MidiMessage;

// We define an interface, which will be implemented for each 
// sketch we want to run.
public interface Sketch {
  public String status();
  public void run();
}

int nsketches = 2;  // number of sketches
Sketch active;      // declare a main, active sketch.
Sketch[] sketches;  // an array of available sketches
    
Controller ctrl;
MidiBus midiBus;

void setup() {
  size(600,600,P2D);
   
  // or, use fullscreen on a second display:
  //fullScreen(P2D, 2);
  
  // define an array of two sketches, one for each implementation
  sketches    = new Sketch[nsketches];
  sketches[0] = new Sketch1(6); // constructor for Sketch1 takes an int.
  sketches[1] = new Sketch2();  
  
  ctrl = new Controller();
  
  // the Controller will handle the midi callbacks
  midiBus = new MidiBus(ctrl, 0, 1);
  
  // initialise the active sketch to the first of our implementations
  active = sketches[0];
}

void draw() {

  // Switch sketches.
  // (If the controller has got a new Program Change)
  // Better? pass the sketch array to the controller and let it handle the update
  
  if (ctrl.UPDATE) {
    active = sketches[ctrl.msg];
    ctrl.UPDATE=false;
  }
  
  // run the current sketch (update + draw)
  active.run();

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