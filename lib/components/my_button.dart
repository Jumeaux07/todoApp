import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({ Key? key, required this.text,  required this.onPressed }) : super(key: key);
  final Widget text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child:text,
    );
  }
}