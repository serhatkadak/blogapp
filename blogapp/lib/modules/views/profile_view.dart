import 'dart:async';
import 'package:blogapp/modules/auth/login/login_view.dart';
import 'package:blogapp/modules/screens/account_screen.dart';
import 'package:blogapp/modules/screens/setting_screen.dart';
import 'package:blogapp/modules/screens/yukleme_screen.dart';
import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/services/auth_service.dart';
import 'package:blogapp/utils/ui/card/bg_card.dart';
import 'package:blogapp/utils/ui/sizedbox/bg_sizedbox.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

Future<void> veriGetir() async {
  await Future.delayed(Duration(seconds: 1));
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return YuklemeSayfasi(
        veriGetir: veriGetir,
        child: Scaffold(
          body: Container(
            color: CustomColor.background,
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: [
                  circleAvatar('assets/images/logo.png'),
                  const BgSizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Column(
                    children: [
                      BgCard(
                          text: "Hesap Bilgilerim",
                          icon: Icons.person_2,
                          icon_2: Icons.keyboard_arrow_right_sharp,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountScreen()));
                          }),
                      BgCard(
                          text: "Ayarlar",
                          icon: Icons.settings,
                          icon_2: Icons.keyboard_arrow_right_sharp,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                          }),
                      BgCard(
                        text: "Çıkış Yap",
                        icon: Icons.logout_outlined,
                        icon_2: Icons.keyboard_arrow_right_sharp,
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(16),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Çıkış yapmak istediğinize emin misiniz?',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Hayır',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: CustomColor.text),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await authService.logOut();
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginView()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: CustomColor.accent,
                                          ),
                                          child: Text('Evet',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: CustomColor.text)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ));
  }

  CircleAvatar circleAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 110,
      backgroundColor: CustomColor.primary,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(120),
            child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
