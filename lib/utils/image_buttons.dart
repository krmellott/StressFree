import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  ImageButton extends StatelessWidget {
  final String label;
  final String image;
  final Function() onTap;
  const ImageButton({Key? key, required this.label, required this.onTap, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Ink.image(
            image: NetworkImage(image),
            height: 240,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: onTap,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white
            ),
          )
        ]
      ),
    );
  }
}
