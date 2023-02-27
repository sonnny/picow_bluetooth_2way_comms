
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class BleController {
final frb = FlutterReactiveBle();
late StreamSubscription<ConnectionStateUpdate> c;
late QualifiedCharacteristic tx;
late QualifiedCharacteristic rx;
final devId = '28:CD:C1:00:EB:1E'; // use nrf connect from playstore to find
var status = 'connect to bluetooth'.obs;
var buttonStatus = '0'.obs;
List<int> packet = [0, 0];
  
void sendData(val) async{
packet[0]=val.toInt();
await frb.writeCharacteristicWithoutResponse(tx, value: packet);}    

void connect() async {
status.value = 'connecting...';
c = frb.connectToDevice(id: devId).listen((state) {
if (state.connectionState == DeviceConnectionState.connected) {
status.value = 'connected!';

tx = QualifiedCharacteristic(
serviceId: Uuid.parse("6e400001-b5a3-f393-e0a9-e50e24dcca9e"),
characteristicId: Uuid.parse("6e400002-b5a3-f393-e0a9-e50e24dcca9e"),
deviceId: devId);
         
rx = QualifiedCharacteristic(
serviceId: Uuid.parse("6e400001-b5a3-f393-e0a9-e50e24dcca9e"),            
characteristicId: Uuid.parse("6e400003-b5a3-f393-e0a9-e50e24dcca9e"), 
deviceId: devId); 

frb.subscribeToCharacteristic(rx).listen((data){
   String temp = utf8.decode(data);
   buttonStatus.value = temp;});         
}});}}
