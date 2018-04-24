import themidibus.*;

MidiBus myBus; 

int rad = 20;        
float xpos, ypos;    

float xspeed = 4.9;  
float yspeed = 4.9;  

int xdirection = 1;  
int ydirection = 1;  

int tellerRechts = 0;
int tellerLinks = 0;

int breedtePallet = 10;
int lengtePallet = 150;

int xPalletinks = 15;
int xPalletRechts = 1270;
int yPalletLinks = 200;
int yPalletRechts = 200;

int beweegPallet = 5;


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
  background(120);
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

  fill(0,255,0);
  stroke(0,255,0);
  rect(xPalletinks,yPalletLinks,breedtePallet,lengtePallet);
  rect(xPalletRechts,yPalletRechts,breedtePallet,lengtePallet);
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
    yPalletLinks = (int)map(value,127,0,0,450);
  }
  
  if(number == 88){
    yPalletRechts = (int)map(value,127,0,0,450);
  }
}
