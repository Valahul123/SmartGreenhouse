#include <SPI.h>
#include <Ethernet.h>
#include <Servo.h>
#include <ctype.h>
int MOTOR1_PIN1 = 6;
int MOTOR1_PIN2 = 9;

int var[6] = {0, 0, 0, 0, 0, 0};
int d = 0;
int stropit = 0;
int aerisit = 0;
int lMin = 220, tempMax = 50, umaMin = 0, umsMin = 80, durata = 0;
Servo myservo;
Servo myservo2;  
int pos = 10;
int lmax=0;
int locatie;
int lumina=1;
int stanga=1;
int dreapta=1;
int var1,var2;
int start=1;
int intuneric=0;
int nr=0;
int val=0;
unsigned long previousTimer1=0;
unsigned long previousTimer2=0;
unsigned long previousTimer3=0;
unsigned long previousTimer4=0;
const long interval = 30000 ;
const long interval2 = 60000 ;
const long interval3 = 30000 ;
const long interval4 = 60000 ;

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);

EthernetServer server(80);


float readTempInCelsius(int count, int pin) {
  float temperaturaMediata = 0;
  float sumaTemperatura = 0;
  for (int i =0; i < count; i++) {
    int reading = analogRead(pin);
    float voltage = reading * 5.0;
    voltage /= 1024.0;
    float temperatureCelsius = (voltage - 0.5) * 100 ;
    sumaTemperatura = sumaTemperatura + temperatureCelsius;
  }
  return sumaTemperatura / (float)count;
} 

void setup() {
  Serial.begin(9600);
 
  
  Ethernet.begin(mac, ip);
  server.begin();
  
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
  pinMode(MOTOR1_PIN1, OUTPUT);
  pinMode(MOTOR1_PIN2, OUTPUT);
  myservo.attach(14);
  myservo2.attach(19);
  myservo.write(10);
  lmax = analogRead(A4)/ 4;
  for(pos = 10; pos < 170; pos += 1)  
  {                                  
    myservo2.write(pos);              
    delay(100);
    Serial.println(analogRead(A4)/4);
    if(lmax < analogRead(A4)/ 4){
      lmax = analogRead(A4)/ 4; 
      locatie=pos;
    }                   
  } 
  for(pos = 170; pos>=10; pos-=1)     
  {                                
    myservo2.write(pos);              
    delay(100);  
    Serial.println(analogRead(A4)/4);
    if(lmax < analogRead(A4)/ 4){
      lmax = analogRead(A4)/ 4; 
      locatie=pos;
    }                             
  } 
  myservo2.write(locatie);
  delay(2000);
}

