import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Add_New_Courses extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Add_New_Courses_State();
  }
}

class Add_New_Courses_State extends State<Add_New_Courses> {

  final CollectionReference firestore_courses_collection = FirebaseFirestore.instance.collection('tblcourses');
  TextEditingController Course_ID = TextEditingController();
  TextEditingController Number_of_semesters = TextEditingController();
  bool course_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();


  Future <void> Add_New_Course(String course_id, String no_of_semester) async{

     await firestore_courses_collection.where('course_id', isEqualTo: course_id).get().then((filtered_courses){
       filtered_courses.docs.forEach((filtered_courses_i) {
         print("Inside filtered_courses_i");
         course_exist = true;
         return;
       });
     });

     if (course_exist == false){
       return await firestore_courses_collection.doc().set({
        'course_id' : course_id,
        'no_of_semesters' : no_of_semester,
       });
     }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[400],
        title: Text(
          'Add New Course',
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

                validator: (validator_input) {
                  if(validator_input == null || validator_input.isEmpty){
                    return 'This field is mandatory';
                  }
                  return null;
                },
                controller: Course_ID,
                decoration: InputDecoration(
                    labelText: "Course ID",
                    fillColor: Colors.amber[400], filled: true
                ),
              ),

              SizedBox(height: 10),

              TextFormField(
                validator: (validator_input) {
                  if(validator_input == null || validator_input.isEmpty){
                    return 'This field is mandatory';
                  }
                  return null;
                },
                controller: Number_of_semesters,
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
                    Future.wait([
                      Add_New_Course(Course_ID.text, Number_of_semesters.text),
                    ]).then((List <dynamic> future_value){
                      if (course_exist == true){
                        course_exist = false;
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Course ID Already Exist"),
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
                      }else{
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Course Added Successfully"),
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


                }else{
                  print("Validation error");

                }
                //print(Number_of_semesters.text);








                //Add_New_Course(Course_ID.text, Number_of_semesters.text);
                //print("abc is ");
                //print(abc);


              },
              child: Text("Add Course"),

            ),

          )




            ],
          ),
      ),

    )
    );
  }

}