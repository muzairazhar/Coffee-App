import 'dart:math';

import 'package:coffee_app/Screens/Detail_Screen.dart';
import 'package:coffee_app/Screens/Widget/Background.dart';
import 'package:coffee_app/Screens/Widget/Category_item.dart';
import 'package:coffee_app/Screens/Widget/product_image.dart';
import 'package:coffee_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

import '../Models/Product_Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void initState(){
    super.initState();
    controller=PageController(initialPage: 1, viewportFraction: viewpoint)..addListener((){
      setState(() {
        pageoffset=controller!.page;
      });
    });
  }

  void dispose(){
    super.dispose();
    controller!.dispose();
  }
  int currentcategory=0;
  int CurrentProduct=0;
    double viewpoint=0.5;
    double? pageoffset=1;
  PageController? controller;
  List<Color> color=[
    Colors.black12,
    Colors.yellow,
    Colors.green,
    Colors.red
  ];


  @override
  Widget build(BuildContext context) {
    List<Product>   dataproduct=products.where((_element) => _element.category == categories[currentcategory]).toList();
    return Scaffold(
     appBar:MyAppBar(),
      body: Stack(
        children: [
          const Background(),
          const Positioned(
            top: 30,left: 40,
            child: Text("Smooth Out\nYour Everyday",
              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35),),
          ),
          Positioned(
            top: 120,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                color: FirstColour,
                child: Row(
                  children:
                  List.generate(
                    categories.length,
                        (index) => Container(
                          height: 190,
                          width: 90,
                          color: currentcategory==index?Colors.amber:Colors.transparent,

                        ),
                  )


                ),
              ),

            ),
          ),
          Positioned(
            top: 125,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                color: FirstColour,
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      categories.length,
                          (index){
                  int decrease=0;
                      int max=1;
                      int bottompadding=1;
                      //for item display in curve shape
                      for(var i=0;i<categories.length;i++){
                       bottompadding=index > max ? index-decrease++ : index;
                      }
                      return GestureDetector(
                        onTap: () {
                         setState(() {
                         print(  "Categor is${dataproduct[currentcategory].category.name}");

                           currentcategory=index;
                           // print(currentcategory);
                         });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 90),
                          child:CategoryItem(category: categories[index]) ,
                        ),
                      );
                  }
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clip(),
              child: Container(

                height: MediaQuery.of(context).size.height* 0.50,
                width: MediaQuery.of(context).size.width,
                color: SecondColour,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height *0.58,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: controller,

                      onPageChanged: (value) {
                        setState(() {
                        CurrentProduct=value % dataproduct.length;
                        // print(CurrentProduct);
                        // print(dataproduct.length);
                        });
                      },
                      itemBuilder: (context, index) {
                          double  scale = max(0.5, (1-(pageoffset!-index).abs()+viewpoint));
                          // print("scale ${scale}");
                          // print("index ${pageoffset!-index.abs()}");

                          double angle=0.0;
                          final items =dataproduct[index % dataproduct.length];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              print("Scale is ${scale}");
                              print("padding ${250 - (scale/1.6 * 170) }");
                              print(dataproduct[CurrentProduct % dataproduct.length].name);
                            });
                            Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(product:items),));

                          },
                          child: Hero(
                            tag: items.name,
                            child: Padding(
                              padding:  EdgeInsets.only(top: 250 - (scale/1.6 * 170)),
                              child: Transform.rotate(
                                angle:angle*pi,
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    ProductImage(product:items )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: [
                          Text(
                             dataproduct[CurrentProduct % dataproduct.length].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.1
                            ),
                          ),
                     const     SizedBox(height: 5,),
                          Text(
                           "\$${ dataproduct[CurrentProduct % dataproduct.length].price}",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.6
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: List.generate(dataproduct.length, (index)=>indicator(index)),
                          ),
                          const     SizedBox(height: 11,),


                        ],
                      ),

                    )

                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }

AnimatedContainer indicator(int index){
    return  AnimatedContainer(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.all(2.5),
      duration: const Duration(milliseconds: 300),
       decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2,color: index==CurrentProduct ?Colors.amber:Colors.white60),
        ),
      child: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: index==CurrentProduct ?Colors.white:Colors.white60
        ),
      ),


    );
}


AppBar MyAppBar(){
    return  AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset("images/coffee-cup.png",height: 30,color: Colors.amber,),
          SizedBox(width: 10,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Qahwa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
              ),
              Text("Space",style: TextStyle(fontSize: 15),
              )
            ],
          )
        ],
      ),
      actions: [
        Center(
          child: Stack(
            children: [
              const Icon(
                Icons.shopping_cart,
                color: Colors.amber,
              ),
              Positioned(
                right: 3,
                top: 0,
                child:Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: FirstColour
                  ),
                ),
              )

            ],

          ),
        ),
        SizedBox(width: 12,),

      ],
    );

}

}


class Clip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=Path();
    path.lineTo(0,size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width,100);
    path.quadraticBezierTo(size.width /2,-40, 0, 100);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return false;
  }

}
