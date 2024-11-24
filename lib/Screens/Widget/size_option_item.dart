import 'package:coffee_app/Models/Product_Model.dart';
import 'package:coffee_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import './size_option_item.dart';
import 'package:coffee_app/Models/size_options_model.dart';

class SizeOptionItem extends StatelessWidget {
  final int index;
  final SizeOption sizeOption;
  // final  sizeOption;
  final Product product;
  final bool selected;

  const SizeOptionItem({
    super.key,
    required this.index,
    required this.sizeOption,
    required this.selected, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
              color: selected ? SecondColour : FirstColour.withOpacity(0.1),
              shape: BoxShape.circle),
          child: Center(
            child: Image.asset(

             product.category.name=='Bakery'? 'images/bakeryicon.png': 'images/coffee-cup.png',
              color: selected ? Colors.white : FirstColour,
              width: 25 + (index * 5),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(sizeOption.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)),
        Text(
          '${sizeOption.quantity} Fl Oz',
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
