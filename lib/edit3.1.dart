import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'donate3.dart';
import 'connectio/connect.dart';
class EditPage extends StatefulWidget {
  EditPage({Key? key,required this.names,required this.phnumber,required this.id}) : super(key: key);
  var names,phnumber,id;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var eee=TextEditingController();
  var eew=TextEditingController();

  Future<void> sendData() async {
    var data={
      'names':eee.text,
      'Phnumber':eew.text,
      'id':widget.id
    };
    var response=await post(Uri.parse('${con.url}editdnr.php'),body:data);
    print(response.body);
    print(response.statusCode);
    if(jsonDecode(response.body)['result']=='success'){
      // return jsonDecode(response.body);


      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Editted !..')));
        Navigator.pop(context);
      });
    }
  }
  @override
  void initState(){
    super.initState();


    eee.text=widget.names;
    eew.text=widget.phnumber;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [
          TextFormField(
            controller: eee,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('Name'),
            ),
          ), TextFormField(
            controller: eew,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Email'),
            ),
          ),
          OutlinedButton(
              onPressed: (){
                Navigator.pop(context);
                // if(eee.text.isNotEmpty && eew.text.isNotEmpty){
                //   sendData();
                //
                // }
                // else
                // {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields required...')));
                // }
              },
              child: Text('edit')
          )
        ],
      ),

    );
  }
}