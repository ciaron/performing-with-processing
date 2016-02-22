/*
  This is part of a set of examples of using Processing for live presentation of
  multiple sketches with controllers (e.g VJ-ing)
  
  You're free to use this code for any purpose.
  
  Author : Ciaron Linstead
  https://github.com/ciaron
  
  Example 1: setup and run multiple sketches as separate Java classes.
             This example implements two sketches which can be selected
             with keys '1' and '2' while running.

*/


// We define an interface, which will be implemented for each 
// sketch we want to run.

public interface Sketch {
  public String status();
  public void run();
}

Sketch active;  // declare a main, active sketch.

// define two sketches, one for each implementation
Sketch s1 = new Sketch1(6);  // constructor for Sketch1 takes an int.
Sketch s2 = new Sketch2();   // constructor for Sketch2 takes no parameters
    
void setup() {
  size(600,600,P2D);

  // or, use fullscreen on a second display:
  //fullScreen(P2D, 2);
  
  // set the active sketch to one of our implementations
  active = s1;
}

void draw() {

  // run the current sketch (update + draw)
  active.run();

  // intermittently output some status info
  if (frameCount % 600 == 0) {
    println("in", active.status());
  }  
}

void keyPressed() {
  // switch between sketches with key '1' or '2'
  if (key == '1') {
    active = s1;
  }
  if (key == '2') {
    active = s2;
  }
  println(active.status());
}