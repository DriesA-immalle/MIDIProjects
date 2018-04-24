import themidibus.*;

MidiBus myBus; 

int rad = 10;        
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

int AILinks;
int AIRechts;


void setup() 
{
  size(1300, 600);
  noStroke();
  frameRate(80);
  
  ellipseMode(RADIUS);
  myBus = new MidiBus(this, 0, 3);
  xpos = 400;
  ypos = 200;
}

void draw() 
{
  background(175);
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
      yPalletLinks = (int)ypos - 50;
      myBus.sendControllerChange(0,81,(int)map(ypos,600,0,0,127));
  }
  
  if(AIRechts == 1){
      yPalletRechts = (int)ypos - 50;
      myBus.sendControllerChange(0,88,(int)map(ypos,600,0,0,127));
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
    yPalletLinks = (int)map(value,127,0,0,500);
  }
  
  if(number == 88){
    yPalletRechts = (int)map(value,127,0,0,500);
  }
  
  if(number == 89 && value == 127){
    AILinks = 1;
  } else if(number == 89 && value == 0){
   AILinks = 0;
  }
  
    if(number == 90 && value == 127){
    AIRechts = 1;
  } else if (number == 90 && value == 0){
   AIRechts = 0; 
  }
}
