class button{
   //x, y, width, height
  int x, y, w, h;
  String t;//text
  int tS;//textSize
  
  button(int a,int b,int c,int d, String e, int f){
    //x0, y0, x1, y1, t
    x = a;
    y = b;
    w = c;
    h = d;
    t = e;
    tS = f;
  }
  
  void showButton(){
    if(abs(mouseX - x) <= w/2 && abs(mouseY - y) <= h/2){
      fill(200);
    }
    else fill(255);
    rectMode(CENTER);
    stroke(0);
    rect(x, y, w, h);
    
    textSize(tS);
    fill(0);
    textAlign(CENTER, CENTER);
    text(t, x , y-5);
  }
}
  
    
