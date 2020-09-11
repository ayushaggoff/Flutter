import 'package:flutter/material.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';

import '../../locator.dart';



class ChangePasswordView extends StatefulWidget {
    final UserModel currentUser;

    ChangePasswordView({this.currentUser});

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<ChangePasswordView> {

var _displayNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    _displayNameController.text = widget.currentUser.displayName;
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
   
    
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password",
          style: TextStyle(color:Colors.white,),
          )
          ),
        body:Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors:[
                  Colors.blue[300],
                  Colors.blue[600],
                  Colors.blue[300]
                ]
              ),
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text('Password',
               style: TextStyle(
                  color: Colors.white,
                   fontSize: 34,
               ),
               ),
                ),
               
               
                     Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
        width: 0, color: Colors.white),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60),)   
                        ),
                       
              ),
                    
                
            

/////////////////////pppppppppppppppppppppreeeeeeeeeeeeeeecvvvvvvvvvvvvvvvvvvvvv
                    Expanded(
                      
                        child: Container( 
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                                   Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                       
    Card(
      
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)) ),
      shadowColor:Colors.blue,
        elevation: 10,
        color: Colors.white,   
                                
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
      
                                              children: [
                                                //
                                                            Flexible(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Change Password",
                      
                      style: TextStyle(color: Colors.blue,fontSize: 24,),
                    //  Theme.of(context).textTheme.display1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: checkCurrentPasswordValid
                            ? null
                            : "Please double check your current password",
                      ),
                      controller: _passwordController,
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: "New Password"),
                      controller: _newPasswordController,
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Repeat Password",
                      ),
                      obscureText: true,
                      controller: _repeatPasswordController,
                      validator: (value) {
                        return _newPasswordController.text == value
                            ? null
                            : "Please validate your entered password";
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(

              onPressed: () async {
                var userController = locator.get<UserController>();

                if (widget.currentUser.displayName !=
                    _displayNameController.text) {
                  var displayName = _displayNameController.text;
                  userController.updateDisplayName(displayName);
                }

                checkCurrentPasswordValid =
                    await userController.validateCurrentPassword(
                        _passwordController.text);

                setState(() {});

                if (_formKey.currentState.validate() &&
                    checkCurrentPasswordValid) {
                  userController.updateUserPassword(
                      _newPasswordController.text);
                  Navigator.pop(context);
                }
              },
        

              color: Colors.blue[300],
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text("Change Password", style: TextStyle(color: Colors.white,fontSize: 16.0, fontWeight: FontWeight.bold ),),
                              ),
                              ),

                                                //
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                      
                ]  ),
                          ),
                        ),
                      ),
                    
         

//
               ] ), 
        
      )
       )   );
  }
}