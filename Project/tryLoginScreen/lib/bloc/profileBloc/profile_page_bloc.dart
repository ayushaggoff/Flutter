import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_event.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_state.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repository/storage_repo.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent,ProfilePageState>
{


Future<String> getAvatarUrl(String email) async {
  try{
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://tryloginscreen.appspot.com");
   return   await _storage.ref().child("user/profile/$email").getDownloadURL();
  }catch(ex){
    return null;
  }

    return null;
  }


AuthRepo authRepo;
UserController userController;
  StorageRepo _storageRepo;

ProfilePageBloc() : super(ProfileInitialState()){
  authRepo=AuthRepo();
}

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async*{
    FirebaseAuth auth = FirebaseAuth.instance;
    var user=await auth.currentUser();
   //UserModel a=await authRepo.getUser();
   if(event is InitEvent)
   {
     
   String avartarUrl,displayName,gender,dob,phone; 
       


      final results = await Firestore.instance.collection("users").document(user.email).get()
       .then((value)  async {
       print('mmmmmmmmmppppppp:'+value.data["username"]);
       displayName=value.data["username"];
       gender=value.data["gender"];       
       dob=value.data["dob"];
       phone=value.data["phone"]; 
     });
      try{
    avartarUrl=await getAvatarUrl(user.email);
      }catch(ex)
      {
        print(ex);
        avartarUrl=null;
      }
    yield ProfileInitialState(avartarUrl:avartarUrl,displayName:displayName ,email: user.email,gender: gender,dob: dob,phone:phone);
   }
  }
  
}