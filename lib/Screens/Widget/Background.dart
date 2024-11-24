import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: const Stack(
        children: [
          CoffeeBean(degre: 190,right: 160,top: 90,),
          CoffeeBean(degre: 90,right: -50,top: 5,),
          CoffeeBean(degre: 10,right: -70,top: 140,),
          CoffeeBean(degre: 75,right: -20,top: 150,),
          CoffeeBean(degre: 100,right: -70,top: 300,),
          CoffeeBean(degre: 155,right: 70,top: 350,),


        ],
      ),
    );
  }
}

class CoffeeBean extends StatelessWidget {
  final double? top,left,right,bottom,degre;

  const CoffeeBean({super.key, this.top, this.left, this.right, this.bottom, this.degre});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: Transform.rotate(

        angle: degre! * pi/190,
        child: SvgPicture.asset('images/coffee-bean.svg',width: 150,),
      ),
    );
  }
}
