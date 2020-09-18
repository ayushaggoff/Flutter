import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryLoginScreen/bloc/authBloc/auth_event.dart';
import 'View/homeview.dart';
import 'View/loginview.dart';
import 'bloc/authBloc/auth_bloc.dart';
import 'bloc/authBloc/auth_state.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter POC',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        accentColor: Color(0xFF000000),
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
      ),
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          return SplashScreen();
        } else if (state is AuthenticatedState) {
          return HomeView();
        } else if (state is UnAuthenticatedState) {
          return LoginPageParent();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
            ),
            Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
          ],
        ),
      ),
    );
  }
}
