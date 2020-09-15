import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/aboutusview.dart';
import 'package:tryLoginScreen/View/changePassword.dart';
import 'package:tryLoginScreen/View/galleryview.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:tryLoginScreen/View/portfolio.dart';
import 'package:tryLoginScreen/View/profile/avatar.dart';
import 'package:tryLoginScreen/View/setting.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';

import 'package:tryLoginScreen/view_controller/user_controller.dart';

import '../locator.dart';
import 'ProfilePage.dart';
import 'contactusview.dart';

import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  //static String route = "home";
 

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

      UserModel _currentUser = locator.get<UserController>().currentUser;
      String initals;

      @override
void initState() { 
  super.initState();
  locator.get<AuthRepo>().getUser();

}

//   StorageReference storageReference = FirebaseStorage.instance    
//        .ref()    
//        .child('');
// storageReference.getf
// void getDownloadUrl() async {
//      _currentUser.avatarUrl=_storage.ref().child("user/profile/$uid").getDownloadURL();
//  }

//_storageRepo.getUserProfileImage(currentUser.email)

String gender;


  @override
  Widget build(BuildContext context) {
    initals=(_currentUser.displayName).toUpperCase();
  initals=initals[0];
   // print('vvvvvvvvvvvvvvvvvv:'+_currentUser.avatarUrl);
     // _currentUser.avatarUrl =  getDownloadUrl();
  //  locator.get<StorageRepo>().getDownloadUrl;
      var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight ) / 2;
    final double itemWidth = size.width / 2;
        Firestore.instance.collection("users").document(_currentUser.email).get()
      .then((value){
        gender=value.data["gender"];
      });
    return  Scaffold(
        body: SafeArea(
      child: Column(children: [
     
        new Expanded(
            child: new Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: new Container(
               // margin: EdgeInsets.only(bottom:58),
                  // padding: EdgeInsets.only(bottom:58),
                   //  height: itemHeight,
                      child: GridView.count(
                   shrinkWrap: true,
        // childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      
                      //Center( 
                   
                        //child:
                         makeDashboardItem("Portfolio", 'images/icon_portfolio_custom.png',()async{
            
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => PortfolioView()));
              }),
             // ),
                    //  Center(child: 
                    makeDashboardItem("Gallery", 'images/icon_gallery2Bl.png',()async{
            
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => GalleryView()));
              })
              ,///),
                      //Center(child: 
                      makeDashboardItem("About Us", 'images/icon_aboutus_custom.png',()async{
            
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => AboutUsView()));
              }),
              //),
                  //    Center(   child: 
                  makeDashboardItem("Contact Us", 'images/icon_contact2Bl.png',()async{
            
                   Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => ContactUsView()));
              }),
                  //    ),
                    ],
                  ),
              ),
                ),
            ),
          ),
      ],
      )
        ),  
          appBar: AppBar(
            title: Text("Dashboard"),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(FontAwesome5.user),
            //     onPressed: () {
            //       Navigator.pushNamed(context, ProfileView.route);
            //     },
            //   )
            // ],
          ),
          drawer:Drawer(
  child: LayoutBuilder(
    builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            DrawerHeader(
              
              decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Colors.blue[300],
                  Colors.blue[600],
                  Colors.blue[300]
                ]
              )
            ) ,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  
                      Padding(
                        padding: const EdgeInsets.only(bottom:13.0),
                        child: Avatar(
                        avatarUrl: _currentUser?.avatarUrl,
                        initals:initals,
//                         onTap: () async {
  
// print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
           
//                 showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//                 title: Text("From where do you want to take the photo?"),
//                 content: SingleChildScrollView(
//                   child: ListBody(
//                     children: <Widget>[
//                         // GestureDetector(
//                         //   child: Row(children:[ 
//                         //    Icon(Icons.photo_album), Text("  Gallery")]),
//                         //   onTap: () async{
//                         //    File image = await ImagePicker.pickImage(
//                         //       source: ImageSource.gallery);
//                         //       print("pickkkkkkkkkkkkkkkkkimaaaaageeeeeeee"+image.toString());
//                         //   try {
                             
//                         //      showAlertDialog(context);
//                         //   await locator
//                         //       .get<UserController>()
//                         //       .uploadProfilePicture(image,null);     
//                         //       Navigator.of(context).pop();   
//                         //       Navigator.of(context).pop();   

//                         //     setState(() { 
                               
//                         //      }); 
                              
//                         //     } catch (e) {
//                         //                                     Navigator.of(context).pop();   
                              
//                         //     }        
//                         //   },
//                         // ),
//                         Padding(padding: EdgeInsets.only(top:25.0)),
//                         // GestureDetector(
//                         //   child: Row(children:[ 
//                         //    Icon(Icons.camera_alt),Text("  Camera"),]),
//                         //   onTap: () async{
//                         //    File image = await ImagePicker.pickImage(
//                         //       source: ImageSource.camera);
//                         //       try {
                             
//                         //      showAlertDialog(context);
//                         //   await locator
//                         //       .get<UserController>()
//                         //       .uploadProfilePicture(image,null);     
//                         //       Navigator.of(context).pop();   
//                         //       Navigator.of(context).pop();   

//                         //     setState(() { 
                               
//                         //      }); 
                              
//                         //     } catch (e) {
//                         //                                     Navigator.of(context).pop();   
                              
//                         //     }        
//                         //   },
//                         // )
//                     ],
//                   ),
//                 )
//                 );
//                });         
//                         },
                    ),
                      ),
