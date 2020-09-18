import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/aboutusview.dart';
import 'package:tryLoginScreen/View/changePassword.dart';
import 'package:tryLoginScreen/View/galleryview.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:tryLoginScreen/View/portfolio.dart';
import 'package:tryLoginScreen/View/profile/avatar.dart';
import 'package:tryLoginScreen/View/setting.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_bloc.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_event.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_state.dart';
import 'ProfilePage.dart';
import 'contactusview.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String initals;
  @override
  void initState() {
    super.initState();
  }

  String gender, displayName, avatarUrl, email;
  @override
  Widget build(BuildContext context) {
    initals = "Z";
    return BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc()..add(InitEvent(context)),
        child:
            BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          if (state is HomeviewInitialState) {
            return Scaffold(
                body:
                    // gender=state.gender;
                    // email=state.email;
                    // displayName=state.displayName;
                    // avatarUrl=state.avartarUrl;
                    // initals=state.displayName.toUpperCase();
                    // initals=initals[0];

                    SafeArea(
                        child: Column(
                  children: [
                    new Expanded(
                      child: new Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: new Container(
                            child: GridView.count(
                              shrinkWrap: true,
                              // childAspectRatio: (itemWidth / itemHeight),
                              crossAxisCount: 2,
                              padding: EdgeInsets.all(0.0),
                              children: <Widget>[
                                //Center(

                                //child:
                                makeDashboardItem("Portfolio",
                                    'images/icon_portfolio_custom.png',
                                    () async {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              PortfolioView()));
                                }),
                                // ),
                                //  Center(child:
                                makeDashboardItem(
                                    "Gallery", 'images/icon_gallery2Bl.png',
                                    () async {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => GalleryView()));
                                }),

                                ///),
                                //Center(child:
                                makeDashboardItem("About Us",
                                    'images/icon_aboutus_custom.png', () async {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => AboutUsView()));
                                }),
                                //),
                                //    Center(   child:
                                makeDashboardItem(
                                    "Contact Us", 'images/icon_contact2Bl.png',
                                    () async {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              ContactUsView()));
                                }),
                                //    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                appBar: AppBar(
                  title: Text("Dashboard"),
                ),
                drawer:
                    Drawer(child: LayoutBuilder(builder: (context, constraint) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
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
                                ])),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  StreamBuilder<String>(
                                      stream:
                                          BlocProvider.of<HomePageBloc>(context)
                                              .imageStream,
                                      builder: (context, snapshot) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 13.0),
                                          child: Avatar(
                                            avatarUrl: snapshot.data,
                                            initals: state.initials,
                                          ),
                                        );
                                      }),
                                  StreamBuilder<String>(
                                      stream:
                                          BlocProvider.of<HomePageBloc>(context)
                                              .nameStream,
                                      builder: (context, snapshot) {
                                        return Text(
                                            "${snapshot.data ?? 'nice to see you here.'}");
                                      }),
                                  StreamBuilder<String>(
                                      stream:
                                          BlocProvider.of<HomePageBloc>(context)
                                              .emailStream,
                                      builder: (context, snapshot) {
                                        return Text("${snapshot.data ?? ''}");
                                      }),
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
                            child: customListTile(
                                "Profile", Icon(Icons.people_outline),
                                () async {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(gender)));
                            }),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: customListTile(
                                "Change Password", Icon(Icons.lock_outline),
                                () async {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordPage()));
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: customListTile(
                                "Settings", Icon(Icons.settings), () async {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => SettingView()));
                            }),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: Colors.blue[100],
                              onTap: () async {
                                FirebaseAuth dfdf = FirebaseAuth.instance;
                                dfdf.signOut();
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setBool('login', true);
                                //  Navigator.pushReplacementNamed(
                                //         context, HomeView.route);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPageParent()),
                                );

                                // Navigator.of(context).pop();
                              },
                              child: Container(
                                //  alignment:  Alignment.bottomRight,

                                height: 49,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Image.asset(
                                        'images/logout.png',
                                        height: 24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                })));
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      )
    );
  }

  Card makeDashboardItem(String title, String imageUrl, Function onTab) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      shadowColor: Colors.blue,
      elevation: 10,
      color: Colors.white,
      margin: new EdgeInsets.all(22.0),
      child: new InkWell(
        onTap: onTab,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Image.asset(
                  imageUrl,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Center(
              child: new Text(title,
                  style: new TextStyle(fontSize: 18.0, color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  InkWell customListTile(String text, Icon icon, Function onTab) {
    return InkWell(
      splashColor: Colors.blue[100],
      onTap: onTab,
      child: Container(
        height: 49,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              icon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ]),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("    Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
