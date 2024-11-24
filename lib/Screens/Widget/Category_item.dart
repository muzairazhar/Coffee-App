import 'package:coffee_app/Models/Product_Model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 73,
          width: 75,
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
          child: Image.asset("images/${category.image}"),
        ),
        SizedBox(height: 10,),
        Text(
          category.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13,
            color: Colors.white
          ),
        )
      ],
    );
  }
}
