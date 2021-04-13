import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/Add_New_Courses.dart';

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


  void Admin_Page_init(){
    firestoreInstance.collection("tbladmins").where('admin_email',isEqualTo:globals.Global_Current_User).get().then((queried_data) {
      queried_data.docs.forEach((queried_data_i) {
        //print(queried_result["student_id"]);
        setState(() {
          print(queried_data_i["admin_email"]);
          globals.Global_Current_User_Name = queried_data_i["admin_fname"];
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    //Button1function();
    //current_student_id = 5;
    if (first_time == 1){
      Admin_Page_init();
      first_time = 0;

    }
    if (globals.Global_Current_User_Name != null) {
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
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Add new users"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Edit or delete user details"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Add student results"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Edit or delete results"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Add new modules"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Edit or delete modules"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Add_New_Courses()),
                          );
                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Add new courses"),
                      ),
                    ),

                    SizedBox(height: 5),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {

                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Edit or delete courses"),
                      ),
                    ),


                    SizedBox(height: 10),

                    ButtonTheme(
                      minWidth: 2000.00,
                      child: RaisedButton(
                        onPressed: () {
                          globals.Global_Current_User_Type = 0;
                          globals.Global_Current_User_Name = null;
                          context.read<FBase_User_Login_Service>().signOut();
                        },

                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Sign Out"),
                      ),
                    ),


                  ]
              )
          )

      );
    }else{
      return Scaffold(
        body: Center(
          child:CircularProgressIndicator(
            backgroundColor: Colors.grey,
          ),
        ),
      );
    }
  }
}
