import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_event.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_state.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repository/storage_repo.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState>
{


  FirebaseMessaging firebaseMessaging =  FirebaseMessaging();

  void setNotification()
  {
  
   
   firebaseMessaging.configure(
     onMessage: (Map<String,dynamic>message) async{
          print("Message:$message");
           },
        onResume: (Map<String,dynamic>message) async{
          print("Message:$message");
        },
        onLaunch: (Map<String,dynamic>message) async{
          print("Message:$message");
        }
    );

  }
 

 // HomePageBloc(HomePageState initialState) : super(initialState);

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

HomePageBloc() : super(LogoutInitialState()){
  authRepo=AuthRepo();
}

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async*{
    FirebaseAuth auth = FirebaseAuth.instance;
    var user=await auth.currentUser();
   //UserModel a=await authRepo.getUser();
   if(event is InitEvent)
   {
         
   SharedPreferences logindata = await SharedPreferences.getInstance();
    
 
      if(logindata.getBool("newsnotification"))
      {
            await firebaseMessaging.subscribeToTopic('News');
      }else{
          await firebaseMessaging.unsubscribeFromTopic('News');
      }   
       if(logindata.getBool("advertisenotification"))
      {
        await firebaseMessaging.subscribeToTopic('Advertise');
      }else{
        await firebaseMessaging.unsubscribeFromTopic('Advertise');
      }
      
   String avartarUrl,displayName,gender; 
       


      final results = await Firestore.instance.collection("users").document(user.email).get()
       .then((value)  async {
       print('mmmmmmmmmppppppp:'+value.data["username"]);
       displayName=value.data["username"];
       gender=value.data["gender"];       
        
        //avartarUrl=await _storageRepo.getUserProfileImage(email);
       //event.avartarUrl=await userController.getDownloadUrl();
     });
      try{
    avartarUrl=await getAvatarUrl(user.email);
      }catch(ex)
      {
        print(ex);
        avartarUrl=null;
      }
    print("aaaaaaaaaavaatar:"+avartarUrl.toString());
    yield HomeviewInitialState(avartarUrl:avartarUrl,displayName:displayName ,email: user.email,gender: gender);
   }else if(event is LogOutButtonPressedEvent)
   {
     await authRepo.SignOUt();
     yield LogoutSuccessState();
   }
  }
  
}