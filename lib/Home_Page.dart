import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/Student_Results.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return HomePageState();
  }
}



class HomePageState extends State<HomePage> {

  var first_time = 1;
  var current_student_id;
  var current_student_email;
  var current_student_fname;
  var current_student_lname;
  var current_student_mobile;
  var current_student_gender;

  final firestoreInstance = FirebaseFirestore.instance;
  void Button1function(){
    print("Current user is " + globals.Global_Current_User);
    firestoreInstance.collection("tblstudents").where('student_email',isEqualTo:globals.Global_Current_User).get().then((queried_snapshot) {
      queried_snapshot.docs.forEach((queried_result) {
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

  }


  @override
  Widget build(BuildContext context) {
    //Button1function();
    //current_student_id = 5;
    if (first_time == 1){
      Button1function();
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
                    ExpansionTile(
                      title: Text('Student Details'),
                      initiallyExpanded: true,
                      children: [
                        ListTile(
                          //leading: Text('Leading '),
                          title: Text('Student ID'),
                          subtitle: Text(current_student_id.toString()),
                          //dense: true,
                          //selected: true,
                        ),
                        ListTile(
                          //leading: Text('Leading '),
                          title: Text('Student Email'),
                          subtitle: Text(current_student_email.toString()),

                          //dense: true,
                          //selected: true,
                        ),
                        ListTile(
                          //leading: Text('Leading '),
                          title: Text('Student Name'),
                          subtitle: Text(
                              current_student_fname.toString() + " " +
                                  current_student_lname.toString()),
                          //dense: true,
                          //selected: true,
                        ),
                        ListTile(
                          //leading: Text('Leading '),
                          title: Text('Mobile Phone'),
                          subtitle: Text(current_student_mobile.toString()),
                          //dense: true,
                          //selected: true,
                        ),
                        ListTile(
                          //leading: Text('Leading '),
                          title: Text('Gender'),
                          subtitle: Text(current_student_gender.toString()),
                          //dense: true,
                          //selected: true,
                        ),


                      ],

                    ),
                    RaisedButton(
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("View Results"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Student_Results()),
                          );
                        }
                    ),
                    RaisedButton(
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Ask Question"),

                        onPressed: () {
                          Button1function();
                        }
                    ),
                    RaisedButton(
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),),
                        child: Text("Sign out"),
                        onPressed: () {
                          globals.Global_Current_User_Type = 0;
                          globals.Global_Current_User_Name = null;
                          context.read<FBase_User_Login_Service>().signOut();
                        }
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
