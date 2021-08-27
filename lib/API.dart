import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert' ; 
class apitrial extends StatefulWidget {
    @override
  _apitrialState createState() => _apitrialState();
}
class _apitrialState extends State<apitrial> {
  late String stringResponse ;
  late List listResponse ; 
  late Map mapResponse ; 
  late List listoffacts ;
  Future fetchdata() async{
    http.Response response ;
    response=await http.get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=2')) ;
    if(response.statusCode==200) {
      setState(() {
        mapResponse=json.decode(response.body) ;
        listoffacts=mapResponse["facts"] ; 
      });
    }
  }
  @override
  void initState() {
    fetchdata() ; 
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Learning API"),),

      body: mapResponse==null?Container():SingleChildScrollView(
        child: Column(
          children: [
            Text(mapResponse["category"].toString()),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder:(context,index){
              return Container(
                child: Column(
                  children: [
                    Image.network(listoffacts[index]["image_url"])
                  ],
                ),
              ) ; 
            },
            itemCount: listoffacts==null?0:listoffacts.length,
            )
          ],
        ),
      ),
      
    );
  }
}