import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/Student_Results.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
  var student_gpa;
  TextEditingController User_Question = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  void Send_Email(String message) async{
    final Email email = Email(
      body: message,
      subject: "Support Request from " + globals.Global_Current_User,
      recipients: ['tm.code.brigade@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }



  double Grade_To_GPA(String Grade){
    if(Grade == "A+"){return 4.0;}
    if(Grade == "A"){return 4.0;}
    if(Grade == "A-"){return 3.7;}
    if(Grade == "B+"){return 3.3;}
    if(Grade == "B"){return 3.0;}
    if(Grade == "B-"){return 2.7;}
    if(Grade == "C+"){return 2.3;}
    if(Grade == "C"){return 2.0;}
    if(Grade == "C-"){return 1.7;}
    if(Grade == "D+"){return 1.3;}
    if(Grade == "D"){return 1.0;}
    if(Grade == "E+"){return 0.0;}
  }

  void Calculate_GPA() async{
    var total_gpa = 0.0;
    var total_credits = 0.0;

    await firestoreInstance.collection("tblcourses").where('course_id',isEqualTo:globals.Global_Current_Course_ID.toString()).get().then((queried_data) {
      queried_data.docs.forEach((queried_data_i) {
        setState((){
          globals.Global_Current_Semester_Count = int.parse(queried_data_i["no_of_semesters"]);
          //print("global semester count is " + globals.Global_Current_Semester_Count.toString());
        });
      });
    });
    await firestoreInstance.collection("tblresults").where('student_id',isEqualTo:globals.Global_Current_User_ID.toString()).get().then((queried_result) {
      queried_result.docs.forEach((queried_result_i) {
        setState(() {
          firestoreInstance.collection("tblmodules").where('module_id', isEqualTo: queried_result_i["module_id"]).get().then((queried_module) {
            queried_module.docs.forEach((queried_module_i) {
              setState(() {
                total_gpa = total_gpa + (Grade_To_GPA(queried_result_i["module_result"]) * int.parse(queried_module_i["module_credits"]));
                total_credits = total_credits + int.parse(queried_module_i["module_credits"]);

                student_gpa = (total_gpa/total_credits);
                student_gpa = num.parse(student_gpa.toStringAsFixed(2));

                print("total gpa is ");
                print(total_gpa);
                print("total credit is ");
                print(total_credits);

              });
            });
          });
        });
      });
    });

        /*.then((value) {
      setState(() {
        student_gpa = (total_gpa/total_credits);
        print("student gpa at loop");
        print(student_gpa.toString());
      });
    });*/
  }


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
      Calculate_GPA();
      //print("student gpa is ");
      //print(student_gpa.toString());
      first_time = 0;

    }
    if (globals.Global_Current_User_Name != null) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.yellowAccent[400],
            title: Text(
              'Welcome  ' + globals.Global_Current_User_Name,
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          body: SingleChildScrollView(

              child: Container(
                margin: EdgeInsets.all(50),
                child: Column(
                    children: [
                      ExpansionTile(
                        maintainState: true,
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
                            title: Text('GPA'),
                            subtitle: Text(student_gpa.toString()),
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

                      ButtonTheme(
                        height: 40.0,
                        minWidth: 2000.0,
                        child: RaisedButton(
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
                      ),

                      ButtonTheme(
                        height: 40.0,
                        minWidth: 2000.0,
                        child:RaisedButton(
                          color: Colors.yellowAccent[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),),
                          child: Text("Ask Question"),

                          onPressed: () {
                            return showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: Text("Please enter the question and press Ok"),
                                content: TextField(
                                  controller: User_Question,

                                ),
                                actions: [
                                  RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: (){
                                      Send_Email(User_Question.text);
                                      User_Question.text = "";
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Cancel"),
                                    onPressed: (){
                                      User_Question.text = "";
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                          }
                        ),
                      ),

                      ButtonTheme(
                        height: 40.0,
                        minWidth: 2000.0,
                        child: RaisedButton(
                          color: Colors.yellowAccent[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),),
                          child: Text("Sign out"),
                          onPressed: () {
                            globals.Global_Current_User_Type = 0;
                            globals.Global_Current_User_Name = null;
                            first_time = 1;
                            context.read<FBase_User_Login_Service>().signOut();
                          }
                        ),
                      ),




                    ]
                )
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
