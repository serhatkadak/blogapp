import 'package:blogapp/modules/screens/blog_screen.dart';
import 'package:blogapp/utils/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TechnologyScreen extends StatelessWidget {
  const TechnologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    String category = 'Teknoloji';

    return Scaffold(
      appBar: AppBar(
        title: Text('Teknoloji'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: authService.getCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Henüz blog eklemediniz."));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var blogData = snapshot.data!.docs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogScreen(
                        title: blogData['title'],
                        content: blogData['content'],
                        imageUrl: blogData['imageUrl'] ?? '',
                        publishDate:
                            (blogData['publishDate'] as Timestamp).toDate(),
                        category: blogData['category'] ?? 'Uncategorized',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                          image: blogData['imageUrl'] != null
                              ? DecorationImage(
                                  image: NetworkImage(blogData['imageUrl']),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey[300],
                        ),
                        child: blogData['imageUrl'] == null
                            ? Icon(Icons.image_not_supported, size: 50)
                            : null,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blogData['title'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                blogData['content'],
                                style: TextStyle(color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                    (blogData['publishDate'] as Timestamp)
                                        .toDate()),
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                blogData['category'] ?? 'Uncategorized',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
