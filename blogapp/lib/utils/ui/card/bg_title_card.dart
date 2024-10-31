import 'package:blogapp/utils/colors/color.dart';
import 'package:flutter/material.dart';

class BgTitleCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String imageUrl;

  const BgTitleCard({
    super.key,
    required this.text,
    required this.onTap, required this.imageUrl,
  });

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
        onTap: onTap,
        child: Stack(
          children: [
             
            ClipRRect(
              borderRadius: BorderRadius.vertical(top:Radius.circular(15) ,bottom: Radius.circular(15)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,  
              ),
            ),
             
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                   color: Colors.black26,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white, // Beyaz font rengi
                      fontWeight: FontWeight.bold, // Metin kalın
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
