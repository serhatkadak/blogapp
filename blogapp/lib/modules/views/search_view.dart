import 'package:blogapp/modules/screens/education_screen.dart';
import 'package:blogapp/modules/screens/entertainment_screen.dart';
import 'package:blogapp/modules/screens/fashion_screen.dart';
import 'package:blogapp/modules/screens/health_screen.dart';
import 'package:blogapp/modules/screens/life_screen.dart';
import 'package:blogapp/modules/screens/sport_screen.dart';
import 'package:blogapp/modules/screens/technology_screen.dart';
import 'package:blogapp/modules/screens/yukleme_screen.dart';
import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/ui/card/bg_title_card.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  Future<void> veriGetir() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return YuklemeSayfasi(
        veriGetir: veriGetir,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              color: CustomColor.background,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kategoriler",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/teknoloji2.jpg',
                        text: "Teknoloji",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnologyScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/saglik2.png',
                        text: "Sağlık",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HealthScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/yasamtarzi2.png',
                        text: "Yaşam Tarzı",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LifeScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/eglence2.png',
                        text: "Eğlence",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EntertainmentScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/spor2.png',
                        text: "Spor",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SportScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/moda.png',
                        text: "Moda",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FashionScreen()));
                        },
                      ),
                      BgTitleCard(
                        imageUrl: 'assets/images/egitim.png',
                        text: "Eğitim",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EducationScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
