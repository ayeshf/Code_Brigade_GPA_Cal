import 'package:firebase_auth/firebase_auth.dart';
import 'package:test1/Admin_Main_Menu.dart';
import 'package:test1/User_Login_Service.dart';
import 'package:test1/Home_Page.dart';
import 'package:test1/Login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Global_Variables.dart' as globals;

//comment 9.54pm
//comment by Nizaad at 4.21 pm

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //globals.Global_Current_User = 54;
  //globals.Global_Current_User_Type = 0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FBase_User_Login_Service>(
          create: (_) => FBase_User_Login_Service(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FBase_User_Login_Service>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Auth_Process(),
      ),
    );
  }
}


class Auth_Process extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return Auth_Process_State();
  }
}



class Auth_Process_State extends State<Auth_Process> {
  final firestoreInstance = FirebaseFirestore.instance;

  Future <bool>  Verify_Login_Type(User firebaseUser)  async{
    await firestoreInstance.collection("tblstudents").where('student_email', isEqualTo: firebaseUser.email.toString()).get().then((queried_student) {
      queried_student.docs.forEach((queried_student_i) {
        //print("Student query success");
        globals.Global_Current_User = firebaseUser.email;
        globals.Global_Current_User_Type = 1;
        return Future.value(true);
      });
    });
    await firestoreInstance.collection("tbladmins").where('admin_email', isEqualTo: firebaseUser.email.toString()).get().then((queried_admin) {
      queried_admin.docs.forEach((queried_admin_i) {
        //print("Student query success");
        globals.Global_Current_User = firebaseUser.email;
        globals.Global_Current_User_Type = 2;
        return Future.value(true);
      });
    });

    return Future.value(true);
    //return true;
  }




  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    print("Just before the future builder");

    return FutureBuilder(
      future: Verify_Login_Type(firebaseUser),
      builder: (context, snapshot){
        print("Inside future builder's builder");

        if(snapshot.hasData){
          print("Inside snapshot:has data");
          if (firebaseUser != null) {
            print("Login_Option");
            print(firebaseUser.email);
            globals.Global_Current_User = firebaseUser.email;


            if (globals.Global_Current_User_Type == 1){
              print("Loading User Home Page  : " + globals.Global_Current_User_Type.toString());
              return HomePage();
            }
            else if (globals.Global_Current_User_Type == 2){
              print("Loading User Home Page  : " + globals.Global_Current_User_Type.toString());
              return Admin_Main_Menu();
            }

          }
          return Login_Page();
        }else{
          print("Inside snapshot:No data");
          return Login_Page();
        }




      }
    );
    return Login_Page();

  }

}