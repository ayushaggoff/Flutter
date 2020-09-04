import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
class CustomImageView extends StatelessWidget {
  String imageUrl;

  CustomImageView(this.imageUrl);
  @override
  Widget build(BuildContext context) {
   timeDilation=2;
    return Scaffold(
      body:
    SafeArea(
        child: Hero(
          tag: imageUrl.toString(),
          child: Stack(
            
            children: <Widget>[
             
              Center(
                
                child: Container(
                  decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Colors.blue,//Color.fromRGBO(27, 95, 255, .3)
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                                )]
                              ),
                  child: Image(
                    
              alignment:Alignment.bottomCenter,    
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            Positioned(
                  right: 0.0,
                  child: GestureDetector(
                  onTap: (){
                      Navigator.of(context).pop();
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.red),
                      ),
                  ),
                  ),
                  ),
            ],
          ),
        ),
      )
    );
  }
}