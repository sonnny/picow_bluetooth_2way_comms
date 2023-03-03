//
// flutter pub add get
// flutter pub add flutter_reactive_ble
// edit android/app/build.gradle (line 50) to change minSkdVersion to 21
// android settings, app, give location permission for ble to work

// filename: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './blecontroller.dart';

final TextStyle myStyle = TextStyle(fontSize:30,fontWeight:FontWeight.bold);

void main() => runApp(GetMaterialApp(home: Home()));

class Home extends StatelessWidget {
@override
Widget build(BuildContext context) {
final BleController ble = Get.put(BleController());
return Scaffold(
appBar: AppBar(title: const Text('pico w BLE 2 way comms')),
body: Center(child: Column(children:[

SizedBox(height: 50.0),

ElevatedButton(
onPressed: ble.connect,
child: Obx(() => Text('${ble.status.value}',
style:myStyle))),
          
SizedBox(height: 10.0),
          
ElevatedButton(
child: Text('toggle blue led',style:myStyle),
onPressed:()=>ble.sendData(0x74)),

SizedBox(height: 170.0),

Text('button status:',style:myStyle),
SizedBox(height:10.0),
Obx(()=>Text('${ble.buttonStatus.value}',style:TextStyle(fontSize:80.0,color:Colors.red,fontWeight:FontWeight.bold))),
 
])));}}
