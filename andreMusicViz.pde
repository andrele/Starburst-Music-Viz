import ddf.minim.analysis.FFT;
import ddf.minim.*;
import controlP5.*;

Minim minim;
AudioInput input;
FFT fftLog;

ControlP5 cp5;

// Setup params
color bgColor = color(0,0,0);
static int SCREEN_WIDTH = 800;
static int SCREEN_HEIGHT = 600;

// Modifiable parameters
float spectrumScale = 4;
float STROKE_MAX = 20;
float STROKE_MIN = 5;
float strokeMultiplier = 3;
float audioThresh = 0;


void setup(){
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
  
  frameRate(60);
  
  minim = new Minim(this);
  input = minim.getLineIn(minim.MONO, 2048);
  
  fftLog = new FFT( input.bufferSize(), input.sampleRate());
  fftLog.logAverages( 22, 3);
  
  noFill();
  
  ellipseMode(RADIUS);
}

void draw(){
  background(0);
  pushMatrix();
  translate(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
  
  // Push new audio samples to the FFT
  fftLog.forward(input.left);
  
  
  // Loop through frequencies and compute width for ellipse stroke widths, and amplitude for size
  for (int i = 0; i < fftLog.avgSize(); i++) {
    
    // What is the centerpoint of the this frequency band?
    float centerFrequency = fftLog.getAverageCenterFrequency(i);
    
    // What is the average width of this freqency?
    float averageWidth = fftLog.getAverageBandWidth(i);
    
    // Get the left and right bounds of the frequency
    float lowFreq = centerFrequency - averageWidth/2;
    float highFreq = centerFrequency + averageWidth/2;
    
    // Convert frequency widths to actual sizes
    int xl = (int)fftLog.freqToIndex(lowFreq);
    int xr = (int)fftLog.freqToIndex(highFreq);
    
    // What is the average height in relation to the screen height?
    float amplitude = fftLog.getAvg(i);
    
    pushStyle();
    // Calculate the gray value for this circle
    stroke(amplitude*255);
//    strokeWeight(map(amplitude, 0, 1, STROKE_MIN, STROKE_MAX));
    strokeWeight((float)(xr-xl)*strokeMultiplier);
    
    // Draw an ellipse for this frequency
    ellipse(0, 0, amplitude*SCREEN_HEIGHT/2, amplitude*SCREEN_HEIGHT/2);
    
    popStyle();
  }
  
  popMatrix();
  
}
