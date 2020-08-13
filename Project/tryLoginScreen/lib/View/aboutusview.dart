import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';


class AboutUsView extends StatefulWidget {
  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
VideoPlayerController playerController;
VoidCallback listener;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    listener=(){
      setState(() {
        
      });
    };
  }

  void createVideo(){
    if(playerController==null)
    {
      playerController=VideoPlayerController.network("https://www.youtube.com/watch?v=kd_v46l5Xmc")
      ..addListener(listener)
      ..setVolume(1.0)
      ..initialize()
      ..play();
    }else{
      if(playerController.value.isPlaying){
        playerController.pause();
      }else{
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text("About Us"),
    ), 
  body:  Center(
        child:   AspectRatio(
                aspectRatio:1280/720,
                child: Container(
                  child:playerController!=null
                  ? VideoPlayer(
                    playerController,
                  )
                  : Container()),
                ),
              ),
              floatingActionButton:FloatingActionButton(
                onPressed:(){
                  createVideo();
                },
                child: Icon(Icons.play_arrow),
                ) ,
   ); 
  }
}