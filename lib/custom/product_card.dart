import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String offer;
  final String label;

  ProductCard({
    required this.imageUrl,
    required this.offer,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          width: 200,

          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20) ,color: Colors.white,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 5),
              Container(child: Image.network(imageUrl)),
              Text(label,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 130,top: 50),
          child: Text(
            "$offer",
            style: TextStyle(color: Colors.green),
          )
        )
      ],
    );
  }
}
