import ddf.minim.*;
import controlP5.*;

Minim minim;
AudioInput input;
FFT fftLog

ControlP5 cp5;

// Setup params
color bgColor = color(0,0,0);
static int SCREEN_WIDTH = 800;
static int SCREEN_HEIGHT = 600;


void setup(){
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
  
  frameRate(60);
  
  minim = new Minim(this);
  input = minim.getLineIn(minim.MONO, 2048);
  
  fftLog = new FFT( input.bufferSize(), input.sampleRate());  
}

void draw(){
  background(bgColor);
  
}
