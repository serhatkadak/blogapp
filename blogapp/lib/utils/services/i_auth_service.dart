import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<void> saveBlogData(String uid, String title, String content,
      String category, DateTime publishDate, String? imageUrl) async {
    return;
  }

  Future<void> saveFavorite(String uid, String title, String content,
      String category, DateTime publishDate, String imageUrl) async {
    return;
  }
  

  Future<String?> uploadImage(File imageFile);

  Future<void> logOut();
}
