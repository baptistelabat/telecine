/* #####################################*/
int i;
int x;
long deltat, t;
int ledPin = 13;
int sensorPin = 2;
boolean isPrinted;
volatile int state = HIGH;
void setup()
{
    pinMode(sensorPin, INPUT); // broche de détection 
    pinMode(ledPin, OUTPUT); // broche de la LED
    pinMode(12, OUTPUT); // broche de la LED
    digitalWrite(12, HIGH); // on allume la LED
    Serial.begin(19200); // démarrage liaison série à 19200 bauds
    x=0;
    t = millis();
    attachInterrupt(0, blink, CHANGE);
    isPrinted = false;
}
void loop()
{  
    //i = digitalRead(sensorPin); // lecture de l'interrupteur optique
     if (isPrinted==false)
     {
      Serial.print("delta ");
      Serial.println(deltat);
      //if (deltat>100)
      //{
        Serial.println(state); // affiche 0 sur la console (serial monitor) si l'interrupteur est occulté,     sinon affiche 1
      //}
      isPrinted = true;
     }
     delay(20);
//     digitalWrite(ledPin, HIGH);
//     delay(1000);
//     digitalWrite(ledPin, LOW);
 
    
    
  //x=i;
  //delay(50);
}
void blink()
{
  state = !state;
  deltat = millis()-t; 
  t = millis();
  isPrinted = false;
}
