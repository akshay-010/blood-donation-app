import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:blooddonation/donate3.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'connectio/connect.dart';
import 'package:http/http.dart' as http;
class hhh extends StatefulWidget {
  const hhh({super.key});

  @override
  State<hhh> createState() => _hhhState();
}

class _hhhState extends State<hhh> {
  var selectedaa;
  List bloodgroup=[
    'A+',
    'O+',
    'b+',
    'B-',
    'OB+'

  ];
  var eee=TextEditingController();
  var eew=TextEditingController();
  File? _image;
  final picker=ImagePicker();

  Future ChoiceImage() async{
    final pickedImage=await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future sendData(File imageFile) async {
    print(eee.text);
    print(eew.text);
    print(selectedaa);

    var uri = Uri.parse("${con.url}submitdnr.php");

    var request = http.MultipartRequest("POST",uri);
    request.fields['names'] = eee.text;
    request.fields['Phnumber'] = eew.text;
    request.fields['bloodgroup'] = selectedaa;

    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("image uploaded");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Details added Successfully ...',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xfa8f7805),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Failed to add details...',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xfa8f7805),
      ));
      print("uploaded faild");
    }
  }



  
  // Future<void> sendData() async {
  //   var data={
  //     'names':eee.text,
  //     'Phnumber':eew.text,
  //     'bloodgroup':selectedaa,
  //   };
  //   print('data');
  //   var response=await post(Uri.parse('${con.url}submitdnr.php'),body:data);
  //   print(response.body);
  //   print(response.statusCode);
  //   var res=jsonDecode(response.body);
  //   if(res['result']=='success'){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User added successfully"),));
  //     Navigator.pop(context);
  //   }
  //   else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add user..."),));
  //
  //   }
  //   return res;
  // }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 157, 157, 1),
        title: Text("Donar App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21)),
      ),
           body: Container(
             height: double.infinity,width: double.infinity,
             child: SingleChildScrollView(
               child: Column(children: [
                 SizedBox(height: 30,),


                 _image == null?

                 CircleAvatar(
                   radius: 60,
                   child: IconButton(onPressed: () {
                     ChoiceImage();
                   }, icon: Icon(Icons.photo))
                 ):Container(height: 150,width:170,decoration: BoxDecoration(shape: BoxShape.circle),child: Image.file(_image!)),

                    SizedBox(height: 30,),
                 Padding(
                   padding: const EdgeInsets.only(left: 18,right: 18),
                   child: TextField(
                     controller: eee,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                         fillColor:Color.fromRGBO(253, 240, 240, 1) ,filled: true,
                     enabledBorder: OutlineInputBorder(),
                     focusedBorder: OutlineInputBorder(),
                       labelText: 'Enter Donor Name'
                   ),
                   ),
                 ),
                 SizedBox(height: 35,),
                 Padding(
                   padding: const EdgeInsets.only(left: 18,right: 18),
                   child: TextField(
                     controller: eew,
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       fillColor:Color.fromRGBO(253, 240, 240, 1) ,filled: true,
                       enabledBorder: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(),
                       labelText: 'Enter Phonenumber'
                   ),
                   ),
                 ),
                 SizedBox(height: 35,),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: DropdownButton(
                       elevation: 25,
                       value: selectedaa,
                       hint: Text('select Blood Group'),
                       items: bloodgroup
                           .map((e) => DropdownMenuItem(
                         child: Text(e),
                         value: e,
                       ))
                           .toList(),
                       onChanged: (val) {
                         setState(() {
                           selectedaa = val;
                         });
                       }),
                 ),


                 SizedBox(height: 80,),
                 InkWell(
                   onTap: (){
                     if(eee.text.isNotEmpty&&eew.text.isNotEmpty){
                       sendData(_image!);
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>yyy()));
                     }
                     else{
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields required")));
                     }
                     },
                   child: Container(
                     height: 50,width: 280,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(35),
                       color: Color.fromRGBO(220, 98, 98, 0.9)
                     ),child: Center(child: Text("Submit",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold,fontSize: 18),)),
                   ),
                 )

               ],),
             ),
           ),
    );
  }
}
