import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/dashboardview.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'model/user.dart';

void main() {
  runApp(
    MaterialApp(
      home:HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget{
  final UserModel usermodel=UserModel();
  final userController=TextEditingController();
  final passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
usermodel.PutSharedPref();
    return  ScopedModel<UserModel>(
      model:usermodel ,
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child,model)=>
        Scaffold(
       body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                 Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                       Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration( 
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    labelText: model.email,
                                    border: InputBorder.none
                                  ), 
                                  controller: userController,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                  controller: passwordController,
                                ),
                              ),
                            ],
                          ),
                        ),
                         SizedBox(height: 20,),
                        Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20,),
                         Container(
                             height: 50,
                             width: 120,
                           child: RaisedButton(
                            onPressed: ()async {
        
                              model.email=userController.text;
                              model.password=passwordController.text;
                              model.SharedPref();
                            //   Navigator.push(
                            //   context, new MaterialPageRoute(
                            //     builder: (context) => new SecondPage()
                            //     )
                            //   );
                          },
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ,fontSize: 18),),
                            ),
                        ),
                         ),
                        SizedBox(height: 20,),
                        Text("Continue with social media", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:  Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue
                                ),
                                child: Center(
                                  child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child:  Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black
                                ),
                                child: Center(
                                  child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                        ) ,
                     ),                  
                    ),     
                  ),
                )
          ]
        )

       )
           
    )
        
    )
        
    );
  
  }
}



