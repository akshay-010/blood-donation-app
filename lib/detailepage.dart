import 'package:blooddonation/connectio/connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'connectio/connect.dart';
import 'location/locatinss.dart';
import 'location/map.dart';
import 'package:get/get.dart';
import 'dart:io';

class raa extends StatefulWidget {
  raa({Key? key,required this.names,required this.phnumber,required this.id,required this.image}) : super(key: key);
  var names,phnumber,id,image;

  @override
  State<raa> createState() => _raaState();


}

class _raaState extends State<raa> {
  var myLatitude;
  var myLongitude;


  TextEditingController description = TextEditingController();
  String? mapLocation;
  String myLoc = '-- Tap the button below to get your location --';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      init: LocationController(),
      builder: (controller)
      { return Scaffold(
        body: Container(width: double.infinity,height: double.infinity,
        child: Column(children: [
          SizedBox(height: 20,),
          CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('${con.url}/myimage/${widget.image}',)),
          SizedBox(height: 30,),
       
          IconButton(onPressed: (){
            setState(() {
              controller.getCurrentLocation();
              // mapLocation.text= controller.currentLocation == null ? '--No Location Selected--' :
              // controller.currentLocation!;
              mapLocation = controller.currentLocation == null
                  ? myLoc
                  : controller.currentLocation!;
              myLoc = mapLocation!;
              myLatitude = controller.myLat;
              myLongitude = controller.myLong;
              print(myLatitude);
              print(myLongitude);
            });
          }, icon: Icon(Icons.location_on,size: 50,))
        ],),
        ),

      );}
    );
  }
}
