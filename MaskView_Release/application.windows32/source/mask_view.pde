PImage p0,p1;  //show 1, hide 0

String p0Name = "null", p1Name = "null";
String p0Path, p1Path;

slider T;//transparency
float tra;

int maskShape = 0;
int maskWid = 150, maskHei = 150;
int maskAng = 0;//angle

int scrollX = 0, scrollY = 0;

button sh, hi;//show & hide
button re, el, tri;//rect ellipse triangle
button angUp, angDown;//maskAngle ++ --
button widUp, widDown;
button heiUp, heiDown;
button cancel;

TF stroke;
boolean st = true;//stroke
TF wid_hei;//width = height
boolean wh = true;

//mouseX, mouseY, maskaWid, maskHei, maskaAng, maskShape, stroke
int[][] masks = new int[21][8];//many masks
int count = 0;//maskcount

void setup() {
  size(1280, 720, P2D);
  surface.setTitle("Mask view");
  surface.setResizable(true);
  //surface.setLocation(100,100);
  //selectInput("showImage", "show");
  
  rectMode(CENTER);
  //posX, posY, barWidth, sliderWidth, sliderHeight, deafultValue, text
  T = new slider(45, 250, 200, 30, 30, 100, "Transparency");
  //x, y, width, height, text, textSize
  sh =      new button( 75,  50, 100,  50, "Show", 30);
  hi =      new button( 75, 125, 100,  50, "Hide", 30);
  re =      new button( 75, 400, 100, 100, "□", 75);
  el =      new button(200, 400, 100, 100, "Ο", 75);
  tri =     new button( 75, 525, 100, 100, "Δ", 75);
  angUp =   new button(300, 370,  50,  40, "+", 30);
  angDown = new button(300, 430,  50,  40, "-", 30);
  widUp =   new button(300, 495,  50,  40, "+", 30);
  widDown = new button(300, 555,  50,  40, "-", 30);
  heiUp =   new button(300, 620,  50,  40, "+", 30);
  heiDown = new button(300, 680,  50,  40, "-", 30);
  cancel =  new button(200, 525,  100, 100, "cancel", 30);
  //x, y, width, height, deafult TF, textSize
  stroke  = new TF(50, 625, 50, 40, 30);
  wid_hei = new TF(50, 685, 50, 40, 30);
  
}

void draw() {
  background(150);
  
  //from up to down
  sh.showButton();
  hi.showButton();
  tra = T.slide();
  re.showButton();
  el.showButton();
  tri.showButton();
  cancel.showButton();
  angUp.showButton();
  angDown.showButton();
  widUp.showButton();
  widDown.showButton();
  heiUp.showButton();
  heiDown.showButton();
  stroke.showTF(st);
  wid_hei.showTF(wh);
  
  textSize(30);
  fill(0);
  textAlign(LEFT, CENTER);
  text(p1Name, 140, 45);//y - 5
  text(p0Name, 140, 120);
  textSize(50);
  text("maskShape", 25, 300);
  textAlign(LEFT, BOTTOM);
  text(maskAng, 350, 450);
  text(maskWid, 350, 575);
  text(maskHei, 350, 700);
  text("stroke", 90, 650);
  textSize(30);
  text("angle:", 350, 390);
  text("width:", 350, 515);
  text("height:", 350, 640);
  textSize(25);
  text("width=height", 90, 700);
  
  //draw pictures
  if(p0 != null && p1 != null){
    tint(255, 255);
    p1.resize( p1.width * height / p1.height, height);
    p0.resize( p0.width * height / p0.height, height);
    image(p1, width - p1.width, 0);
    image(p0, width - p0.width, 0);
    image(p1, width - p1.width, 0);
    
    if(mouseX <= width - p1.width || mouseX >= width - 5 || mouseY >= height - 5) cursor();
    else noCursor();
 
    if(mouseButton != RIGHT) mask();
    
  }
  //println(count);
}

//----------------------------------------------------------------

