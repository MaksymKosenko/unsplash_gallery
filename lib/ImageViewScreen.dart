import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  final String link;
  ImageViewScreen({String link}): link = link;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: GestureDetector(
          child: Image.network(
            link,
            fit: BoxFit.contain,
          ),
          onTap: ()=> Navigator.pop(context),
        ),
    );
  }
}

