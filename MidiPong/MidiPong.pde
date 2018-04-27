import themidibus.*;

MidiBus myBus; 

GameMode gameMode  = GameMode.startScreen;

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

enum GameMode{
 startScreen,
 playing,
 gameOver
};


void setup() 
{
  size(1300, 600);
  noStroke();
  frameRate(60);
  
  ellipseMode(RADIUS);
  myBus = new MidiBus(this, 0, 3);
  xpos = 400;
  ypos = 200;
}

void draw() 
{
  switch(gameMode){
    case startScreen:
      textSize(80);
      text("PONG",width/2-100,height/2);
      text("Press any key to start!",width/2-400,height/2+90);
      if(keyPressed){
       gameMode = GameMode.playing; 
      }
    break;
    
    case playing:
        background(gray);
        puntenTeller();

        xpos = xpos + ( xspeed * xdirection );
        ypos = ypos + ( yspeed * ydirection );

        if (ypos > height-rad || ypos < rad) {
          ydirection *= -1;
        }

       if (xpos > xPalletinks + rad 
          && xpos < xPalletinks + (rad+5) 
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
      stroke(0);
      strokeWeight(1);
      ellipse(xpos, ypos, rad, rad);
    
    
      textSize(20);
      fill(1);
      text(tellerLinks, 70,50);
      text(tellerRechts, 1210,50);
    
      fill(0,125,125);
      stroke(0);
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
      
      if(tellerLinks == 7){
        winner = "L";
        gameMode = GameMode.gameOver;
      }
      
      if(tellerRechts == 7){
        winner = "R";
        gameMode = GameMode.gameOver;
      }
   case gameOver:
      

      if(winner == "L"){
        clear();
        background(200);
        fill(255);
        text("Congratulations player left!",width/2-130,height/2);
        text("You won with " + tellerLinks + " to " + tellerRechts,width/2-90,height/2+50);
      }
      
      if(winner == "R"){
        clear();
        background(200);
        fill(255);
        text("Congratulations player right!",width/2-135,height/2);
        text("You won with " + tellerRechts + " to " + tellerLinks,width/2-90,height/2+50);
      }
   break;
   }
}
  

void puntenTeller()
{  
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


void controllerChange(int channel, int number, int value) {
    if(number == 81){
      yPalletLinks = (int)map(value,127,0,0,width-(lengtePallet+700));
    }
  
    if(number == 88){
      yPalletRechts = (int)map(value,127,0,0,width-(lengtePallet+700));
    }
  
    if(number == 73 && value == 127){
      AILinks = 1;
    } else if(number == 73 && value == 0){
      AILinks = 0;
    }
  
    if(number == 80 && value == 127){
      AIRechts = 1;
    } else if (number == 80 && value == 0){
      AIRechts = 0; 
    }
    
    if(number == 8){
       xspeed = (int)map(value,0,127,1,4.9);
       yspeed = (int)map(value,0,127,1,4.9);
    }

    if(number == 7){
       rad = (int)map(value,0,127,5,30); 
    }
    
    if(number == 6){
       lengtePallet = (int)map(value,0,127,20,180); 
    }
    
    if (number == 5){
      gray = (int)map(value,0,127,100,200);
    }
    
    if (number == 35){
     gray = 125;
    }
}
