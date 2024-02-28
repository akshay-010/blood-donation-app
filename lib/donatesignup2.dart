import 'dart:convert';
import 'connectio/connect.dart';
import 'package:blooddonation/donate3.dart';
import 'package:blooddonation/donate4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class etu extends StatefulWidget {
  const etu({super.key});

  @override
  State<etu> createState() => _etuState();
}

class _etuState extends State<etu> {
  var rto=TextEditingController();
  var wrr=TextEditingController();
  var wro=TextEditingController();

  Future<void>sendData() async{
    var dataa={
      'Username':rto.text,
      'Pnonenumber':wro.text,
      'Password':wrr.text,
    };
  print('dataa');
  var response=await post(Uri.parse('${con.url}signup.php'),body:dataa);
  print(response.body);
  print(response.statusCode);
  var res=jsonDecode(response.body);
  if(res['result']=='success'){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User added successfully"),));
  Navigator.pop(context);
  }
  else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add user..."),));

  }
  return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 240,),
              Text("SIGN UP",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(right: 191),
                child: Text("Enter User Username",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.8),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42,right: 42),
                child: TextField(
                  controller: rto,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:EdgeInsets.fromLTRB(4, 0, 0, 0.1) ,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.3)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),

                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 191),
                child: Text("Enter Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.8),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42,right: 42),
                child: TextField(
                  controller: wrr,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:EdgeInsets.fromLTRB(4, 0, 0, 0.1) ,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.3)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),

                      )
                  ),
                ),
              ),
                   SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 191),
                child: Text("Enter Phone Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.8),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42,right: 42),
                child: TextField(
                  controller: wro,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:EdgeInsets.fromLTRB(4, 0, 0, 0.1) ,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.3)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),

                      )
                  ),
                ),
              ),
              SizedBox(height: 70,),
              // InkWell(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>yyy()));},
               InkWell(onTap: (){
                 if(rto.text.isNotEmpty&&wro.text.isNotEmpty&&wrr.text.isNotEmpty){
                 sendData();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>yyy()));
                 }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields required")));
                 }
                 },

                child: Container(
                  height: 44,
                  width: 309,
                  decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.4)),
                  child: Center(child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(color: Colors.black),),
                  TextButton(onPressed: (){},child: Text("Signup",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
