import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/Home_Page.dart';
import 'package:flutter/foundation.dart';

class Student_Results extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Student_Results_State();
  }
}



class Student_Results_State extends State<Student_Results> {

  var first_time = 1;
  var current_student_id;
  var current_student_email;
  var current_student_fname;
  var current_student_lname;
  var current_student_mobile;
  var current_student_gender;
  static var row = 6;
  static var col = 2;
  var s1_count = 0;
  var s2_count = 0;
  var s3_count = 0;
  var s4_count = 0;
  var s5_count = 0;
  var s6_count = 0;
  var s1_gpa = 0.0;
  var s2_gpa = 0.0;
  var s3_gpa = 0.0;
  var s4_gpa = 0.0;
  var s5_gpa = 0.0;
  var s6_gpa = 0.0;
  var s1_total_credits = 0;
  var s2_total_credits = 0;
  var s3_total_credits = 0;
  var s4_total_credits = 0;
  var s5_total_credits = 0;
  var s6_total_credits = 0;


  //static var sem_count = globals.Global_Current_Semester_Count;

  //globals.Global_ = 1;

  List<String> Results_List_s1 = ["Nothing"];
  List<String> Module_List_s1 = ["Nothing"];
  List<String> Results_List_s2 = ["Nothing"];
  List<String> Module_List_s2 = ["Nothing"];
  List<String> Results_List_s3 = ["Nothing"];
  List<String> Module_List_s3 = ["Nothing"];
  List<String> Results_List_s4 = ["Nothing"];
  List<String> Module_List_s4 = ["Nothing"];
  List<String> Results_List_s5 = ["Nothing"];
  List<String> Module_List_s5 = ["Nothing"];
  List<String> Results_List_s6 = ["Nothing"];
  List<String> Module_List_s6 = ["Nothing"];


  final firestoreInstance = FirebaseFirestore.instance;

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


  void FindResults(){
    //print("Course ID is " + globals.Global_Current_Course_ID);

    firestoreInstance.collection("tblcourses").where('course_id',isEqualTo:globals.Global_Current_Course_ID.toString()).get().then((queried_data) {
      queried_data.docs.forEach((queried_data_i) {
        setState((){
          globals.Global_Current_Semester_Count = int.parse(queried_data_i["no_of_semesters"]);
          //print("global semester count is " + globals.Global_Current_Semester_Count.toString());
        });
      });
    });
    //print(globals.Global_Current_Semester_Count);
      //print("First ifff");
      firestoreInstance.collection("tblresults").where('student_id',isEqualTo:globals.Global_Current_User_ID.toString()).get().then((queried_snapshot) {
        queried_snapshot.docs.forEach((queried_result) {
          setState((){

            firestoreInstance.collection("tblmodules").where('module_id',isEqualTo:queried_result["module_id"]).get().then((queried_module) {
              queried_module.docs.forEach((queried_module_value){
                if(queried_module_value["semester_number"] == "1"){
                  setState(() {
                    s1_gpa = s1_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s1_total_credits = s1_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s1.insert(s1_count, queried_result["module_id"]);
                    Results_List_s1.insert(s1_count, queried_result["module_result"]);
                    s1_count++;
                  });
                }
                if(queried_module_value["semester_number"] == "2"){
                  setState(() {
                    s2_gpa = s2_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s2_total_credits = s2_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s2.insert(s2_count, queried_result["module_id"]);
                    Results_List_s2.insert(s2_count, queried_result["module_result"]);
                    s2_count++;
                  });
                }
                if(queried_module_value["semester_number"] == "3"){
                  setState(() {
                    s3_gpa = s3_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s3_total_credits = s3_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s3.insert(s3_count, queried_result["module_id"]);
                    Results_List_s3.insert(s3_count, queried_result["module_result"]);
                    s3_count++;
                  });
                }
                if(queried_module_value["semester_number"] == "4"){
                  setState(() {
                    s4_gpa = s4_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s4_total_credits = s4_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s4.insert(s4_count, queried_result["module_id"]);
                    Results_List_s4.insert(s4_count, queried_result["module_result"]);
                    s4_count++;
                  });
                }
                if(queried_module_value["semester_number"] == "5"){
                  setState(() {
                    s5_gpa = s5_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s5_total_credits = s5_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s5.insert(s5_count, queried_result["module_id"]);
                    Results_List_s5.insert(s5_count, queried_result["module_result"]);
                    s5_count++;
                  });
                }
                if(queried_module_value["semester_number"] == "6"){
                  setState(() {
                    s6_gpa = s6_gpa + (Grade_To_GPA(queried_result["module_result"]) * int.parse(queried_module_value["module_credits"]));
                    s6_total_credits = s6_total_credits + int.parse(queried_module_value["module_credits"]);
                    Module_List_s6.insert(s6_count, queried_result["module_id"]);
                    Results_List_s6.insert(s6_count, queried_result["module_result"]);
                    s6_count++;
                  });
                }


              });
            });
          });
        });
      });
      Results_List_s1.removeLast();
      Module_List_s1.removeLast();
      Results_List_s2.removeLast();
      Module_List_s2.removeLast();


  }





  @override
  Widget build(BuildContext context) {
    //Button1function();
    //current_student_id = 5;
    print(Module_List_s1);
    print(Results_List_s1);
    if (first_time == 1) {
      first_time = 0;
      FindResults();
      //print(Module_List_s2[1]);
      //print(Results_List_s2[1]);
      //print("First time end");


    }
    if (globals.Global_Current_Semester_Count != null){
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

              child: ListView(
                  children: [
                    if (globals.Global_Current_Semester_Count >=
                        1) ExpansionTile(
                        title: Text(
                            'Semester 1', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s1_gpa / s1_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s1.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s1[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s1[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),
                    if (globals.Global_Current_Semester_Count >=
                        2) ExpansionTile(
                        title: Text(
                            'Semester 2', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s2_gpa / s2_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s2.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s2[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s2[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),

                    if (globals.Global_Current_Semester_Count >=
                        3) ExpansionTile(
                        title: Text(
                            'Semester 3', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s3_gpa / s3_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s3.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s3[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s3[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),

                    if (globals.Global_Current_Semester_Count >=
                        4) ExpansionTile(
                        title: Text(
                            'Semester 4', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s4_gpa / s4_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s4.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s4[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s4[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),

                    if (globals.Global_Current_Semester_Count >=
                        5) ExpansionTile(
                        title: Text(
                            'Semester 5', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s5_gpa / s5_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s5.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s5[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s5[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),

                    if (globals.Global_Current_Semester_Count >=
                        6) ExpansionTile(
                        title: Text(
                            'Semester 6', style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                            'GPA:  ' + (s6_gpa / s6_total_credits).toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 17)),
                        children: [
                          ListView.builder(
                            itemCount: Results_List_s6.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${Module_List_s6[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  '${Results_List_s6[index]}', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),),
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ]
                    ),


                  ]
              )
            /*RaisedButton(
                      color: Colors.yellowAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                      child: Text("Back"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                  ),*/


            //]
            //)
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
