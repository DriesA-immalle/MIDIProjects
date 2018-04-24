import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
  int counter = 1;
  int direction = 1;
void setup() {
  size(400, 127);
  frameRate(60);
  textSize(40);


  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 3); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw(){
  if(counter <=0) {
    direction = 1;
  }
  
  if(counter >= 127) { 
    direction = -1;
  }

  counter += direction;
  clear();
  text(counter,180,63);
  
  for(int i = 0; i < 8; i++){
    myBus.sendControllerChange(0, 81 + i, counter);
    myBus.sendControllerChange(0, 1 + i, counter);
    myBus.sendControllerChange(0, 65 + i, counter);
    myBus.sendControllerChange(0, 73 + i, counter);
  }
}
  

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}
