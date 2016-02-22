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

Sketch active;  // declare a main, active sketch.
Sketch[] sketches;
    
// set up a MIDI controller. We pass the name of a callback method that
// we process Program Change messages with, e.g. switching sketches
Controller ctrl = new Controller("doupdates"); 
    
void doupdates() {
  println("here");
  active = sketches[ctrl.msg]; 
}

void setup() {
  size(600,600,P2D);
 
  // define two sketches, one for each implementation
  sketches = new Sketch[2];
  sketches[0] = new Sketch1(6); // constructor for Sketch1 takes an int.
  sketches[1] = new Sketch2();  // constructor for Sketch2 takes no parameters
  
  // or, use fullscreen on a second display:
  //fullScreen(P2D, 2);
  
  // set the active sketch to one of our implementations
  active = sketches[0];
}

void draw() {

  // run the current sketch (update + draw)
  active.run();

  // intermittently output some status info
  if (frameCount % 60 == 0) {
    println("in", active.status());
  }  
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