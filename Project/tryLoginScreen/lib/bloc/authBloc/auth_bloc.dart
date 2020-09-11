import 'package:bloc/bloc.dart';
import 'package:tryLoginScreen/bloc/authBloc/auth_event.dart';
import 'package:tryLoginScreen/bloc/authBloc/auth_state.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';

class AuthBloc extends Bloc <AuthEvent,AuthState>{
 // AuthBloc(AuthState initialState) : super(initialState);
  
 AuthRepo authRepo;

 AuthBloc() : super(AuthInitialState()){
   authRepo=AuthRepo();
 }


 @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is AppStartedEvent)
    {
      try{
       var isSignedIn=await authRepo.isSignedIn();
       if(isSignedIn)
       {
         var user=await authRepo.getUserFirebase();
         yield AuthenticatedState(user: user);
       }else{
         yield UnAuthenticatedState();
       }
      }catch(e){
         yield UnAuthenticatedState();
      }
       
    }
  }

  

}