Text("${_currentUser?.displayName ?? 'nice to see you here.'}"),
                            Text(
                           "${_currentUser?.email ?? ''}"),
                  ],
                ),
              ),
            ),
          //SizedBox(height: 27,),
          //  Center(
          //    child: Text('Task',
          //       style: TextStyle(
          //         fontSize: 24, 
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //  ),

          Padding(
          padding: const EdgeInsets.all(8.0),
          child:  customListTile("Profile", Icon(Icons.people_outline),()async{
          
              Navigator.push(
              context, new MaterialPageRoute(builder: (context) => ProfilePage(gender)));
            }),
        ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: customListTile("Change Password", Icon(Icons.lock_outline),()async{
          
              Navigator.push(
              context, new MaterialPageRoute(builder: (context) => ChangePasswordPage()));
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: customListTile("Setting", Icon(Icons.settings),()async{
          

               Navigator.push(
              context, new MaterialPageRoute(builder: (context) => SettingView()));
             }),
          ),
          const Expanded(child: SizedBox()),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
             InkWell(
          splashColor: Colors.blue[100],
          onTap:  () async {

            FirebaseAuth dfdf = FirebaseAuth.instance;
            dfdf.signOut();
             SharedPreferences pref=await SharedPreferences.getInstance();
                                   pref.setBool('login', true);
                                  //  Navigator.pushReplacementNamed(
                                  //         context, HomeView.route);
                        Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(builder: (context) => LoginView()),
                       );

                      
                       // Navigator.of(context).pop();
                      },
          child: Container(
          //  alignment:  Alignment.bottomRight,
           
            height: 49,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                      Image.asset('images/logout.png',
                             height: 24,  
                          ),
                  
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  
                  child: Text('Logout',style: TextStyle(
                    fontSize:17.0,
                  ),
                  ),
                ),
                  ]
                ),
             
              ],
            ),
          ),
        ),
          ),  
            
          ],
        ),
  ),
        )
      );
    }
  )
          )   

        
      
    );
  }


 
  //Card makeDashboardItem(String title, IconData icon) {
    Card makeDashboardItem(String title, String  imageUrl,Function onTab) {

    return Card(
      
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)) ),
      shadowColor:Colors.blue,
        elevation: 10,
        color: Colors.white,
    margin: new EdgeInsets.all(22.0),
            //    child: Container(
            //      alignment: Alignment.center,
            // //decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
            // decoration: BoxDecoration(color: Colors.transparent,),
     
              child:new InkWell(
                
                onTap: onTab,
     
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                    //  SizedBox(height: 50.0),
                      
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child:  Image.asset(imageUrl,height: 50,width: 50,fit: BoxFit.cover,
                          
                      ), 
                          //   child: Icon(
                          // icon,
                          // size: 40.0,
                          // color: Colors.black,
                     //j )
                        ),
                      ),
 //                     SizedBox(height: 20.0),
                      new Center(
                        child: new Text(title,
                            style:
                                new TextStyle(fontSize: 18.0, color: Colors.black)),
                      )
                    ],
                  ),
                ),
            
     //   )
        );
  }

  InkWell  customListTile(String text, Icon icon,Function onTab)
  {
    
    return InkWell(
        splashColor: Colors.blue[100],
        onTap: onTab,
        child: Container(
          height: 49,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  icon,
                    // Image.asset(imageUrl,
                    //        height: 26,  
                    //     ),
                
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyle(
                  fontSize:18.0,
                ),
                ),
              ),
                ]
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      );
  }
}



  // decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(10),
  //                             boxShadow: [BoxShadow(
  //                               color: Colors.blue,//Color.fromRGBO(27, 95, 255, .3)
  //                               blurRadius: 20,
  //                               offset: Offset(0, 10)
  //                             )]
  //                           ),
   showAlertDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: new Row(
            children: [
               CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
),
               Container(margin: EdgeInsets.only(left: 5),child:Text("    Loading")),
            ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }