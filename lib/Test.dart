/*
import 'package:flutter/material.dart';
import 'package:test1/user_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State <StatefulWidget> createState() {
    return MyApp_State();
  }
}

class MyApp_State extends State<MyApp> {


  /////////Define Variables - Start



  //Define Variables - End

  /////////Define Functions - Start

  void login_process() {
    print('This is the login screen');
    //
  }

  //Define Functions - Start


  @override
  Widget build (BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
              backgroundColor: Colors.orange[400],
              appBar: AppBar(
                  title: Text(
                    'App Title D',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  backgroundColor: Colors.yellowAccent[400]
              ),
              body: Center(
                child: Column(
                  children: [
                    Text('Please enter your login credentials'),
                    RaisedButton(
                      child: Text("Login"),
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => user_page()),);},
                    ),
                    RaisedButton(
                      child: Text("Clear"),
                      onPressed: null,
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}


 */