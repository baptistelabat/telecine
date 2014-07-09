/* #####################################*/
import processing.video.*;
import processing.serial.*;
Capture cam;
Serial arduinoPort;
int no = 0;
// tout ce bazar c'est juste pour mesurer le nbre réel d'images par seconde
int sec, prevSec; 
int camIPS;
int sumCount, camIPSsum;
int nb_digit = 5; // until 99999 (18fps during 9min max + margin)
char inByte = '0';
float avgCamIPS;
// fin du bazar
void setup() {
  // Afficher les ports séries disponibles
  println(Serial.list());
  // Ouvre le port série vers l'arduino
  arduinoPort = new Serial(this, Serial.list()[0], 19200);
  size(640, 480);
// Configuration de la WEBCAM
  String[] cameras = Capture.list();
  println("Program started");
  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Caméras détectées et configurations acceptées :");
    for (int i = 0; i < cameras.length; i++) {
      print(i+"\t");
      println(cameras[i]);
    }
  // choisir ici la camera
    // la configuration ci-dessous est basée sur les conf' supportées selon "Capture.list()" plus haut
    cam = new Capture(this, 1280, 960, "/dev/video1");
    //cam = new Capture(this, 1280, 960, "Vimicro USB2.0 UVC PC Camera", 15);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
      
    // Start capturing the images from the camera
    cam.start();
 
  }
  //frameRate(30);
}
void draw() {  
  if (cam.available() == true) {
    NewImage();
  }
  
  while (arduinoPort.available()>0)
  {
    inByte = arduinoPort.readChar();
    println(inByte);
  }
  
  if (inByte == '1')
  {
    println("Saving image");
    cam.save("Image" + nf(no, nb_digit) + ".png");
    no = (no + 1);
  }
 
  //calculCamIPS();
 
  // décommenter si dessous pour avoir un affichage 
  image(cam, 0, 0, width, height);
  
  //println("fps="+frameRate);
  //println("avgCamIPS="+(camIPSsum/float(sumCount)));
  

}
// FONCTION : calcul du nombre d'images par seconde capturés sur la cam
void calculCamIPS()
{
  
  sec = second();
  if (sec != prevSec) 
  {
    prevSec = sec;
    println("camIPS="+camIPS);
    camIPSsum+= camIPS;
    sumCount++;
    camIPS = 0;
  }  
}
void NewImage()
{
   cam.read();
  // incrémente le compte pour le calcul du nombre d'image par seconde
  camIPS += 1; 
}
/* #####################################*/
