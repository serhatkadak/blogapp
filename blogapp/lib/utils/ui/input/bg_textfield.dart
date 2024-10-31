import 'package:blogapp/utils/colors/color.dart';
import 'package:flutter/material.dart';

class BgTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  const BgTextfield({super.key, required this.textEditingController, required this.hintText, this.keyboardType=TextInputType.text,  this.obscureText= false});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: textEditingController,
              keyboardType: keyboardType,
              cursorColor: CustomColor.text,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColor.secondary)
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColor.accent)
                )
              ),
        
            );
  }
}