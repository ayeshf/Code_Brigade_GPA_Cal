import 'package:test1/User_Login_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Global_Variables.dart' as globals;

class Login_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return Login_Page_State();
  }
}



class Login_Page_State extends State<Login_Page> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

      return MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.orange[400],
              appBar: AppBar(
                backgroundColor: Colors.yellowAccent[400],
                title: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.blueAccent),
                ),

              ),
              body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(50),
                    child: Column(
                      children: [

                        Image(
                          image: AssetImage('IIIImages/SLIIT_Logo.png'),
                          height: 95,
                          width: 95,
                        ),

                        SizedBox(height: 10),

                        Text('Welcome to MBAGC GPA recording system '),

                        SizedBox(height: 10),

                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              fillColor: Colors.amber[400], filled: true

                          ),
                        ),

                        SizedBox(height: 15),

                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.amber[400], filled: true
                          ),
                        ),

                        SizedBox(height: 15),

                        ButtonTheme(
                            height: 40.0,
                            minWidth: 200.0,

                            child: RaisedButton(
                              color: Colors.yellowAccent[400],


                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                //side: BorderSide(color: Colors.red)

                              ),
                              onPressed: () {
                                print("Login Button Pressed");

                                Future.wait([
                                  context.read<FBase_User_Login_Service>().signIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                ]).then((List <dynamic> future_value){
                                  print("Inside Future Wait");
                                  print(globals.Global_Login_Fail);
                                  if (globals.Global_Login_Fail == true){
                                    globals.Global_Login_Fail = false;
                                    return showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Text("Incorrect Username or Password"),
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


                                /*context.read<FBase_User_Login_Service>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );*/

                                print("After Presseeddddd");

                                print(globals.Global_Login_Fail);
                                //print(abc);
                                //globals.Global_Login_Fail = false;

                                /*return showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Incorrect Username or Password"),
                                    actions: [
                                      RaisedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok"),
                                      )
                                    ],
                                  );
                                });*/

                              },
                              child: Text("Sign in"),
                            )
                        )
                      ],
                    ),
              )
          ),
          )
      );
  }
}
