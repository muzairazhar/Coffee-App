import 'package:coffee_app/Models/Product_Model.dart';
import 'package:coffee_app/Screens/Widget/Background.dart';
import 'package:coffee_app/Screens/Widget/product_image.dart';
import 'package:coffee_app/Screens/Widget/size_option_item.dart';
import 'package:flutter/material.dart';

import '../Models/size_options_model.dart';
import '../Utils/Colors.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  // final Product product;



   DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
   int selectedSize=2;
   int quantity = 1;


   @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      appBar:appBar(context),
      body:Stack(
        children: [
           Background(),
          Positioned(
            left: 30,
            right: 20,
            // top: -45,
            child: Column(
              children: [
                Hero(
                  tag: widget.product.name,
                  child:  SizedBox(
                    width:size.width*0.81,
                    height: size.height*0.5,
                    child: ProductImage(product: widget.product),
                  ),
                ),
               const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width/1.5,
                      child: Text(widget.product.name,
                        maxLines: 2,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "\$${ widget.product.price}",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: FirstColour,
                              height: 1.6
                          ),
                        ),
                       const Text(
                          "Best Sale",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black45,
                              height: 1.6
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                SizedBox(height: 4,),
               Column(
                  children: [
                     const Text(
                      "Size Options",
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black38,
                          height: 1.6
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(sizeOptions.length, (index){
                        return GestureDetector(
                          onTap: (){
                              setState(() {
                                selectedSize=index;
                              });
                          },
                          child: SizeOptionItem(
                              index: index, sizeOption: sizeOptions[index], selected: selectedSize==index?true:false,product: widget.product,),
                        );
                      })
                    )


                  ],
                ),
                 SizedBox(height: size.height/34,),
                Row(
                  children: [

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if(quantity>1){
                            quantity--;
                          }
                        });
                      },
                      child:   Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: SecondColour,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                      ,
                    ),
                  const  SizedBox(width: 9,),
                    Text(quantity.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    ),
                    const  SizedBox(width: 9,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                         quantity++;
                      });
                      },

                      child:   Container(
                        padding:const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: SecondColour,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                      ,
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: Container(

                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        decoration: BoxDecoration(
                          color: SecondColour,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(
                          child: Text("Add to Order",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                          ),),
                        ),


                      ),
                    )
                  ],
                )

              ],
            ),
          )
        ],
      ) ,
    );
  }

  AppBar appBar(BuildContext context){
   return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child:const  Icon(Icons.arrow_back),
      ),
      title: const Text('Details',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
      ),
      centerTitle: true,
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
        SizedBox(width: 7,)

      ],
    );

  }
}