int a = 0, b = 0, part, total , part2 , total2;
float percentage , percentage2;
void loop() {
  //cod pentru luminozitate ajustabila
  
  int l = analogRead(A2)/ 4;
  int lpanou = analogRead(A4)/ 4;
 /* Serial.println(lpanou);
  Serial.print(l);
  Serial.print("-");
  Serial.println(lMin);
 */ 
  if(l < lMin)
  {
    analogWrite(7, (lMin - l) % 255);
  
  }else
    digitalWrite(7, 0);
 
  
        if(lpanou <25){
         unsigned long currentTimer4 = millis();
        if(currentTimer4 - previousTimer4 >= interval4){
          previousTimer4 = currentTimer4;
          intuneric=1;
        }
        }
              if((intuneric==1) && (lpanou > 30)){
                delay(1000);
             for(pos = 10; pos < 170; pos += 1){                                  
                myservo2.write(pos);              
                delay(100);
                Serial.println(analogRead(A4)/4);
                 if(lmax < analogRead(A4)/ 4){
                 lmax = analogRead(A4)/ 4; 
                 locatie=pos;
                  }                   
              } 
            for(pos = 170; pos>=10; pos-=1){                                
                myservo2.write(pos);              
                delay(100);  
                Serial.println(analogRead(A4)/4);
                if(lmax < analogRead(A4)/ 4){
                     lmax = analogRead(A4)/ 4; 
                      locatie=pos;
                  }                             
            } 
             myservo2.write(locatie);
             dreapta=1;
             stanga=1;
             lumina=1;
             start=1;
             intuneric=0;
             delay(2000);
        }
          
         unsigned long currentTimer1 = millis();
        if(currentTimer1 - previousTimer1 >= interval ){
          previousTimer1 = currentTimer1;
         if(intuneric==0){
         if(dreapta==1){
          if(locatie+10 < 170){
          locatie=locatie+10;              
          myservo2.write(locatie); 
          if(start=1){
          delay(5000); 
          }            
          var1=analogRead(A4)/ 4;
          }else{
            var1=0;
            }
          }
        if(stanga==1){
          if(locatie-10 > 10){
          locatie=locatie-10;              
          myservo2.write(locatie);              
          var2=analogRead(A4)/ 4;
          }else{
            var2=0;
            }
          }

           if(lumina==1){
               if(var1>var2){
                  stanga=0;
               }else{
                  dreapta=0;
               }
               lumina=0;
           }
           
          

          
        }
       }
     
   

   
  
  
  int t = readTempInCelsius(10, 3);
  Serial.print(t);
  Serial.print("-");
  Serial.println(tempMax);
  if (val==t){
    nr++;
  }
  val = t;
  if(nr == 10){ 
  if((val > tempMax) && (aerisit==0)){
    aerisit=1;
    myservo.write(90);
  }
    nr=0;
  }

  
  if(aerisit==1){
  unsigned long currentTimer3 = millis();
        if(currentTimer3 - previousTimer3 >= interval3 ){
          previousTimer3 = currentTimer3;
           myservo.write(10);
           aerisit=0;
           delay(500);
        }
 
  }
  

  int u = analogRead(A1);
 if(u < umsMin && stropit == 0){
      Serial.println(stropit);
      analogWrite(MOTOR1_PIN1, 255);
      analogWrite(MOTOR1_PIN2, 100);
      delay(3000);
      analogWrite(MOTOR1_PIN1, 0);
      analogWrite(MOTOR1_PIN2, 0);
      stropit = 1;
      Serial.println("STOP");        
 }
 if(stropit==1){
     unsigned long currentTimer2 = millis();
        if(currentTimer2 - previousTimer2 >= interval2 ){
          previousTimer2 = currentTimer2;
          stropit=0;
        }
 }
 
  EthernetClient client = server.available();
  if (client) {
    int i = 0;
    Serial.println("new client");
   
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        Serial.write(c);
        // aici iei valoarea de la action intr-o variabila
        if (isdigit(c) && d == 1){
          int j = c - '0';
          var[i] = var[i] * 10 + j;
        }
        if (!(isdigit(c)) && d == 1){
          i++;
          d = 0;
        }
        if (b == 1 && isdigit(c)){
          var[i] = c - '0';
          a = 0;
          b = 0;
          d = 1;
          
        }
        if (b == 1 && !(isdigit(c))){
          i++;
          b = 0;
        }
        if (c == '?' || c == '&'){
          a = 1;
        }
        if(a == 1 && c == '='){
          b = 1;
        }
        if (c == '\n' && currentLineIsBlank) {
          //AICI PUI CE Raspunde         
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/plain");
          client.println("Connection: close"); 
          client.println();
          for(i = 0; i < 6; i++){
            Serial.println(var[i]);
          }
          Serial.println();
          durata = var[1];
          lMin = var[2];
          tempMax = var[3];
          umaMin = var[4];
          umsMin = var[5];
          int uMin=umsMin;
          Serial.println(lMin);
          Serial.println(tempMax);
          Serial.println(umaMin);
          Serial.println(umsMin);
          switch(var[0]){
            case 0:
                analogWrite(MOTOR1_PIN1, 255);
                analogWrite(MOTOR1_PIN2, 100);
                delay(durata);
                analogWrite(MOTOR1_PIN1, 0);
                analogWrite(MOTOR1_PIN2, 0);
                
                client.println("done");
            	break;
            case 1:
                                   
                myservo.write(10);
                myservo.write(90);
                delay(durata);
                myservo.write(10);
		            client.println("done");


                break;
            case 2:
		            client.println("done");
                break;
            case 3:
                part = analogRead(A2);
                total = 1024;
                percentage = (float)part/total * 100.0;
                client.print(percentage);
                client.println('%');
            break;
            case 4:
                client.print(readTempInCelsius(10, 3));
               
            break;
            case 6:
                  part = analogRead(A1);
                  total = 880;
                  while(part > 880){
                    part--;
                  }
                  while(part < 0){
                    part++;
                  }
                  percentage = (float)part/total * 100.0;
                  client.print(percentage);
                  client.println('%');
            break;
            case 7:       
                 
                if(umsMin-20 > analogRead(A1)){
                    client.print("da");
                }
           
           break;
                  
           } 
 
          break;
        }
        if (c == '\n') {
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          currentLineIsBlank = false;
        }
      }
    }
    delay(1);
    client.stop();
    Serial.println("client disonnected");
  }
}

