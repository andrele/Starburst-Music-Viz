import ddf.minim.*;
import controlP5.*;

Minim minim;
AudioInput input;

ControlP5 cp5;

static int SCREEN_WIDTH = 800;
static int SCREEN_HEIGHT = 600;

// Setup params


void setup(){

  frameRate(60);
  
  minim = new Minim(this);
  input = minim.getLineIn(minim.MONO, 2048);
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  
  
  
  
  
}

void draw(){

}