//buttonPressd
void mouseClicked(){
  //rect
  if(abs(mouseX - 75) <= 50 && abs(mouseY - 400) <= 50){
    maskShape = 4;
    maskWid = 150;
    maskHei = 150;
    maskAng = 0;
    }
  //ellipse
  else if(abs(mouseX - 200) <= 50 && abs(mouseY - 400) <= 50){
    maskShape = 360;
    maskWid = 150;
    maskHei = 150;
    maskAng = 0;
  }
  //triangle
  else if(abs(mouseX - 75) <= 50 && abs(mouseY - 525) <= 50){
    maskShape = 3;
    maskWid = 150;
    maskHei = 150;
    maskAng = 0;
  }
  //cancel
  else if(abs(mouseX - 200) <= 50 && abs(mouseY - 525) <= 50){
    if(maskShape == 0){
      count --;
      count = constrain(count, 0, 19);
      for(int k = 0; k < 7; k++){
        masks[count][k] = 0;
      }
    }
    maskShape = 0;
    maskWid = 150;
    maskHei = 150;
    maskAng = 0;
  }
  //show
  else if(abs(mouseX - 75) <= 50 && abs(mouseY - 50) <= 25 && mouseButton == LEFT){
    selectInput("showImage", "show");
  }
  //hide
  else if(abs(mouseX - 75) <= 50 && abs(mouseY - 125) <= 25 && mouseButton == LEFT){
    selectInput("showImage", "hide");
  }
  //angle+-
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 370) <= 20){
    maskAng ++;
  }
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 430) <= 20){
    maskAng --;
  }
  //width+-
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 495) <= 20){
    maskWid += 5;
  }
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 555) <= 20){
    maskWid -= 5;
  }
  //height+-
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 620) <= 20){
    maskHei += 5;
  }
  else if(abs(mouseX - 300) <= 25 && abs(mouseY - 680) <= 20){
    maskHei -= 5;
  }
  //stroke TF
  else if(abs(mouseX - 50) <= 25 && abs(mouseY - 625) <= 20){
    if(st == true) st = false;
    else st = true;
  }
  //wid_hei TF
  else if(abs(mouseX - 50) <= 25 && abs(mouseY - 685) <= 20){
    if(wh == true) wh = false;
    else wh = true;
  }
  //saveMasks
  if(p0 != null && p1 != null){
    if(mouseX >= width - p1.width){
      //mouseX, mouseY, maskaWid, maskHei, maskaAng, maskShape, stroke
      masks[count][0] = mouseX;
      masks[count][1] = mouseY;
      masks[count][2] = maskWid;
      masks[count][3] = maskHei;
      masks[count][4] = maskAng;
      masks[count][5] = maskShape;
      masks[count][6] = int(st);
      count++;
      count = constrain(count, 0, 19);
    }
  }
}

//----------------------------------------------------------------
//drawMasks
void mask(){
  if(scrollX != 0 || scrollY != 0){
    maskWid -= scrollX * 5;
    maskHei -= scrollY * 5;
    scrollX = 0;
    scrollY = 0;
  }
  if(keyPressed == true){
    switch(key){
      case 'w':
        maskHei += 5;
        break;
      case 's':
        maskHei -= 5;
        break;
      case 'a':
        maskWid -= 5;
        break;
      case 'd':
        maskWid += 5;
        break;
      case 'q':
        maskAng -= 1;
        break;
      case 'e':
        maskAng += 1;
        break;
    }
  }
  if(wh) maskWid = maskHei;
  
  for(int j = 0; j < count; j++){
    drawMasks(masks[j][0],masks[j][1],masks[j][2],masks[j][3],masks[j][4],masks[j][5],masks[j][6]);
  }
    drawMasks(mouseX, mouseY, maskWid, maskHei, maskAng, maskShape, int(st));

}
//posX, posY, maskWid, maskHei, maskAng, maskShape, stroke
void drawMasks(int posX, int posY, int wid, int hei, int ang, int sha, int str){
  beginShape();
  if(str != 0) stroke(0);
  else noStroke();
  if(posX <= width - p1.width) noFill();
  else texture(p0);
  
  if(sha != 0){
    tint(255, tra * 2.55);
    if(posX <= width - p1.width) noFill();
    else texture(p0);
    
    switch(sha){
      case 4:
        for(int i = ang + 45; i < 405 + ang; i+=90){
        vertex(posX + cos(radians(i)) * wid / 2, posY + sin(radians(i)) * hei / 2, posX + cos(radians(i)) * wid / 2 - width + p1.width, posY + sin(radians(i)) * hei / 2);
        }
      break;
      case 3:
        for(int i = ang + 30; i < 390 + ang; i+=120){
        vertex(posX + cos(radians(i)) * wid / 2, posY + sin(radians(i)) * hei / 2, posX + cos(radians(i)) * wid / 2 - width + p1.width, posY + sin(radians(i)) * hei / 2);
        }
      break;
      case 360:
        for(int i = ang; i < 360 + ang; i+=10){
        vertex(posX + cos(radians(i)) * wid / 2, posY + sin(radians(i)) * hei / 2, posX + cos(radians(i)) * wid / 2 - width + p1.width, posY + sin(radians(i)) * hei / 2);
        }
      break;
    }
    endShape(CLOSE);
  }
}
//----------------------------------------------------------------

void keyReleased(){
  if(key == 'r'){//reload images
    p1 = loadImage(p1Path);
    p0 = loadImage(p0Path);
  }
}

void mouseWheel(MouseEvent event) {
  if(keyPressed == true && keyCode == SHIFT){
    scrollX = event.getCount();  
  }
  else scrollY = event.getCount();  
}

void show(File a){
    p1 = loadImage(a.getAbsolutePath());
    p1Path = a.getAbsolutePath();
    p1Name = a.getName();
    
  }
void hide(File a){
    p0 = loadImage(a.getAbsolutePath());
    p0Path = a.getAbsolutePath();
    p0Name = a.getName();
  }
