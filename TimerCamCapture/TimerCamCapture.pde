// Load image test with M5Stack Timer Camera X module running web_cam arduino app
// Copyright 2022 Andy Modla All Rights Reserved

PImage img; 
PImage img2;
int imgCounter = 0;

static final int REPEAT = 30;
int interval = REPEAT; // 

String TIMER_CAM_X = "http://192.168.0.104";

String jpgUrl = TIMER_CAM_X+"/capture";
String bmpUrl = TIMER_CAM_X+"/bmp";
String url = jpgUrl;
String JPG="jpg";
String BMP= "bmp";
String imgType = JPG;

String outputFolderPath= "output";
boolean saveImg = false;

void setup() {
  size(640, 480);
  //size(1920, 1080);
  //size(2048, 1564);
  background(0);
  fill(128);
  textSize(width/32);
  text("TimerCamCapture: Initialize Stream", 10, 60);

  img = loadImage(url, imgType);  // Load the image from URL
  imgCounter++;
  saveImg = true;
}

void draw() {
  background(0);
  interval--;
  if (interval <= 0) {
    img2 = loadImage(url, imgType);
    imgCounter++;
    if (img2 != null) {
      img = img2;
      img2 = null;
      interval = REPEAT;
      saveImg = true;
    }
  }
  if (img != null) {
    image(img, 0, 0);
    if (saveImg) {
      saveImg = false;
      //save("\\output\\IMG_"+imgCounter+"."+imgType);
      save(outputFolderPath+File.separator+"IMG_"+imgCounter+"."+imgType);
      //save("IMG_"+imgCounter+"."+imgType);
    }
  } else {
    text("Failed LoadImage: "+url, 10, 100);
  }
  text("Counter "+imgCounter+" "+imgType, 10, 20);
}

void mousePressed() {
  img = loadImage(url, imgType);  // Load the image into the program
  imgCounter++;
}
