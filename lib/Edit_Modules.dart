import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Edit_Modules extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Edit_Modules_State();
  }
}

class Edit_Modules_State extends State<Edit_Modules> {

  final CollectionReference firestore_modules_collection = FirebaseFirestore.instance.collection('tblmodules');
  TextEditingController Course_ID= TextEditingController();
  TextEditingController Module_ID= TextEditingController();
  TextEditingController Module_Credits= TextEditingController();
  TextEditingController Module_Sem_Number= TextEditingController();
  bool course_exist = false;
  String Current_Document_ID;
  String Current_Module_Credits;
  String Current_Module_Sem;
  final _Form_Validation_Key = GlobalKey<FormState>();

  Search_Button(){
    Future.wait([
      Search_Result(Course_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      if (Current_Document_ID != null){
        Module_Credits.text = Current_Module_Credits;
        Module_Sem_Number.text = Current_Module_Sem;
      }else{
        return showDialog(context: context, builder: (context){
          Module_Credits.text = "";
          Module_Sem_Number.text = "";
          return AlertDialog(
            title: Text("Unable to find Module"),
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
      Search_Result(Course_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      print(Current_Document_ID);
      if (Current_Document_ID != null){
        FirebaseFirestore.instance.collection("tblmodules").doc(Current_Document_ID).delete().then((delete_data){
          return showDialog(context: context, builder: (context){
            Course_ID.text = "";
            Module_ID.text = "";
            Module_Credits.text = "";
            Module_Sem_Number.text = "";
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
        });



      }else {
        return showDialog(context: context, builder: (context){
          Module_Credits.text = "";
          Module_Sem_Number.text = "";
          return AlertDialog(
            title: Text("Unable to find Module"),
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


  Update_Button(){
    Future.wait([
      Search_Result(Course_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      if (Current_Document_ID != null){
        FirebaseFirestore.instance.collection('tblmodules').doc(Current_Document_ID).update(
            {
              "module_credits" : Module_Credits.text,
              "semester_number" : Module_Sem_Number.text,
            }).then((values){
          Current_Document_ID = null;
          return showDialog(context: context, builder: (context){
            Course_ID.text = "";
            Module_ID.text = "";
            Module_Credits.text = "";
            Module_Sem_Number.text = "";
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
        );


      }else{
        return showDialog(context: context, builder: (context){
          Module_Credits.text = "";
          Module_Sem_Number.text = "";
          return AlertDialog(
            title: Text("Unable to find Module"),
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

  Future <void> Search_Result(String course_id, String module_id) async{

    await firestore_modules_collection.where('course_id', isEqualTo: course_id).get().then((filtered_modules){
      Current_Document_ID = null;
      filtered_modules.docs.forEach((filtered_modules_i) {
        if (filtered_modules_i["module_id"] == module_id){
          Current_Module_Credits = filtered_modules_i["module_credits"];
          Current_Module_Sem = filtered_modules_i["semester_number"];
          Current_Document_ID = filtered_modules_i.id;
          return;
        }
      });
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Modify Module',
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
                      controller: Module_ID,
                      decoration: InputDecoration(
                          labelText: "Module ID",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 30),

                    TextFormField(
                      controller: Module_Credits,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: "Module Credits",
                          fillColor: Colors.amber[400], filled: true
                      ),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      controller: Module_Sem_Number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: "Module Semester Number",
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
                            Search_Button();
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
                        child: Text("Update"),
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          if (_Form_Validation_Key.currentState.validate()){
                            Update_Button();
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
                            Delete_Button();
                          }else{
                            print("Validation error");
                          }
                        },
                      ),

                    ),



                  ],
                ),
              ),

            )
        )
    );
  }

}