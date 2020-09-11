import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_event.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_state.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';

class UserRegBloc extends Bloc<UserRegEvent,UserRegState>{
//UserRegBloc(UserLoadingState initialState) : super(UserRegInitialState());

AuthRepo authRepo;
UserController userController;

UserRegBloc() : super(UserRegInitialState()){
  authRepo=AuthRepo();
  userController=UserController();
}



  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event)async* {
    if(event is SignUpButtonPressedEvent){
      try
      {
        yield UserLoadingState();
        authRepo.signUpWithEmailAndPassword(email: event.email,password:event.password,dob: event.dob,gender: event.gender,username: event.username,phone: event.phone);
       yield UserRegSuccessfulState();
      }catch(e){
        yield UserRegFailureState(message: e.toString());
      }
      
    }
  }

}