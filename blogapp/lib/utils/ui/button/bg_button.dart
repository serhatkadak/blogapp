import 'dart:io';
import 'package:blogapp/utils/colors/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BgButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressed;
  const BgButton({super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return CupertinoButton(
      color: CustomColor.accent,  
      onPressed: onPressed,
      child: Text(buttonTitle),);
    }
    else {
      return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.accent
      ),
    onPressed: onPressed, child: Text(buttonTitle,style: TextStyle(color: CustomColor.primary,fontSize: 15)));
    }
  }

}