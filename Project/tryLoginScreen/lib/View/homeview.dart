import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/aboutusview.dart';
import 'package:tryLoginScreen/View/galleryview.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:tryLoginScreen/View/portfolio.dart';
import 'package:tryLoginScreen/View/profile/avatar.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../locator.dart';
import 'contactusview.dart';
import 'interactivebindablelayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'mapview.dart';
import 'profileview.dart';

class HomeView extends StatefulWidget {
  static String route = "home";
 

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

    UserModel _currentUser = locator.get<UserController>().currentUser;




  @override
  Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return SafeArea(
      child: Scaffold(
        body: Container(
         //  width: double.infinity,
          
          child: Center(
            child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
            //  padding: EdgeInsets.all(3.0),
              children: <Widget>[
                Center( 
             
                  child: makeDashboardItem("Portfolio", 'images/icon_portfolio.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => PortfolioView()));
          })),
                Center(child: makeDashboardItem("Gallery", 'images/icon_photo.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => GalleryView()));
          })
          ),
                Center(child: makeDashboardItem("About Us", 'images/icon_aboutus.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => AboutUsView()));
          }),),
                Center(
                  child: makeDashboardItem("Contact Us", 'images/icon_contactall.png',()async{
        
             Navigator.push(
            context, new MaterialPageRoute(builder: (context) => ContactUsView()));
          }),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Dashboard"),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesome5.user),
              onPressed: () {
                Navigator.pushNamed(context, ProfileView.route);
              },
            )
          ],
        ),
        drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[300],
                Colors.blue[600],
                Colors.blue[300]
              ]
            )
          ) ,
            child: Container(
              child: Column(
                children: <Widget>[
                    Avatar(
                      avatarUrl: _currentUser?.avatarUrl,),
                      
                        Text(
                        ""),
                         Text(
                        ""),
                      
                      
                      //  Text(
                      //   "${_currentUser.displayName ?? 'nice to see you here.'}"),
                      //    Text(
                      //   "${_currentUser.email ?? ''}"),
                  // Material(
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //     child: Image.asset(),
                  // ),
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
        child:  customListTile("Portfolio", 'images/icon_portfolio.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => PortfolioView()));
          }),
      ),
       
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customListTile("Gallery", 'images/icon_photo.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => GalleryView()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customListTile("About Us", 'images/icon_aboutus.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => AboutUsView()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customListTile("Contact Us", 'images/icon_contact_2.png',()async{
        
            Navigator.push(
            context, new MaterialPageRoute(builder: (context) => ContactUsView()));
          }),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: customListTile("Logout", 'images/logout.png',
          () async {

          FirebaseAuth dfdf = FirebaseAuth.instance;
          dfdf.signOut();
                                //  Navigator.pushReplacementNamed(
                                //         context, HomeView.route);
                      Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (context) => LoginView()),
                     );

                     SharedPreferences pref=await SharedPreferences.getInstance();
                                 pref.setBool('login', true);
                     // Navigator.of(context).pop();
                    }
          ),
        ),  
          // ListTile(
          //   leading: Icon(Icons.select_all),
          //   title: Text('Logout'),
          //    onTap: () async {
                      

          //                       //  Navigator.pushReplacementNamed(
          //                       //         context, HomeView.route);
          //             Navigator.pushReplacement(
          //              context,
          //              MaterialPageRoute(builder: (context) => LoginView()),
          //            );

          //            SharedPreferences pref=await SharedPreferences.getInstance();
          //                        pref.setBool('login', true);
          //            // Navigator.of(context).pop();
          //           },
          // ),
        ],
      ),
  ),
  

      ),
    );
  }


 
  //Card makeDashboardItem(String title, IconData icon) {
    Card makeDashboardItem(String title, String  imageUrl,Function onTab) {

    return Card(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))),
      shadowColor:Colors.black,
        elevation: 0.1,
        color: Colors.blueAccent[100],
     margin: new EdgeInsets.all(8.0),
            //    child: Container(
            //      alignment: Alignment.center,
            // //decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
            // decoration: BoxDecoration(color: Colors.transparent,),
     
              child:new InkWell(
                onTap: onTab,
     
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                    //  SizedBox(height: 50.0),
                      
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Center(
                          child:  Image.asset(imageUrl, fit: BoxFit.cover,
                         height: 100,  
                      ), 
                          //   child: Icon(
                          // icon,
                          // size: 40.0,
                          // color: Colors.black,
                     // )
                        ),
                      ),
 //                     SizedBox(height: 20.0),
                      new Center(
                        child: new Text(title,
                            style:
                                new TextStyle(fontSize: 18.0, color: Colors.white)),
                      )
                    ],
                  ),
                ),
            
     //   )
        );
  }

  InkWell  customListTile(String text, String imageUrl,Function onTab)
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
                    Image.asset(imageUrl,
                           height: 26,  
                        ),
                
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyle(
                  fontSize:24.0,
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