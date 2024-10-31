import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/ui/sizedbox/bg_sizedbox.dart';
import 'package:flutter/material.dart';

class BgCard extends StatelessWidget {
  final IconData icon;
  final IconData icon_2;
  final String text;
  final VoidCallback onTap;
  const BgCard(
      {super.key,
      required this.text,
      required this.icon,
      required this.icon_2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColor.primary,
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon,color: CustomColor.accent,),
              const BgSizedBox(
                width: 20,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
              const BgSizedBox(
                width: 20,
              ),
              Icon(icon_2,color: CustomColor.accent)
            ],
          ),
        ),
      ),
    );
  }
}
