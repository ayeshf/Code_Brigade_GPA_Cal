import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Global_Variables.dart' as globals;

class Add_Modules extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Add_Modules_State();
  }
}

class Add_Modules_State extends State<Add_Modules> {

  final CollectionReference firestore_module_collection = FirebaseFirestore.instance.collection('tblmodules');
  TextEditingController Course_ID= TextEditingController();
  TextEditingController Module_ID= TextEditingController();
  TextEditingController Module_Credits= TextEditingController();
  TextEditingController Module_Sem_Number= TextEditingController();
  bool module_exist = false;


  final _Form_Validation_Key = GlobalKey<FormState>();


  Future <void> Add_New_Module(String course_id, String module_id, String module_credits, String module_sem_number) async{
    print("Inside Add_New_Module Function");
    print(module_exist);
    print(course_id);
    print(module_id);
    print(module_credits);
    print(module_sem_number);


    await firestore_module_collection.where('course_id', isEqualTo: course_id).get().then((filtered_modules){
      module_exist = false;
      filtered_modules.docs.forEach((filtered_modules_i) {
        setState(() {
          if (filtered_modules_i["module_id"] == module_id){
            module_exist = true;
            print("filtered_modules_i is" + filtered_modules_i["module_id"]);
            return;
          }

        });
      });
    });

    if (module_exist == false){

      print("module adding part running");
      Course_ID.text = "";
      Module_ID.text = "";
      Module_Credits.text = "";
      Module_Sem_Number.text = "";
      return await firestore_module_collection.doc().set({
        'course_id' : course_id,
        'module_id' : module_id,
        'module_credits' : module_credits,
        'semester_number' : module_sem_number,
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
            'Add Module',
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

                    SizedBox(height: 10),

                    TextFormField(
                      validator: (validator_input) {
                        if(validator_input == null || validator_input.isEmpty){
                          return 'This field is mandatory';
                        }
                        return null;
                      },
                      controller: Module_Credits,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: "Module Credits",
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
                        color: Colors.yellowAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        onPressed: () {
                          print("Add Module button Pressed");
                          if (_Form_Validation_Key.currentState.validate()){
                            Future.wait([
                              Add_New_Module(Course_ID.text, Module_ID.text, Module_Credits.text, Module_Sem_Number.text),
                            ]).then((List <dynamic> future_value){
                              if (module_exist == true){
                                //course_exist = false;
                                return showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Module ID Already Exist"),
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
                                    title: Text("Module Added Successfully"),
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
                        child: Text("Add Module"),

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