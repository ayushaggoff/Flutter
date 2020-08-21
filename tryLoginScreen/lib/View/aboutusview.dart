import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class AboutUsView extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AboutUsView> {


  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4(),
    Item5(),
    Item6(),
    Item7(),
    Item8(),

  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      title: 'Flutter Card Carousel App',
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title:Text("About Us")
        ),
        body: SingleChildScrollView(

          child: Column(
            
           crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 8.0),
                child: Image.asset('images/logo_successive_short_1.png'),
              ) ,
             
               Text('About Successive',style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.left,),
              ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'At Successive, we strongly believe that technology is not just a luxury or an add-on; it is a way of life. With more than a decade of IT expertise, and operations in countries like India, US, Norway, New Zealand and South Africa, we are on a mission to spread this mindset.',
                          style: TextStyle(
                              color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Our goal is to optimize, transform and reinvent businesses one step at a time. As a leading technology services provider, we offer solutions to various industry segments such as e-commerce, legal tech, fintech, media, agri-tech, telecom, logistics and more. Our 500+ employees are highly skilled at leveraging intelligent processes, in-depth analytics and innovative technology to achieve the best possible results.', 
                          style: TextStyle(
                              color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                        ),
                      ),
                    ),
                   
             
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Our awards and recognition',style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.left,),
               ),


              CarouselSlider(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                aspectRatio: 2.0,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: cardList.map((card){
                  return Builder(
                    builder:(BuildContext context){
                      return Container(
                        height: MediaQuery.of(context).size.height*0.30,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.blueAccent,
                          child: card,
                        ),
                      );
                    }
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(cardList, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                    ),
                  );
                }),
              ),

            ],
          ),
        )
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/aboutAward7.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2020",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/Software_Developers_India_2019.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2019",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/aboutAward4.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2016|2017",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/aboutAward1.png', fit: BoxFit.cover,
                         height: 50,  
                      ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text(
                "Technology Fast",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
                )),
          ), 
               Text(
              "50 INDIA",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )),                
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2016|2017|2019",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}




class Item5 extends StatelessWidget {
  const Item5({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/aboutAward2.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2018",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}



class Item6 extends StatelessWidget {
  const Item6({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/award1.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2018|2019",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}



class Item7 extends StatelessWidget {
  const Item7({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/award3.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2019",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}


class Item8 extends StatelessWidget {
  const Item8({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network('https://successive.tech/wp-content/themes/successive/images/award2.png', fit: BoxFit.cover,
                         height: 100,  
                      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2018|2019",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ],
      ),
    );
  }
}
