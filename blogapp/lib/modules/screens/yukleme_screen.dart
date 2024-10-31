import 'package:flutter/material.dart';

class YuklemeSayfasi extends StatelessWidget {
  final Future<void> Function() veriGetir;
  final Widget child;

  const YuklemeSayfasi(
      {super.key, required this.veriGetir, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: veriGetir(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Bir hata oluştu!"));
        } else {
          return child;
        }
      },
    );
  }
}
