//!! Notice:In order to run successfully, you need to install Video library and OpenCV or Processing library. 
//!! Notice:If the code can not be run successfully in Processing 3.5.4, please try Processing 3.4.
//!! Notice:It might take a few seconds to run the code. Please be patient.

//Project Discription
//Nanotechnology is now widely used in many fields such as biology, medicine and material. 
//Nanotechnology means to study the structure of matter on the nanoscale (that is, a nanometer is a billionth of a meter). 
//Specially, many scientists are trying to manipulate nanotechnology to increase human’s utilization of solar energy. 
//Currently, the commercialized solar cells are mainly silicon solar batteries, and their efficiency is usually only 10%-20%, so it is necessary to find new ways to improve solar battery efficiency. 
//If one day, humans can freely control the structure of matter by nanotechnology, creating new and efficient solar batteries, what will happen in the world? This quesition is worth considering.
//In my design, the camera can capture the position of user’s head. 
//When the user’s head moves in left and right directions, the forms and colors of pattern on the screen will change accordingly.
//Different patterns represents different arrangement of nanoparticles.
//Controlling the patterns by user's head indicates that people are capable of freely manipulating the nanotechnology in the future. 
//This project aims to inspire people to think about how to control nanotechonology.

import gab.opencv.*;
import processing.video.*;
import java.awt.*;
float redVals;

Capture video;
OpenCV opencv;


void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 0, 0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
   
  //black background
  pushStyle();
  fill(0, 0, 0, 240);
  rectMode(CENTER);
  rect(width / 2, height / 2, width, height);
  popStyle();
  
  for (int i = 0; i < faces.length; i++) {
    
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

    pushStyle();
  
    float degrees = frameCount * 0.3;
    float scale;
    float yTranslation = 5.0;
    int numSegments = 50;
    float faceX;
    float size1 = 1;    
    float size2 = 25;
    
    background(0);
    stroke(0);
    faceX = map(faces[i].x, 0, 220, 0, width);
  
    // first pattern 
    pushMatrix();
    translate(width / 2 - 220, height / 2 - 180);
    ellipse(0, 0, size1, size1);
    rotate(radians(degrees));
    line(0, 0, 0, yTranslation);
    
    for(int j = 0; j < numSegments; j++) {
      translate(0, yTranslation);
      scale = map(faceX, 0, width, 0.7, 1);
      scale(scale);
      
      redVals = map(faceX, 0, width, 0, 255);
      fill(redVals, 150, 50);
      println(faceX);
      
      ellipse(faceX, faces[i].y, size2, size2);
      rotate(radians(degrees));
      line(0, 0, 0, yTranslation);
    }
    popMatrix();
  
    //second pattern;
    pushMatrix();
    translate(width / 2 - 70, height / 2 - 180);
    ellipse(0, 0, size1, size1);
    rotate(radians(degrees));
    line(0, 0, 0, yTranslation);
    
    for(int j = 0; j < numSegments; j++) {
      translate(0, yTranslation);
      scale = map(faceX, 0, width, 0.7, 1);
      scale(scale);
    
      redVals = map(faceX, 0, width, 0, 255);
      fill(redVals, 150, 150);

      ellipse(faceX, faces[i].y, size2, size2);
      rotate(radians(degrees));
      line(0, 0, 0, yTranslation);
    }
    popMatrix();
  
    //third pattern;
    pushMatrix();
    translate(width / 2 - 220, height / 2 - 80);
    ellipse(0, 0, size1, size1);
    rotate(radians(degrees));
    line(0, 0, 0, yTranslation);
    
    for (int j = 0; j < numSegments; j++) {
      translate(0, yTranslation);
      scale = map(faceX, 0, width, 0.7, 1);
      scale(scale);
    
      redVals = map(faceX, 0, width, 0, 255);
      fill(redVals, 150, 150);

      ellipse(faceX, faces[i].y, size2, size2);
      rotate(radians(degrees));
      line(0, 0, 0, yTranslation);
    }
    popMatrix();
  
    //forth pattern;
    pushMatrix();
    translate(width / 2 - 70, height / 2 - 80);
    ellipse(0, 0, size1, size1);
    rotate(radians(degrees));
    line(0, 0, 0, yTranslation);
    
    for(int j = 0; j < numSegments; j++) {
      translate(0, yTranslation);
      scale = map(faceX, 0, width, 0.7, 1);
      scale(scale);
    
      redVals = map(faceX, 0, width, 0, 255);
      fill(redVals, 150, 50);

      ellipse(faceX, faces[i].y, size2, size2);
      rotate(radians(degrees));
      line(0, 0, 0, yTranslation);
    }
    popMatrix();
  
    popStyle();
 } 
}

void captureEvent(Capture c) {
  c.read();
  
  if (mousePressed == true) {
    noCursor();
  } else {
    cursor(HAND);
  }
}
