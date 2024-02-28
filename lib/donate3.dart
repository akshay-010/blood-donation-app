import 'dart:convert';
import 'package:blooddonation/detailepage.dart';
import 'package:http/http.dart';
import 'package:blooddonation/donate4.dart';

import 'package:flutter/material.dart';
import 'connectio/connect.dart';
import 'edit3.1.dart';
import 'package:url_launcher/url_launcher.dart';

class yyy extends StatefulWidget {
  const yyy({super.key});

  @override
  State<yyy> createState() => _yyyState();
}

class _yyyState extends State<yyy> {
  var _text=TextEditingController();

  var uid;
  Future<dynamic> deleteData() async {
    var data={'id':uid};
    var response= await post(Uri.parse("${con.url}dnrdelete.php"),body:data);
    
    if(jsonDecode(response.body)[0]['result']=='success'){
      Navigator.pop(context);
      return jsonDecode(response.body);

    }else
    {
      const Center(
        child: CircularProgressIndicator(),
      );
    }

  }
  Future<dynamic>getdata() async{
    var response=await get(Uri.parse('${con.url}donarselect.php'));
    print(response.body);
    print(response.statusCode);
    return jsonDecode(response.body);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
               body: SizedBox(width: double.infinity,height: double.infinity,
               child: Column(
                 children: [
                   Stack(
                     children:[ Container(
                       width: 400,height: 125,color: Colors.white,
                       child: Column(children: [
                         Container(height: 93,width: 400,color: Color.fromRGBO(223, 157, 157, 1),child: Padding(
                           padding: const EdgeInsets.only(left: 20,top: 43),
                           child: Text("Donor App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),),
                         ),),
                         
                       ],),
                     ),
                     Positioned(top: 65,left: 310,child: CircleAvatar(backgroundColor: Color.fromRGBO(217, 215, 215,1),radius: 28,),),Padding(
                       padding: const EdgeInsets.only(top: 69,left: 314),
                       child: IconButton(onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>hhh()));},
                           icon: Icon(Icons.add,color: Colors.black,weight: 10.5,size: 28,)),
                     )]
                   ),
                   Expanded(
                     child: SizedBox(height: 2000,
                       child: Container(color: Colors.white,
                         child: FutureBuilder(
                           future: getdata(),
                           builder: (context, snapshot) {
                             if(snapshot.hasError)
                               print(snapshot.error);
                             if(!snapshot.hasData || snapshot.data.length==0){
                             return  Center (child: Text('No Data'),);
                             }
                             return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,index){
                               return Padding(
                                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 35),
                                 child: Card(
                                   elevation: 5,
                                   child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>raa(

                                       names: snapshot.data![index]['names'],
                                       phnumber: snapshot.data![index]['Phnumber'],
                                       id: snapshot.data![index]['id'],
                                   image:    snapshot.data![index]['image']

                                   )));},
                                     child: ListTile(
                                       contentPadding: EdgeInsets.fromLTRB(0, 3, 3, 5),
                                       leading: CircleAvatar(radius: 45,backgroundImage: NetworkImage('${con.url}/myimage/${snapshot.data![index]['image']}')),
                                       title: Text(snapshot.data![index]['names']),
                                       subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(snapshot.data![index]['Phnumber']),
                                           Text(snapshot.data![index]['bloodgroup']),

                                         ],
                                       ),
                                       trailing: Row(mainAxisSize: MainAxisSize.min,
                                         children: [
                                           IconButton(onPressed: () {
                                             Uri launchUri = Uri(scheme: 'tel', path: '7902210780');
                                             launchUrl(launchUri);
                                           }, icon:Icon(Icons.phone,color: Colors.green,)),
                                           IconButton(onPressed: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage(
                                                 names: snapshot.data![index]['names'],
                                                 phnumber: snapshot.data![index]['Phnumber'],
                                                 id: snapshot.data![index]['id']),

                                             ));
                                           },
    // return AlertDialog(title: Text("Edit"),content: TextField(controller: TextEditingController(),
    // onChanged: (_text){
    // _text=_text;
    // },),
    // actions: [
    // TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')
    // ),
    // TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ff()));}, child: Text("Update")
    // )
    // ],
    // );
    // });    showDialog(context: context, builder: (context){


                                           icon: Icon(Icons.edit,size: 22,))
                                       ,SizedBox(width: 0),
                                           IconButton(onPressed: (){
                                             showDialog(context: context, builder: (context){
                                               return AlertDialog(title: Text("Confirm Deletion"),content: Text("Are You Sure You Want To"),
                                               actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel"),),
                                               TextButton(onPressed: (){
                                                 uid=snapshot.data[index]['id'];
                                                 setState(() {
                                                   deleteData();
                                                 });
                                               }, child: Text("Delete"))],);
                                             });
                                           }, icon: Icon(Icons.delete,size: 22,)),

                                         ],
                                       ),
                                     ),
                                   ),

                                 ),
                               );
                             });
                           }
                         ),
                       ),
                     ),
                   )

                 ],
               ),

               ),
      
    );
  }
}
