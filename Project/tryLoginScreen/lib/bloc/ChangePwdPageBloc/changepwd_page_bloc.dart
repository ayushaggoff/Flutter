import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:tryLoginScreen/bloc/ChangePwdPageBloc/changepwd_page_event.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../../repository/storage_repo.dart';
import 'changepwd_page_state.dart';

class ChangePwdPageBloc extends Bloc<ChangePwdPageEvent, ChangePWDPageState> {
  Future<bool> validateCurrentPassword(String password) async {
    return await authRepo.validatePassword(password);
  }

  void updateUserPassword(String password) {
    authRepo.updatePassword(password);
  }

  final _passwordStreamController = BehaviorSubject<String>();
  Stream<String> get passwordStream => _passwordStreamController.stream;
  StreamSink<String> get _passwordSink => _passwordStreamController.sink;
  Function(String) get passwordChanged => _passwordStreamController.sink.add;

  final _newpasswordStreamController = BehaviorSubject<String>();
  Stream<String> get newpasswordstream => _newpasswordStreamController.stream;
  StreamSink<String> get _newpasswordSink => _newpasswordStreamController.sink;
  Function(String) get newpasswordChanged =>
      _newpasswordStreamController.sink.add;

  final _renewpasswordStreamController = BehaviorSubject<String>();
  Stream<String> get renewpasswordStream =>
      _renewpasswordStreamController.stream;
  StreamSink<String> get _renewpasswordSink =>
      _renewpasswordStreamController.sink;
  Function(String) get renewpasswordChanged =>
      _renewpasswordStreamController.sink.add;

  AuthRepo authRepo;
  UserController userController;
  StorageRepo _storageRepo;

  ChangePwdPageBloc() : super(ChangePWDLoadingState()) {
    authRepo = AuthRepo();
  }

  @override
  Stream<ChangePWDPageState> mapEventToState(ChangePwdPageEvent event) async* {

    if (event is InitEvent) {
      yield ChangePWDInitialState();
    } else if (event is ChangePwdButtonPressedEvent) {
      String currentpassword = event.currentpassword,
          newpassword = event.newpassword,
          renewpassword = event.renewpassword;
      bool checkCurrentPasswordValid = false;

      if (currentpassword.length == 0) {
        _passwordSink.addError("Please provide current password");
      } else if (currentpassword.length != 0) {
        checkCurrentPasswordValid =
            await validateCurrentPassword(currentpassword);
        print("check current oasword valid::" +
            checkCurrentPasswordValid.toString());
        if (!checkCurrentPasswordValid) {
          _passwordSink.addError("Please provide correct current password");
        } else if (newpassword.length == 0) {
          _newpasswordSink.addError("Please provide new password");
        } else if (renewpassword.length == 0) {
          _renewpasswordSink.addError("Please retype the new password");
        } else if (checkCurrentPasswordValid) {
          bool checkpassword = false;
          if (newpassword == renewpassword) {
            checkpassword = true;
          } else {
            _renewpasswordSink.addError("Password does not match");
          }
          if (checkpassword) {
            await updateUserPassword(newpassword);
            yield ChangePWDSuccessState();
          }
        }
      }
    }
  }
}
