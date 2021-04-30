import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Edit_Student_Results extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Edit_Student_Results_State();
  }
}

class Edit_Student_Results_State extends State<Edit_Student_Results> {

  final CollectionReference firestore_results_collection = FirebaseFirestore.instance.collection('tblresults');
  TextEditingController Student_ID= TextEditingController();
  TextEditingController Module_ID= TextEditingController();
  TextEditingController Module_Result = TextEditingController();
  String Current_Document_ID;
  String Current_Result;

  bool course_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();


  Search_Button(){
    Future.wait([
      Search_Result(Student_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      if (Current_Document_ID != null){
        Module_Result.text = Current_Result;
      }else{
        return showDialog(context: context, builder: (context){
          Module_Result.text = "";
          return AlertDialog(
            title: Text("Unable to find Result Record"),
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
      Search_Result(Student_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      print(Current_Document_ID);
      if (Current_Document_ID != null){
        FirebaseFirestore.instance.collection("tblresults").doc(Current_Document_ID).delete().then((delete_data){
          return showDialog(context: context, builder: (context){
            Student_ID.text = "";
            Module_ID.text = "";
            Module_Result.text = "";
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
          Module_Result.text = "";
          return AlertDialog(
            title: Text("Unable to find Result Record"),
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
      Search_Result(Student_ID.text, Module_ID.text),
    ]).then((List <dynamic> future_value){
      if (Current_Document_ID != null){
        FirebaseFirestore.instance.collection('tblresults').doc(Current_Document_ID).update(
            {
              "module_result" : Module_Result.text,
            }).then((values){
          Current_Document_ID = null;
          return showDialog(context: context, builder: (context){
            Student_ID.text = "";
            Module_ID.text = "";
            Module_Result.text = "";
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
          Module_Result.text = "";
          return AlertDialog(
            title: Text("Unable to find Result Record"),
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

  Future <void> Search_Result(String student_id, String module_id) async{

    await firestore_results_collection.where('student_id', isEqualTo: student_id).get().then((filtered_results){
      Current_Document_ID = null;
      filtered_results.docs.forEach((filtered_results_i) {
        if (filtered_results_i["module_id"] == module_id){
          Current_Result = filtered_results_i["module_result"];
          Current_Document_ID = filtered_results_i.id;
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
            'Modify Results',
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
                      controller: Student_ID,
                      decoration: InputDecoration(
                          labelText: "Student ID",
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
                      controller: Module_Result,
                      decoration: InputDecoration(
                          labelText: "Module Result",
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