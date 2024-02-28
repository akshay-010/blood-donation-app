import 'dart:convert';

import 'package:blooddonation/donate3.dart';
import 'package:blooddonation/donatesignup2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'connectio/connect.dart';
class aaa extends StatefulWidget {
  const aaa({super.key});

  @override
  State<aaa> createState() => _aaaState();
}

class _aaaState extends State<aaa> {
  var kk=TextEditingController();
  var ad=TextEditingController();

  Future<void>sendData() async {
    var dataa = {
      'Username': kk.text,
      'Password': ad.text,
    };
    print('dataa');
    var response = await post(Uri.parse('${con.url}login.php'), body: dataa);
    print(response.body);
    print(response.statusCode);
    var res = jsonDecode(response.body);
    if (res['result'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User added successfully"),));
      Navigator.pop(context);
    }
     else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add user..."),));
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
              Text("LOGIN IN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(right: 191),
                child: Text("Enter User Username",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.8),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42,right: 42),
                child: TextField(
                  controller: kk,
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
                padding: const EdgeInsets.only(right: 226),
                child: Text("Enter Pssword",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.8),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42,right: 42),
                child: TextField(
                  controller: ad,
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
              InkWell(onTap: (){
                if(kk.text.isNotEmpty&&ad.text.isNotEmpty){
                  sendData();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>yyy()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields required")));
                }
              },
                // onTap: (){
                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>yyy()));
                // },

                child: Container(
                  height: 44,
                  width: 309,
                  decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.4)),
                  child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: Colors.black),),

                  TextButton(onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>etu()));},child: Text("Signup",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
