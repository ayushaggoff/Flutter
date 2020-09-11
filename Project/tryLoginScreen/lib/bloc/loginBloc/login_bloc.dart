import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_event.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_state.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'dart:async';
class LoginBloc extends Bloc<LoginEvent,LoginState>{

   AuthRepo authRepo;
   UserController userController;

   
   final _emailStreamController = StreamController<String>();
   Stream<String> get emailStream => _emailStreamController.stream;
  StreamSink<String> get _emailSink => _emailStreamController.sink;
   

void dispose(){
  _emailStreamController.close();
}
 LoginBloc() : super(LoginInitialState()){
   authRepo=AuthRepo();
   userController=UserController();
 }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressedEvent){
      try{
        yield LoginLoadingState();
        if()
        await userController.signInWithEmailAndPassword(email:event.email,password:event.password);
        
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }else if(event is FacebookButtonPressedEvent){
       try{
        yield LoginLoadingState();
        await userController.signInWithFacebook();
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }else if(event is GoogleButtonPressedEvent){
       try{
        yield LoginLoadingState();
        await userController.signInWithGoogle();
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }  
  }
}