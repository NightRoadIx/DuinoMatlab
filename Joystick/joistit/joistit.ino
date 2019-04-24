  /*
   * Leer los pines análogos de un joystick, que se supone están conectados
   * a dos potenciómetros, entonces la lectura es análoga de 10 bits [0,1023]
   */

/* DEFINICIÓN DE LAS VARIABLES  */
 int ledPin = 13;         // LED conectado al pin 13
 int joyPin1 = 0;         // Pin1 del jostick (eje x) conectado al AN0
 int joyPin2 = 1;         // Pin1 del jostick (eje y) conectado al AN1
 int value1 = 0;          // Variable para leer el valor del pin análogo 0 (AN0)
 int value2 = 0;          // Variable para leer el valor del pin análogo 1 (AN1)

/* CONFIGURACIÓN DEL ARDUINO */ 
 void setup() {
  pinMode(ledPin, OUTPUT);  // Inicia el pin13 como salida
  Serial.begin(9600);       // Configuración Serial, transmisión a 9600 baudios
 }

 void loop() {
  // reads the value of the variable resistor 
  value1 = analogRead(joyPin1);   
  // this small pause is needed between reading
  // analog pins, otherwise we get the same value twice
  delay(10);             
  // reads the value of the variable resistor 
  value2 = analogRead(joyPin2);   

  Serial.print(value1); Serial.print(' ');
  Serial.println(value2);
  delay(10);  
 }
