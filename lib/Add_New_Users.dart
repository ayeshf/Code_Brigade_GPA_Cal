import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Add_New_Users extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Add_New_Users_State();
  }
}

class Add_New_Users_State extends State<Add_New_Users> {

  final CollectionReference firestore_courses_collection = FirebaseFirestore.instance.collection('tblcourses');
  TextEditingController User_Email= TextEditingController();
  TextEditingController User_ID= TextEditingController();
  TextEditingController User_FName = TextEditingController();
  TextEditingController User_LName = TextEditingController();
  String User_Gender;
  TextEditingController User_Mobile= TextEditingController();
  TextEditingController User_Course_ID= TextEditingController();
  String User_Type;



  bool course_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();


  /*Future <void> Add_New_Course(String course_id, String no_of_semester, String no_of_credits) async{

    await firestore_courses_collection.where('course_id', isEqualTo: course_id).get().then((filtered_courses){
      course_exist = false;
      filtered_courses.docs.forEach((filtered_courses_i) {
        print("Inside filtered_courses_i");
        course_exist = true;
        return;
      });
    });

    if (course_exist == false){
      Course_ID.text = "";
      Number_of_semesters.text = "";
      total_no_of_credits.text = "";
      return await firestore_courses_collection.doc().set({
        'course_id' : course_id,
        'no_of_semesters' : no_of_semester,
        'total_credits' : no_of_credits,
      });
    }

  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Add New User',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),

        body: SingleChildScrollView(
          child: Form(
            key: _Form_Validation_Key,
            child: Container(
              margin:EdgeInsets.all(50),
              child: Column(
                children: [

                  SizedBox(height: 10),

                  DropdownButtonFormField(
                    value: 'Student',
                    validator: (validator_input) {
                      if(validator_input == null || validator_input.isEmpty){
                        return 'This field is mandatory';
                      }
                      return null;
                    },

                    items: <String>['Student', 'Administrator'].map<DropdownMenuItem<String>>((User_Type){
                      return DropdownMenuItem<String>(
                        value: User_Type,
                        child: Text(User_Type),
                      );
                    }).toList(),

                    onChanged: (String Changed_Value) {
                      setState((){
                        User_Type = Changed_Value;
                      });
                    },

                    //controller: User_Gender,
                    decoration: InputDecoration(
                        labelText: "Account Type",
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
                    controller: User_Email,
                    decoration: InputDecoration(
                        labelText: "Email Address",
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
                    controller: User_ID,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText: "User ID",
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
                    controller: User_FName,
                    decoration: InputDecoration(
                        labelText: "First Name",
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
                    controller: User_LName,
                    decoration: InputDecoration(
                        labelText: "Last Name",
                        fillColor: Colors.amber[400], filled: true
                    ),
                  ),

                  SizedBox(height: 10),

                  DropdownButtonFormField(
                    validator: (validator_input) {
                      if(validator_input == null || validator_input.isEmpty){
                        return 'This field is mandatory';
                      }
                      return null;
                    },

                    items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((User_Gender){
                      return DropdownMenuItem<String>(
                          value: User_Gender,
                          child: Text(User_Gender),
                      );
                    }).toList(),

                    onChanged: (String Changed_Value) {
                      setState((){
                        User_Gender = Changed_Value;
                      });
                    },

                    //controller: User_Gender,
                    decoration: InputDecoration(
                        labelText: "Gender",
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
                    controller: User_Mobile,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText: "Mobile Number",
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
                    controller: User_Course_ID,
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
                    controller: User_Email,
                    decoration: InputDecoration(
                        labelText: "Set Password",
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
                      onPressed: () {/*
                        if (_Form_Validation_Key.currentState.validate()){
                          Future.wait([
                            Add_New_Course(Course_ID.text, Number_of_semesters.text, total_no_of_credits.text),
                          ]).then((List <dynamic> future_value){
                            if (course_exist == true){
                              //course_exist = false;
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

                        }*/
                      },
                      child: Text("Create Account"),

                    ),

                  )

                ],
              ),
            ),

          )
      )
    );
  }

}