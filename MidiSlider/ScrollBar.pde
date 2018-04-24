class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin = 0, sposMax = 127; // max and min values of slider
  int loose;              // how loose/heavy
  float ratio;


  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    // init member vars
    swidth = sw;
    sheight = sh;
    int widthtoheight = swidth - sheight;
    ratio = (float)swidth / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = 0;
    sposMax = 127;
    loose = l;
  }

  void update() {
    boolean over = overEvent();
    boolean locked = false;
    
    if (mousePressed && over) {
      locked = true;
    }
    
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int getSliderPosition() {
    return (int)spos; 
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    fill(0, 0, 0);
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
