class PongGame{
  int rad = 15;        
  float xpos, ypos;    
  
  float xspeed = 4.9;  
  float yspeed = 4.9;  
  
  int xdirection = 1;  
  int ydirection = 1;  
  
  int tellerRechts = 0;
  int tellerLinks = 0;
  
  int breedtePallet = 10;
  int lengtePallet = 100;
  
  int xPalletinks = 15;
  int xPalletRechts = 1270;
  int yPalletLinks = 200;
  int yPalletRechts = 200;
  
  int beweegPallet = 5;
  
  int gray = 125;
  
  String winner;
  
  int AILinks;
  int AIRechts;
  
  void drawPong(){
     if (ypos > height-rad || ypos < rad) {
          ydirection *= -1;
        }

       if (xpos > xPalletinks + rad 
          && xpos < xPalletinks + (rad+10) 
          && ypos > yPalletLinks 
          && ypos < yPalletLinks + lengtePallet)
       {
       xdirection *= -1;
       }    

      if (xpos > xPalletRechts - rad 
        && xpos < xPalletRechts - (rad-5) 
        && ypos > yPalletRechts 
        && ypos < yPalletRechts + lengtePallet)
      {
        xdirection *= -1;
      }
      
      noStroke();
      fill(255);
      stroke(255);
      strokeWeight(1);
      ellipse(xpos, ypos, rad, rad);
    
      textSize(30);
      fill(250);
      text(tellerLinks, 70,50);
      text(tellerRechts, 1210,50);
    
      noFill();
      stroke(255);
      strokeWeight(2);
      rect(xPalletinks,yPalletLinks,breedtePallet,lengtePallet,20);
      rect(xPalletRechts,yPalletRechts,breedtePallet,lengtePallet,20);
      
      if(AILinks == 1){
         yPalletLinks = (int)ypos - (lengtePallet/2);
         myBus.sendControllerChange(0,81,(int)map(ypos,600,0,0,127));
      }
      
      if(AIRechts == 1){
         yPalletRechts = (int)ypos - (lengtePallet/2);
         myBus.sendControllerChange(0,88,(int)map(ypos,600,0,0,127));
      }
      
      if(tellerLinks == 3){
        winner = "L";
        gameMode = GameMode.gameOver;
      }
      
      if(tellerRechts == 3){
        winner = "R";
        gameMode = GameMode.gameOver;
      }
  }
  
  void updatePunten(){
    float rnd = random(rad,height-rad);

    if (xpos > width-rad) 
    {
      tellerLinks += 1;
      xpos = 650;
      ypos = int(rnd);
    }
    if (xpos < rad) 
    {
      tellerRechts += 1;
      xpos = 650;
      ypos = int(rnd);
    }
   }
  }
