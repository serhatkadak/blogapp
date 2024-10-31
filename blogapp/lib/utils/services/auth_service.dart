import 'dart:io';

import 'package:blogapp/utils/services/i_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  @override
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message as Object);
    }
  }

  @override
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message as Object);
    }
  }

  @override
  Future<void> saveBlogData(String uid, String title, String content,
      String category, DateTime publishDate, String? imageUrl) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('blogs').add({
        'uid': uid,
        'title': title,
        'content': content,
        'category': category,
        'publishDate': Timestamp.fromDate(publishDate),
        'imageUrl': imageUrl,
      });

      print("Blog başarıyla kaydedildi!");
    } catch (e) {
      print("Veri kaydetme hatası: $e");
    }
  }

  @override
  Future<void> saveFavorite(String uid, String title, String content,
      String category, DateTime publishDate, String? imageUrl) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('favorites').add({
        'uid': uid,
        'title': title,
        'content': content,
        'category': category,
        'publishDate': Timestamp.fromDate(publishDate),
        'imageUrl': imageUrl,
      });

      print("Blog başarıyla kaydedildi!");
    } catch (e) {
      print("Veri kaydetme hatası: $e");
    }
  }

  @override
  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('blog_images/$fileName.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Görsel yükleme hatası: $e");
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream<QuerySnapshot> getUserBlogs() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('blogs')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserFavorite() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getBlogs() {
    return FirebaseFirestore.instance.collection('blogs').snapshots();
  }

  Stream<QuerySnapshot> getAllBlogs() {
    return FirebaseFirestore.instance
        .collection('blogs')
        .orderBy('publishDate', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getCategory(String category) {
    return FirebaseFirestore.instance
        .collection('blogs')
        .where('category', isEqualTo: category)
        .snapshots();
  }
}
