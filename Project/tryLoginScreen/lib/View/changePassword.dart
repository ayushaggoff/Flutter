import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryLoginScreen/bloc/ChangePwdPageBloc/changepwd_page_bloc.dart';
import 'package:tryLoginScreen/bloc/ChangePwdPageBloc/changepwd_page_event.dart';
import 'package:tryLoginScreen/bloc/ChangePwdPageBloc/changepwd_page_state.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';
import 'homeview.dart';

class ChangePasswordPage extends StatefulWidget {
  UserModel currentUser = locator.get<UserController>().currentUser;

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<ChangePasswordPage> {
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                title: Text(
              "Change Password",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            body: BlocProvider<ChangePwdPageBloc>(
              create: (context) => ChangePwdPageBloc()..add(InitEvent()),
              child: BlocListener<ChangePwdPageBloc, ChangePWDPageState>(
                  listener: (context, state) {
                if (state is ChangePWDSuccessState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                }
              }, child: BlocBuilder<ChangePwdPageBloc, ChangePWDPageState>(
                      builder: (context, state) {
                var bloc = BlocProvider.of<ChangePwdPageBloc>(context);

                if (state is ChangePWDInitialState) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Colors.blue[300],
                            Colors.blue[600],
                            Colors.blue[300]
                          ]),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 16),

                          Container(
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 0, color: Colors.white),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60),
                                )),
                          ),

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.zero,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              shadowColor: Colors.blue,
                                              elevation: 10,
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color: Colors.grey[
                                                                              200]))),
                                                              child: StreamBuilder<
                                                                      String>(
                                                                  stream: BlocProvider.of<
                                                                              ChangePwdPageBloc>(
                                                                          context)
                                                                      .passwordStream,
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return TextFormField(
                                                                      onChanged:
                                                                          bloc.passwordChanged,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        errorText:
                                                                            snapshot.error,
                                                                        hintText:
                                                                            "Current password",
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                      controller:
                                                                          _passwordController,
                                                                    );
                                                                  })),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: StreamBuilder<
                                                                    String>(
                                                                stream: BlocProvider.of<
                                                                            ChangePwdPageBloc>(
                                                                        context)
                                                                    .newpasswordstream,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged: bloc
                                                                        .newpasswordChanged,
                                                                    decoration: InputDecoration(
                                                                        errorText:
                                                                            snapshot
                                                                                .error,
                                                                        hintText:
                                                                            "New password",
                                                                        border:
                                                                            InputBorder.none),
                                                                    controller:
                                                                        _newPasswordController,
                                                                    obscureText:
                                                                        true,
                                                                  );
                                                                }),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: StreamBuilder<
                                                                    String>(
                                                                stream: BlocProvider.of<
                                                                            ChangePwdPageBloc>(
                                                                        context)
                                                                    .renewpasswordStream,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged: bloc
                                                                        .newpasswordChanged,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "Retype new password",
                                                                      errorText:
                                                                          snapshot
                                                                              .error,
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    obscureText:
                                                                        true,
                                                                    controller:
                                                                        _repeatPasswordController,
                                                                    validator:
                                                                        (value) {
                                                                      return _newPasswordController.text ==
                                                                              value
                                                                          ? null
                                                                          : "Please validate your entered password";
                                                                    },
                                                                  );
                                                                }),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60.0,
                                                              left: 60.0),
                                                      child: RaisedButton(
                                                        onPressed: () async {
                                                          bloc.add(ChangePwdButtonPressedEvent(
                                                              currentpassword:
                                                                  _passwordController
                                                                      .text,
                                                              newpassword:
                                                                  _newPasswordController
                                                                      .text,
                                                              renewpassword:
                                                                  _repeatPasswordController
                                                                      .text));
                                                        },
                                                        color: Colors.blue[300],
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Save",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ]),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            )
          ),
        )
      )
    );
  }
}
