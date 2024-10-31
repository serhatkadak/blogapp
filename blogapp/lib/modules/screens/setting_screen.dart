import 'package:blogapp/utils/colors/color.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: CustomColor.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left_outlined),
        ),
        leadingWidth: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Setting",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            buildSetting("Dil Seçiniz", "Türkçe"),
            buildSetting("Bildirimler", " "),
            buildSetting("Destek", " "),
            buildSetting("Gizlilik Politikası", " ")
          ],
        ),
      ),
    );
  }

  Container buildSetting(String title, String text) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: CustomColor.primary),
            child: Icon(
              Icons.settings,
              color: CustomColor.accent,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: CustomColor.secondary),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColor.primary,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                ),
              ))
        ],
      ),
    );
  }
}
