import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:tryLoginScreen/bloc/ChangePwdPageBloc/changepwd_page_event.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repository/storage_repo.dart';
import 'changepwd_page_state.dart';

class ChangePwdPageBloc extends Bloc<ChangePwdPageEvent,ChangePWDPageState>
{


final _passwordStreamController=BehaviorSubject<String>();
Stream<String> get passwordStream => _passwordStreamController.stream;
StreamSink<String> get _passwordSink => _passwordStreamController.sink;
Function(String) get passwordChanged => _passwordStreamController.sink.add;

    final _newpasswordStreamController=BehaviorSubject<String>();
Stream<String> get newpasswordstream => _newpasswordStreamController.stream;
StreamSink<String> get _newpasswordSink => _newpasswordStreamController.sink;
Function(String) get newpasswordChanged => _newpasswordStreamController.sink.add;



final _renewpasswordStreamController=BehaviorSubject<String>();
Stream<String> get renewpasswordStream => _renewpasswordStreamController.stream;
StreamSink<String> get _renewpasswordSink => _renewpasswordStreamController.sink;
Function(String) get renewpasswordChanged => _renewpasswordStreamController.sink.add;


AuthRepo authRepo;
UserController userController;
  StorageRepo _storageRepo;

ChangePwdPageBloc() : super(ChangePWDLoadingState()){
  authRepo=AuthRepo();
}

  @override
  Stream<ChangePWDPageState> mapEventToState(ChangePwdPageEvent event) async*{
    FirebaseAuth auth = FirebaseAuth.instance;
    var user=await auth.currentUser();
   //UserModel a=await authRepo.getUser();
   if (event is InitEvent)
   {
     
     yield ChangePWDInitialState();
    
   }
   else if (event is ChangePwdButtonPressedEvent)
   {
      String currentpassword=event.currentpassword,newpassword=event.newpassword,renewpassword=event.renewpassword;
      bool checkCurrentPasswordValid=false;

      if(currentpassword==null)
      {
        _passwordSink.addError("Please provide current password");
      }else if(currentpassword==null){
        checkCurrentPasswordValid = await userController.validateCurrentPassword(currentpassword);
        if(!checkCurrentPasswordValid)
        {
          _passwordSink.addError("Please provide correct current password");
        }        
      }else if(newpassword==null){
          _newpasswordSink.addError("Please provide new password");
      }else if(renewpassword.isEmpty){
          _renewpasswordSink.addError("Please retype the new password");
      }else if(checkCurrentPasswordValid){
          bool checkpassword=false;
          if(newpassword==renewpassword)
          {
            checkpassword=true;
          }else{
            _renewpasswordSink.addError("Password does not match");
          }
          if(checkpassword){
           await userController.updateUserPassword(newpassword);
           yield ChangePWDSuccessState();
          }

      }

     
     
    
   }
  }
}