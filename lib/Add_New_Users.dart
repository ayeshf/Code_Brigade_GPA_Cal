import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;
import 'package:test1/User_Login_Service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Add_New_Users extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Add_New_Users_State();
  }
}

class Add_New_Users_State extends State<Add_New_Users> {

  final CollectionReference firestore_students_collection = FirebaseFirestore.instance.collection('tblstudents');
  final CollectionReference firestore_admin_collection = FirebaseFirestore.instance.collection('tbladmins');
  TextEditingController User_Email= TextEditingController();
  TextEditingController User_Password= TextEditingController();
  TextEditingController User_ID= TextEditingController();
  TextEditingController User_FName = TextEditingController();
  TextEditingController User_LName = TextEditingController();
  String User_Gender;
  TextEditingController User_Mobile= TextEditingController();
  TextEditingController User_Course_ID= TextEditingController();
  String User_Type = "Student";
  bool user_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();

  Future <void> Query_Student_DB(String user_email) async{
    await firestore_students_collection.where('student_email', isEqualTo: user_email).get().then((filtered_students){
      filtered_students.docs.forEach((filtered_students_i) {
        print("Inside filtered_students_i");
        user_exist = true;
        return;
      });
    });
  }

  Future <void> Query_Admin_DB(String user_email) async{
    await firestore_admin_collection.where('admin_email', isEqualTo: user_email).get().then((filtered_admins){
      filtered_admins.docs.forEach((filtered_admins_i) {
        print("Inside filtered_admins_i");
        user_exist = true;
        return;
      });
    });
  }

  Future <void> Add_New_Student(String user_email, String f_name, String l_name, String user_id, String gender, String user_mobile, String course_id) async{
    return await firestore_students_collection.doc().set({
      'student_email' : user_email,
      'student_fname' : f_name,
      'student_lname' : l_name,
      'student_id' : user_id,
      'student_gender' : gender,
      'student_mobile' : user_mobile,
      'course_id' : course_id,
    });
  }

  Future <void> Add_New_Admin(String user_email, String f_name, String l_name, String user_id, String gender, String user_mobile) async{
    return await firestore_admin_collection.doc().set({
      'admin_email' : user_email,
      'admin_fname' : f_name,
      'admin_lname' : l_name,
      'admin_id' : user_id,
      'admin_gender' : gender,
      'admin_mobile' : user_mobile,

    });
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                      if(!validator_input.contains("@")){
                        return 'Please enter your email address here';
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
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      if(validator_input.length < 6){
                        return 'There should be minimum 6 characters';
                      }
                      return null;
                    },
                    controller: User_Password,
                    obscureText: true,
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
                      onPressed: () {
                        if (_Form_Validation_Key.currentState.validate()) {
                          print("Create Account button Pressed");
                          user_exist = false;
                          Future.wait([
                            Query_Student_DB(User_Email.text),
                            Query_Admin_DB(User_Email.text),
                          ]).then((List <dynamic> future_value) {
                            if (user_exist == true) {
                              print("User Already Exist");
                              return showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text("User Already Exist"),
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
                            } else {
                              print("No Such User");
                              print("Type Selected =" + User_Type);
                              if (User_Type == "Student") {
                                Add_New_Student(User_Email.text, User_FName.text,User_LName.text, User_ID.text, User_Gender, User_Mobile.text, User_Course_ID.text);
                              }
                              if (User_Type == "Administrator") {
                                Add_New_Admin(User_Email.text, User_FName.text,User_LName.text, User_ID.text, User_Gender, User_Mobile.text);
                              }

                              Future.wait([
                                context.read<FBase_User_Login_Service>().signUp(
                                  email: User_Email.text.trim(),
                                  password: User_Password.text.trim(),
                                ),
                              ]).then((List <dynamic> future_value) {
                                print("Created the account");
                                User user2 = FirebaseAuth.instance.currentUser;
                                print(user2.uid);
                                Future.wait([
                                  context.read<FBase_User_Login_Service>()
                                      .signIn(
                                    email: globals.Global_Current_User.trim(),
                                    password: globals.Global_Current_Password
                                        .trim(),
                                  ),
                                ]).then((List <dynamic> future_value) {
                                  User user3 = FirebaseAuth.instance.currentUser;
                                  print(user3.uid);
                                  print("User Creation Completed");
                                  User_Email.text = "";
                                  User_FName.text = "";
                                  User_LName.text = "";
                                  User_ID.text = "";
                                  User_Mobile.text = "";
                                  User_Course_ID.text = "";
                                  return showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("User Created Successfully"),
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

                                });
                              });
                            }
                          });


                        }else{
                          print("Validation error");
                        }
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