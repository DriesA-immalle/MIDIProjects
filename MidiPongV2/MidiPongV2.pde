import themidibus.*;

MidiBus myBus; 

GameMode gameMode  = GameMode.startScreen;


enum GameMode{
 startScreen,
 playing,
 gameOver
};


PongGame p = new PongGame();


void setup() 
{
  size(1300, 600);
  noStroke();
  frameRate(80);
  
  
  ellipseMode(RADIUS);
  myBus = new MidiBus(this, 0, 3);
  p.xpos = 400;
  p.ypos = 200;
}

void draw() {   
   switch(gameMode){
   case startScreen:
     handleStartScreen();     
   break;
    
   case playing:
     handlePlaying();
   break;
      
   case gameOver:
     handleGameOver();
   }
      
   if(p.winner == "R"){
     clear();
     background(p.gray);
     fill(p.red,p.green,p.blue);
     text("Congratulations player right!",width/2-180,height/2);
     text("You won with " + p.tellerRechts + " to " + p.tellerLinks,width/2-130,height/2+50);
     text("Press R to play again",width/2-132,height/2+100);
     if(keyPressed && key == 'r'){
       p.tellerLinks = 0;
       p.tellerRechts = 0;
       gameMode = GameMode.startScreen; 
    }
  }
}


void handleStartScreen(){
      clear();
      fill(p.red,p.green,p.blue);
      background(p.gray);
      textSize(80);
      text("PONG",width/2-100,height/2);
      text("Press P to start!",width/2-275,height/2+90);
      if(keyPressed && key == 'p'){
        gameMode = GameMode.playing; 
     }
}


void handlePlaying(){
        background(p.gray);
        p.updatePunten();

        p.xpos = p.xpos + ( p.xspeed * p.xdirection );
        p.ypos = p.ypos + ( p.yspeed * p.ydirection );

        p.drawPong();
}


void handleGameOver(){
      if(p.winner == "L"){
        clear();
        background(p.gray);
        fill(p.red,p.green,p.blue);
        text("Congratulations player left!",width/2-175,height/2);
        text("You won with " + p.tellerLinks + " to " + p.tellerRechts,width/2-130,height/2+50);
        text("Press R to play again",width/2-132,height/2+100);
        if(keyPressed && key == 'r'){
           p.tellerLinks = 0;
           p.tellerRechts = 0;
           gameMode = GameMode.startScreen; 
        }
    }
}


void controllerChange(int channel, int number, int value) {
    println(number);
    if(number == 81){
      p.yPalletLinks = (int)map(value,127,0,0,width-(p.lengtePallet+700));
    }
  
    if(number == 88){
      p.yPalletRechts = (int)map(value,127,0,0,width-(p.lengtePallet+700));
    }
  
    if(number == 73 && value == 127){
      p.AILinks = 1;
    } else if(number == 73 && value == 0){
      p.AILinks = 0;
    }
  
    if(number == 80 && value == 127){
      p.AIRechts = 1;
    } else if (number == 80 && value == 0){
      p.AIRechts = 0; 
    }
    
    if(number == 8){
       p.xspeed = (int)map(value,0,127,1,4.9);
       p.yspeed = (int)map(value,0,127,1,4.9);
    }

    if(number == 7){
       p.rad = (int)map(value,0,127,5,30); 
    }
    
    if(number == 6){
       p.lengtePallet = (int)map(value,0,127,20,180); 
    }
    
    if(number == 5){
      p.gray = (int)map(value,0,127,100,200);
    }
    
    if(number == 35){
     p.gray = 125;
    }
    
    if(number == 2){
      p.red = (int)map(value,0,127,0,255);
    }
    
    if(number == 3){
      p.green = (int)map(value,0,127,0,255);
    }
    
    if(number == 4){
      p.blue = (int)map(value,0,127,0,255);      
    }
}   
