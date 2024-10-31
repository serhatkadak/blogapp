import 'package:blogapp/modules/views/blog_view.dart';
import 'package:blogapp/modules/views/favorite_view.dart';
import 'package:blogapp/modules/views/home_view.dart';
import 'package:blogapp/modules/views/profile_view.dart';
import 'package:blogapp/modules/views/search_view.dart';
import 'package:blogapp/utils/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int _currentIndex = 0;

  
  final _items = [
    SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text('Ana Sayfa'),
        selectedColor: CustomColor.text),
    SalomonBottomBarItem(
        icon: const Icon(Icons.favorite),
        title: const Text('Kitaplık'),
        selectedColor: CustomColor.text),
    SalomonBottomBarItem(
      icon: FloatingActionButton(
        onPressed: null,
        backgroundColor: CustomColor.accent,
        foregroundColor: Colors.white,
        elevation: 2,
        child: Icon(Icons.add),
        
    
        
      ),
      title: const Text(""),
    ),
    SalomonBottomBarItem(
        icon: const Icon(Icons.search),
        title: const Text('Katagoriler'),
        selectedColor: CustomColor.text),
    SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: const Text('Profil'),
        selectedColor: CustomColor.text),
  ];

  final _screens = [
    const HomeView(),
    FavoriteView(),
    const BlogView() ,
    const SearchView(),
    const ProfileView()
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      body: _screens[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Card _bottomNavigationBar() {
    return Card(
      color: CustomColor.primary,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 10),
      child: SalomonBottomBar(
        items: _items,
        currentIndex: _currentIndex,
        duration: const Duration(seconds: 1),
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}
