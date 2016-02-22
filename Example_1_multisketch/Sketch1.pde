class Sketch1 implements Sketch {

  // private variables are only visible inside this class.
  private int n;
  private int x;
  private String status = "Sketch1";

  // constructor - initialise the sketch here
  public Sketch1(int _i) {
    x = 0;
    n = _i;
    status = status + "(" + str(n) + ")";
  }
   
  private void update() {
    x+=n;
  }
  
  private void draw() {
    
    // Implement what we want to draw here
    
    background(0);
    strokeWeight(2);
    stroke(255);
    noFill();
    
    for (int i=0; i<n; i++) {
      ellipse(width/2,height/2,frameCount%(200/(i+1)), frameCount%(400/(i+1)));
    }  
  }
   
  public String status() {
    return status;
  }

  public void run() {
    update();
    draw();
  }
  
}