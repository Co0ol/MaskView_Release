class TF{
   //x, y, width, height
  int x, y, w, h;
  int tS;//dotSize
  
  
  TF(int a,int b,int c,int d, int f){
    //x0, y0, x1, y1, t
    x = a;
    y = b;
    w = c;
    h = d;
    tS = f;
  }
  
  boolean showTF(boolean bo){
    if(abs(mouseX - x) <= w/2 && abs(mouseY - y) <= h/2){
      fill(200);
    }
    else fill(255);
    rectMode(CENTER);
    stroke(0);
    rect(x, y, w, h);
    if(bo == true){
        textSize(tS);
        fill(0);
        textAlign(CENTER, CENTER);
        text("●", x , y-5);
      }
  
    return bo;
  }
  
}
