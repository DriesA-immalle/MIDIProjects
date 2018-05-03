import themidibus.*;

HScrollbar hs1;

MidiBus myBus; 
int waarde;
int bus;
  
void setup() {
  size(400, 127);
  frameRate(60);
  textSize(40);
  
  hs1 = new HScrollbar(0, 111, width, 16, 16);
  
  myBus = new MidiBus(this, 0, 3);
}

void draw(){ 
  background(125);
  text("Bus:",80,40);
  text("Value:",220,40);
  text(bus,80,90);
  text(waarde,220,90);
  
  hs1.update();
  hs1.display();

  int xSlider = (int)map(hs1.getSliderPosition(),0,400,0,127);
   
  if(keyPressed == true){
      switch(key){
        case '1':
          myBus.sendControllerChange(0,81,xSlider);
        break;
        case '2':
          myBus.sendControllerChange(0,82,xSlider);
        break;
        case '3':
          myBus.sendControllerChange(0,83,xSlider);
        break;
        case '4':
          myBus.sendControllerChange(0,84,xSlider);
        break;
        case '5':
          myBus.sendControllerChange(0,85,xSlider);
        break;
        case '6':
          myBus.sendControllerChange(0,86,xSlider);
        break;
        case '7':
          myBus.sendControllerChange(0,87,xSlider);
        break;
        case '8':
          myBus.sendControllerChange(0,88,xSlider);
        break;        
      }  
      for(int i = 0; i <= 8; i++){
         myBus.sendControllerChange(0, 1+i, xSlider); 
      }
  }
}

void controllerChange(int channel, int number, int value) {
  waarde = value;
  bus = number;
}
