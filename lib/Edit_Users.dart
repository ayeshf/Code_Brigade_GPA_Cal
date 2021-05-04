import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test1/User_Login_Service.dart';

class Edit_Users extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Edit_Users_State();
  }
}

class Edit_Users_State extends State<Edit_Users> {

  final CollectionReference firestore_students_collection = FirebaseFirestore.instance.collection('tblstudents');
  final CollectionReference firestore_admins_collection = FirebaseFirestore.instance.collection('tbladmins');
  TextEditingController User_Email= TextEditingController();
  TextEditingController User_ID= TextEditingController();
  TextEditingController User_FName = TextEditingController();
  TextEditingController User_LName = TextEditingController();
  String User_Gender;
  TextEditingController User_Mobile= TextEditingController();
  TextEditingController User_Course_ID= TextEditingController();
  TextEditingController User_Type= TextEditingController();
  bool user_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();
  final Gender_State = GlobalKey<FormFieldState>();
  String Current_Document_ID;
  String Current_User_ID;
  String Current_User_FName;
  String Current_User_LName;
  String Current_User_Mobile;
  String Current_User_Course_ID;
  String User_Category = "None";


  Search_Button(){
    User_Category = "None";
    Future.wait([
      Search_Student(User_Email.text),
      Search_Admin(User_Email.text),
    ]).then((List <dynamic> future_value) {
      //setState((){
      if (User_Category != "None") {
        User_ID.text = Current_User_ID;
        User_FName.text = Current_User_FName;
        User_LName.text = Current_User_LName;
        Gender_State.currentState.didChange(User_Gender);
        User_Mobile.text = Current_User_Mobile;
        User_Course_ID.text = Current_User_Course_ID;
        User_Type.text = User_Category;
        print("SB" + User_Category);
        if (User_Category == "Student"){
          User_Course_ID.text = Current_User_Course_ID;
        }else{
          User_Course_ID.text = "";
        }
      } else {
        User_Gender = "";
        Gender_State.currentState.didChange(User_Gender);
        return showDialog(context: context, builder: (context) {
          User_ID.text = "";
          User_FName.text = "";
          User_LName.text = "";
          User_Type.text = "";
          User_Mobile.text = "";
          User_Course_ID.text = "";
          return AlertDialog(
            title: Text("Unable to find such user"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
      }
    //});

    });
  }





  Future <void> Search_Student(String email) async{
    //Gender_State.currentState.didChange(User_Gender);
    await firestore_students_collection.where('student_email', isEqualTo: email).get().then((filtered_users){
      //Current_Document_ID = null;
      filtered_users.docs.forEach((filtered_users_i) {
        Current_Document_ID = filtered_users_i.id;
        Current_User_ID = filtered_users_i["student_id"].toString();
        Current_User_FName = filtered_users_i["student_fname"];
        Current_User_LName = filtered_users_i["student_lname"];
        User_Gender = filtered_users_i["student_gender"];
        Current_User_Mobile = filtered_users_i["student_mobile"].toString();
        Current_User_Course_ID = filtered_users_i["course_id"];
        User_Category = "Student";
        return;
      });
    });
  }

  Future <void> Search_Admin(String email) async{
    await firestore_admins_collection.where('admin_email', isEqualTo: email).get().then((filtered_users){
      //Current_Document_ID = null;
      filtered_users.docs.forEach((filtered_users_i) {
        Current_Document_ID = filtered_users_i.id;
        Current_User_ID = filtered_users_i["admin_id"].toString();
        Current_User_FName = filtered_users_i["admin_fname"];
        Current_User_LName = filtered_users_i["admin_lname"];
        User_Gender = filtered_users_i["admin_gender"];
        Current_User_Mobile = filtered_users_i["admin_mobile"].toString();
        User_Category = "Admin";
        return;
      });
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Edit User',
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


                    ButtonTheme(
                      height: 40.0,
                      minWidth: 2000.00,
                      child: RaisedButton(
                        child: Text("Search"),
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          if (_Form_Validation_Key.currentState.validate()){
                            Gender_State.currentState.didChange(User_Gender);
                            Search_Button();
                            print(User_Gender);
                            Gender_State.currentState.didChange(User_Gender);
                          }else{
                            print("Validation error");
                          }
                        },
                      ),
                    ),





                    SizedBox(height: 30),



                    TextFormField(
                      enabled: false,
                      controller: User_Type,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: "Account Type",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),


                    SizedBox(height: 10),

                    TextFormField(
                      controller: User_ID,
                      decoration: InputDecoration(
                          labelText: "User ID",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      controller: User_FName,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      controller: User_LName,
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 10),

                    DropdownButtonFormField(
                      items: <String>['','Male', 'Female'].map<DropdownMenuItem<String>>((User_Gender){
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

                      key: Gender_State,
                      decoration: InputDecoration(
                          labelText: "Gender",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
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



                    SizedBox(height: 10),

                    ButtonTheme(
                      height: 40.0,
                      minWidth: 2000.00,
                      child: RaisedButton(
                        child: Text("Update"),
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          String Temp_Gender = User_Gender;
                          print("Update Button Pressed");
                          print(User_Category);
                          Current_Document_ID = null;
                          if (_Form_Validation_Key.currentState.validate()){
                            User_Category = "None";
                            Future.wait([
                              Search_Student(User_Email.text),
                              Search_Admin(User_Email.text),
                            ]).then((List <dynamic> future_value) {
                              if (User_Category == "Student") {
                                print(User_Gender);

                                FirebaseFirestore.instance.collection('tblstudents').doc(Current_Document_ID).update(
                                {
                                  "student_email" : User_Email.text,
                                  "student_id" : User_ID.text,
                                  "student_fname" : User_FName.text,
                                  "student_lname" : User_LName.text,
                                  "student_gender" : Temp_Gender,
                                  "student_mobile" : User_Mobile.text,
                                  "course_id" : User_Course_ID.text,
                                });

                                return showDialog(context: context, builder: (context){
                                  User_ID.text = "";
                                  User_FName.text = "";
                                  User_LName.text = "";
                                  User_Type.text = "";
                                  User_Mobile.text = "";
                                  User_Course_ID.text = "";
                                  return AlertDialog(
                                    title: Text("Record Updated"),
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
                              else if (User_Category == "Admin") {
                                print(User_Category);

                                FirebaseFirestore.instance.collection('tbladmins') .doc(Current_Document_ID).update(
                                    {
                                      "admin_email": User_Email.text,
                                      "admin_id": User_ID.text,
                                      "admin_fname": User_FName.text,
                                      "admin_lname": User_LName.text,
                                      "admin_gender": Temp_Gender,
                                      "admin_mobile": User_Mobile.text,
                                    });

                                return showDialog(context: context, builder: (context){
                                  User_ID.text = "";
                                  User_FName.text = "";
                                  User_LName.text = "";
                                  User_Type.text = "";
                                  User_Mobile.text = "";
                                  User_Course_ID.text = "";
                                  return AlertDialog(
                                    title: Text("Record Updated"),
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

                              else if (User_Category == "None") {
                                User_Gender = "";
                                Gender_State.currentState.didChange(User_Gender);
                                return showDialog(context: context, builder: (context) {
                                  User_ID.text = "";
                                  User_FName.text = "";
                                  User_LName.text = "";
                                  User_Type.text = "";
                                  User_Mobile.text = "";
                                  User_Course_ID.text = "";


                                  return AlertDialog(
                                    title: Text("Unable to find such user"),
                                    actions: [
                                      RaisedButton(
                                        onPressed: () {
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
                        },
                      ),
                    ),

                    SizedBox(height: 10),

                    ButtonTheme(
                      height: 40.0,
                      minWidth: 2000.00,
                      child: RaisedButton(
                        child: Text("Delete Record"),
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          if (_Form_Validation_Key.currentState.validate()){
                            String Temp_Gender = User_Gender;
                            print("Delete Button Pressed");
                            print(User_Category);
                            Current_Document_ID = null;
                            if (_Form_Validation_Key.currentState.validate()){
                              User_Category = "None";
                              Future.wait([
                                Search_Student(User_Email.text),
                                Search_Admin(User_Email.text),
                              ]).then((List <dynamic> future_value) {
                                if (User_Category == "Student") {
                                  FirebaseFirestore.instance.collection("tblstudents").doc(Current_Document_ID).delete().then((delete_data){});
                                  return showDialog(context: context, builder: (context){
                                    User_ID.text = "";
                                    User_FName.text = "";
                                    User_LName.text = "";
                                    User_Type.text = "";
                                    User_Mobile.text = "";
                                    User_Course_ID.text = "";
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
                                else if (User_Category == "Admin") {
                                  print(User_Category);
                                  FirebaseFirestore.instance.collection("tbladmins").doc(Current_Document_ID).delete().then((delete_data){});
                                  return showDialog(context: context, builder: (context){
                                    User_ID.text = "";
                                    User_FName.text = "";
                                    User_LName.text = "";
                                    User_Type.text = "";
                                    User_Mobile.text = "";
                                    User_Course_ID.text = "";
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

                                else if (User_Category == "None") {
                                  User_Gender = "";
                                  Gender_State.currentState.didChange(User_Gender);
                                  return showDialog(context: context, builder: (context) {
                                    User_ID.text = "";
                                    User_FName.text = "";
                                    User_LName.text = "";
                                    User_Type.text = "";
                                    User_Mobile.text = "";
                                    User_Course_ID.text = "";


                                    return AlertDialog(
                                      title: Text("Unable to find such user"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () {
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

                          }else{
                            print("Validation error");
                          }
                        },
                      ),

                    ),



                    SizedBox(height: 10),



                  ],
                ),
              ),

            )
        )
    );
  }

}