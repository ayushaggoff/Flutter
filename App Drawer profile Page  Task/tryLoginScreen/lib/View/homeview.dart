import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
      ),
      appBar: AppBar(
        title: Text("Home Screen"),
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
      SizedBox(height: 27,),
       Center(
         child: Text('Task',
            style: TextStyle(
              fontSize: 24, 
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
       ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: () {
                    Navigator.pushNamed(context, ProfileView.route);
                   // Navigator.of(context).pop();
                  },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
          onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage1()),
                  );
                   // Navigator.of(context).pop();
                  },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Interactive bindable layout'),
           onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InteractiveBindableLayoutView()),
                  );
                   // Navigator.of(context).pop();
                  },
        ),
        ListTile(
          leading: Icon(Icons.select_all),
          title: Text('Logout'),
           onTap: () async {
                    

                              //  Navigator.pushReplacementNamed(
                              //         context, HomeView.route);
                    Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(builder: (context) => LoginView()),
                   );

                   SharedPreferences pref=await SharedPreferences.getInstance();
                               pref.setBool('login', true);
                   // Navigator.of(context).pop();
                  },
        ),
      ],
    ),
  ),
  

    );
  }
}