import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/details_screen.dart';
import 'data_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Data> futureData;
  bool progress = false;

  @override
  void initState() {
    super.initState();

    fetchData();
    getUserInfo();
    //saveUserInfo();
  }

   Future <List<Data>> fetchData() async {
    var url = 'https://raw.githubusercontent.com/mwgg/Airports/master/airports.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
     var jsonResponse = dataFromJson(response.body);
     List<Data> dataList = jsonResponse.values.toList();
       print('response: ${jsonResponse.values.toList()[0].city}');
      futureData = jsonResponse.values.toList();
       if(futureData.length>0){
         String s = jsonEncode(futureData);
         final SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setString('local',response.body);
         setState(() {
           progress = true;
         });
       }
      return dataList;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future getUserInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var s = prefs.getString('local');
     futureData = dataFromJson(s).values.toList();
    print('s:${s}');
    if(s!=null){
      if(futureData.length>0){
        setState(() {
          progress=true;
        });
      }
    } else{
      print('call fetchdata');
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            title: Text('Airport'),
          ),
        body:
        progress?Center(
          child:Container(
              child:ListView.builder(
                itemCount: futureData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 0,
                              color: Colors.white,
                              child:
                              ListTile(
                                title: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(futureData[index].name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),),
                                      Text(futureData[index].icao, style: TextStyle(fontSize: 14, color: Colors.blue),),
                                    ],
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Center(child: Text('${futureData[index].city}, ',style: TextStyle(color: Colors.deepPurpleAccent),),
                                          ),),

                                        Container(
                                          child: Center(child: Text(futureData[index].state,style: TextStyle(color: Colors.deepPurpleAccent),),
                                          ),),
                                      ],
                                    ),

                                    Container(
                                      child: Center(child: Text(futureData[index].country,style: TextStyle(color: Colors.blueAccent),),
                                      ),),


                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey.shade200,
                                ),

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(detail: futureData[index]),
                                    ),
                                  );
                                },
                            ),
                            );
                          }

              ),


          ),
        ):Center(child: CircularProgressIndicator())
      ),
    );
  }
}
