/*
Joep Eijkemans 30-12-18
Processing 3.4

This program creates a preset number of circles that get increasingly smaller according to the golden ratio (≈ 1.618). 
Each circle rotates around the center of the bigger circle. The smaller the circle, the faster it rotates.

Copyright 2018, Joep Eijkemans, All rights reserved.

www.joepeijkemans.nl
*/


int NumberOfCircles = 10; //Number of circles, can be changed
int CircleSize = 700; //Size of the largest circle
float GoldenRatio = 1.618; //Golden Ratio for beauty
float GoldenRatioInverted = 1/1.618; //0.61804694

float Xpos[] = new float[NumberOfCircles];
float Ypos[] = new float[NumberOfCircles];
float Size[] = new float[NumberOfCircles];

void setup() {
  size(900, 900); //Screensize
  strokeWeight(2); //Weight of the lines
  stroke(255); //Colour of the circles
  noFill(); //No fill, but you could use a colour if preferred
  ellipseMode(CENTER); //Default
  Xpos[0] = width/2; //Largest circle starts in the middle
  Ypos[0] = height/2;
  Size[0] = CircleSize; //Size of the largest circle
  
  for (int i = 1; i< NumberOfCircles; i++) { //The parameters of the first circle has already been defined
    Xpos[i]= 450; //Every circle starts at the same X position
    float distance = (Size[i-1] * (1- GoldenRatioInverted))/2; //so that all the circles allign at the bottom
    Ypos[i] = Ypos[i-1] + distance;
    Size[i] = Size[i-1] * GoldenRatioInverted; //Make each circle smaller
  }
}

void draw() {
  float t = millis()/1750.0f; //The time variable :: set higher for a longer duration
  background(0); //Refresh a black background each frame, try removing this line to see what happens
  ellipse(Xpos[0], Ypos[0], CircleSize, CircleSize); //Draw the largest circle separate, this one doesn't rotate
  for (int i = 1; i < NumberOfCircles; i++) {
    Xpos[i] = (float)(Xpos[i-1]+(Size[i]/(2*GoldenRatio))*-sin(t*(i+1/NumberOfCircles)*GoldenRatio)); //Set the positions to rotate, notice that simply t*i also works, each circle rotates faster
    Ypos[i] = (float)(Ypos[i-1]+(Size[i]/(2*GoldenRatio))*cos(t*(i+1/NumberOfCircles)*GoldenRatio));
    ellipse(Xpos[i], Ypos[i], Size[i], Size[i]); //draw the circles
  }
  //saveFrame("Output/Frame_####.png"); //used to record a .mov 
}
