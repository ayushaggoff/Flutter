import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'customimageview.dart';

class GalleryView extends StatelessWidget {
  final List img=[
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_1.jpg",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_2.jpg",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_3.jpg",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_4.jpg",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_01.png",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_02.png",
    "https://successive.tech/wp-content/themes/successive/images/culture/Our_Culture_04.png",
    "https://successive.tech/wp-content/themes/successive/images/culture/CultureBottom2.jpg",
    "https://successive.tech/wp-content/themes/successive/images/culture/CultureBottom1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gallery")),
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              itemCount: img.length, 
              itemBuilder: (context,index)
                {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => CustomImageView(img[index].toString())),
                       );
                      print('ayush'+img[index].toString());
                    },
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color:Colors.transparent,
                        borderRadius:BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius:BorderRadius.circular(8.0),
                        child: Image.network(img[index],fit:BoxFit.fill,),
                      ),
                    ),
                  );
                }, 
              staggeredTileBuilder: (index){
                return new StaggeredTile.count(1, index.isEven ? 1.35:2);//1.2:2
              },
              ),
          ),
        ),
        ),
      ),
    );
  }
}