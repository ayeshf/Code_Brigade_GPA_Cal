import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Add_Student_Results extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Add_Student_Results_State();
  }
}

class Add_Student_Results_State extends State<Add_Student_Results> {

  final CollectionReference firestore_results_collection = FirebaseFirestore.instance.collection('tblresults');
  TextEditingController Student_ID = TextEditingController();
  TextEditingController Module_ID = TextEditingController();
  TextEditingController Module_Result = TextEditingController();
  bool result_exist = false;
  final _Form_Validation_Key = GlobalKey<FormState>();

  Future <void> Add_New_Result(String student_id, String module_id, String module_result) async{
    print("Inside Add_New_Result Function");


    await firestore_results_collection.where('student_id', isEqualTo: student_id).get().then((filtered_results){
      result_exist = false;
      filtered_results.docs.forEach((filtered_results_i) {
        setState(() {
          if (filtered_results_i["module_id"] == module_id){
            result_exist = true;
            print("filtered_modules_i is" + filtered_results_i["module_id"]);
            return;
          }

        });
      });
    });

    if (result_exist == false){

      print("module adding part running");
      Student_ID.text = "";
      Module_ID.text = "";
      Module_Result.text = "";
      return await firestore_results_collection.doc().set({
        'student_id' : student_id,
        'module_id' : module_id,
        'module_result' : module_result,
      });
    }

  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[400],
          title: Text(
            'Add Results Recod',
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

                    SizedBox(height: 10),

                    TextFormField(
                      validator: (validator_input) {
                        if(validator_input == null || validator_input.isEmpty){
                          return 'This field is mandatory';
                        }
                        return null;
                      },
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
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          print("Add Result button Pressed");
                          if (_Form_Validation_Key.currentState.validate()){
                            Future.wait([
                              Add_New_Result(Student_ID.text, Module_ID.text, Module_Result.text),
                            ]).then((List <dynamic> future_value){
                              if (result_exist == true){
                                //course_exist = false;
                                return showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Result Entry Already Exist"),
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
                                    title: Text("Result Added Successfully"),
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
                        },
                        child: Text("Add Result Record"),

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