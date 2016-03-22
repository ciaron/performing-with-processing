import ddf.minim.*;

class Sketch2 implements Sketch {

  // these variables are only visible inside this class.
  private float t;
  private float x;
  private String status = "Sketch2";
  
  Minim minim;
  AudioPlayer player;
    
  // constructor - initialise the sketch here
  public Sketch2(PApplet parent) {
    minim = new Minim(parent);
    player = minim.loadFile("groove.mp3");
    t=0.01;
    x=0;
  }
  
  private void update() {
    x+=t;
  }
  
  private void draw() {

    // Implement what we want to draw here
    player.play();
    background(255);
    strokeWeight(12);
    stroke(0);
    noFill();
    rectMode(CENTER);
    
    rect(width/2,height/2,frameCount%200, frameCount%400);
    
  }
  
  public String status() {
    return status;
  }
  
  public void run() {
    update();
    draw();
  }
  
}