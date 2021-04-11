import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/Student_Results.dart';

class Admin_Main_Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Admin_Main_Menu_State();
  }
}



class Admin_Main_Menu_State extends State<Admin_Main_Menu> {

  var first_time = 1;
  var current_student_id;
  var current_student_email;
  var current_student_fname;
  var current_student_lname;
  var current_student_mobile;
  var current_student_gender;

  final firestoreInstance = FirebaseFirestore.instance;
  /*void Button1function(){
    //print("Button 1 PressedA");
    print("Current user is " + globals.Global_Current_User);
    firestoreInstance.collection("tblstudents").where('student_email',isEqualTo:globals.Global_Current_User).get().then((queried_snapshot) {
      queried_snapshot.docs.forEach((queried_result) {
        //print(queried_result["student_id"]);
        setState((){
          print(queried_result);
          print(queried_result["student_email"]);
          current_student_id = queried_result["student_id"];
          current_student_email = queried_result["student_email"];
          current_student_fname = queried_result["student_fname"];
          current_student_lname = queried_result["student_lname"];
          current_student_mobile = queried_result["student_mobile"];
          current_student_gender = queried_result["student_gender"];
          globals.Global_Current_Course_ID = queried_result["course_id"];
          globals.Global_Current_User_Name = current_student_fname;
          globals.Global_Current_User_ID = current_student_id;

        });

        print ("my student id is " + current_student_id.toString());
      });
    });
  }*/


  @override
  Widget build(BuildContext context) {
    //Button1function();
    //current_student_id = 5;
    if (first_time == 1){
      //Button1function();
      first_time = 0;

    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Welcome  ' + globals.Global_Current_User_Name,
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(50),
            child: Column(
                children: [

                  Text(
                    "Welcome to Administration Console",
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 25,
                    ),
                  ),


                  SizedBox(height: 30),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Add new users"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Edit or delete user details"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Add student results"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Edit or delete results"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Add new modules"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Edit or delete modules"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Add new courses"),
                    ),
                  ),

                  SizedBox(height: 5),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){

                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Edit or delete courses"),
                    ),
                  ),


                  SizedBox(height: 10),

                  ButtonTheme(
                    minWidth:2000.00,
                    child:RaisedButton(
                      onPressed: (){
                        globals.Global_Current_User_Type = 0;
                        context.read<FBase_User_Login_Service>().signOut();
                      },

                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Sign Out"),
                    ),
                  ),


                ]
            )
        )

    );
  }
}
