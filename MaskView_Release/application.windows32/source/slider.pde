class slider{
  int posX;
  int posY;
  int barWidth;
  int sliderWidth;
  int sliderHeight;
  float value;
  String t;
  
  slider(int pX, int pY, int bW, int sW, int sH, int v0,String te){
    //posX, posY, barWidth, sliderWidth, sliderHeight
    posX = pX;
    posY = pY;
    barWidth = bW;
    sliderWidth = sW;
    sliderHeight = sH;
    value = v0;
    t = te;
  }
  
  float slide(){
    textAlign(LEFT);
    textSize(50);
    fill(0);
    text(t, posX - 20, posY - 40);
    textSize(30);
    text(int(value), posX + 230, posY + 10);
    
    if(keyPressed == true){
           if(key == 'z') value = 0;
      else if(key == 'x') value = 50;
      else if(key == 'c') value = 100;
    }
    
    stroke(0);
    strokeWeight(5);
    line(posX, posY, posX + barWidth, posY);
    fill(255);
    rectMode(CENTER);
    rect(posX+value * 2, posY, sliderWidth, sliderHeight);
    
    if(abs(mouseX - posX - value * 2) < sliderWidth + 20 && abs(mouseY - posY) < sliderHeight + 20){
      fill(200);
      rect(posX + value * 2, posY, sliderWidth, sliderHeight);
      
      if(mousePressed == true && mouseButton == LEFT){
        value = (mouseX - posX) / 2;
      }
    }
    
    value = constrain(value, 0, 100);
    return value;  
  }
}
