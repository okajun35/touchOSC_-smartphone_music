import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress sonicPiAddress;
float gyroX, gyroY, gyroZ;

void setup() {
  size(640, 360);
  oscP5 = new OscP5(this, 8000); // OSCメッセージをリッスンするポート
  sonicPiAddress = new NetAddress("127.0.0.1", 4560); // Sonic Piのアドレスとポート
  gyroX = gyroY = gyroZ = 0.0;
}

void draw() {
  background(gyroX * 255, gyroY * 255, gyroZ * 255);
}

void oscEvent(OscMessage theOscMessage) {
  char gyro = 'x';
  float gyro_val = 0.0;
  
  if (theOscMessage.checkAddrPattern("/gyro/x")) {
    gyroX = theOscMessage.get(0).floatValue();
    gyro_val = gyroX;
    gyro = 'x';
  } else if(theOscMessage.checkAddrPattern("/gyro/y")) {
    gyroY = theOscMessage.get(0).floatValue();
    gyro_val = gyroY;
    gyro = 'y';
  } else if(theOscMessage.checkAddrPattern("/gyro/z")) {
    gyroZ = theOscMessage.get(0).floatValue();
    gyro_val = gyroZ;
    gyro = 'z'; 
  }
  
  //sendToSonicPi(gyroX);   
  sendToSonicPi(gyro_val, gyro);
  // gyroYとgyroZについても同様に処理を追加
  
  
  // Processingはデフォルトだと1/60秒で動作しているのでセンサーも早い段階でまわるので音をとめる
  delay(500);
}


void sendToSonicPi(float val, char gyro) {
//void sendToSonicPi(float val) {

  String osc_message = "/play_note";
  
  switch(gyro) {
    case 'x': 
      println("x");
      osc_message = "/play_x";
      break;
    case 'y': 
      println("y");
      osc_message = "/play_y";
      break;
    case 'z': 
      println("y");
      osc_message = "/play_z";
      break;

    default:
      println("None");
      break;
  }
  
  // OscMessage msg = new OscMessage("/play_note");
  OscMessage msg = new OscMessage(osc_message);
  
  msg.add(val * 100); // ここでセンサーデータを基にノート値を計算
  oscP5.send(msg, sonicPiAddress);

  // OscMessage myMessage = new OscMessage("/play_this");
  // myMessage.add(65); // MIDIノート番号などのデータ
  // oscP5.send(myMessage, sonicPiAddress);
}
