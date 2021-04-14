import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Edit_Delete_Courses extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Edit_Delete_Courses_State();
  }
}

class Edit_Delete_Courses_State extends State<Edit_Delete_Courses> {

  final CollectionReference firestore_courses_collection = FirebaseFirestore.instance.collection('tblcourses');
  TextEditingController Course_ID = TextEditingController();
  TextEditingController Number_of_semesters = TextEditingController();
  bool course_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();
  String Current_No_of_Semesters;

  Search_Button(){
    Future.wait([
      Search_New_Course(Course_ID.text),
    ]).then((List <dynamic> future_value){
      if (course_exist == true){
        course_exist = false;
        Number_of_semesters.text = Current_No_of_Semesters;
      }else{
        return showDialog(context: context, builder: (context){
          Number_of_semesters.text = "";
          return AlertDialog(
            title: Text("Unable to find such course"),
            actions: [
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
      }
    });
  }

  Delete_Button() async{
    Future.wait([
      Search_New_Course(Course_ID.text),
    ]).then((List <dynamic> future_value){
      if (course_exist == true){
        course_exist = false;
        FirebaseFirestore.instance.collection("tblcourses").where('course_id', isEqualTo: Course_ID.text).get().then((queried_data){
          queried_data.docs.forEach((queried_data_i) {
            FirebaseFirestore.instance.collection("tblcourses").doc(queried_data_i.id).delete().then((delete_data){
              return showDialog(context: context, builder: (context){
                Number_of_semesters.text = "";
                return AlertDialog(
                  title: Text("Record Deleted"),
                  actions: [
                    RaisedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"),
                    )
                  ],
                );
              });
            }

            );
          });
        });


      }else {
        return showDialog(context: context, builder: (context){
          Number_of_semesters.text = "";
          return AlertDialog(
            title: Text("Unable to find such course"),
            actions: [
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
      }
    });
  }


  Future <void> Search_New_Course(String course_id) async{

    await firestore_courses_collection.where('course_id', isEqualTo: course_id).get().then((filtered_courses){
      filtered_courses.docs.forEach((filtered_courses_i) {
        Current_No_of_Semesters = filtered_courses_i["no_of_semesters"];
        course_exist = true;
        return;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Modify Course',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),

        body: Form(
          key: _Form_Validation_Key,
          child: Container(
            margin:EdgeInsets.all(50),
            child: Column(
              children: [

                SizedBox(height: 10),

                TextFormField(
                  controller: Course_ID,
                  validator: (validator_input) {
                    if(validator_input == null || validator_input.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Course ID",
                      fillColor: Colors.amber[400], filled: true
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: Number_of_semesters,
                  enabled: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      labelText: "Number of semesters",
                      fillColor: Colors.amber[400], filled: true
                  ),
                ),

                SizedBox(height: 10),

                ButtonTheme(
                  height: 40.0,
                  minWidth: 2000.00,
                  child: RaisedButton(
                    color: Colors.yellowAccent[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    onPressed: () {
                      if (_Form_Validation_Key.currentState.validate()){
                        Search_Button();
                      }else{
                        print("Validation error");
                      }
                    },
                    child: Text("Search"),
                  ),

                ),

                SizedBox(height: 10),

                ButtonTheme(
                  height: 40.0,
                  minWidth: 2000.00,
                  child: RaisedButton(
                    color: Colors.yellowAccent[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    onPressed: () {
                      if (_Form_Validation_Key.currentState.validate()){
                        Delete_Button();
                      }else{
                        print("Validation error");
                      }
                    },
                    child: Text("Delete Record"),
                  ),

                )




              ],
            ),
          ),

        )
    );
  }

}