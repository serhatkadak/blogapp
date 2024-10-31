import 'package:blogapp/modules/screens/blog_screen.dart';
import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final AuthService authService = AuthService();

  List<String> listImage = [
    'assets/images/teknoloji.jpg',
    'assets/images/saglik.jpg',
    'assets/images/yasamtarzi.png',
    'assets/images/eglence.png',
    'assets/images/spor.png',
    'assets/images/moda.png',
    'assets/images/egitim.png',
  ];

  List<String> listCategory = [
    'Teknoloji',
    'Sağlık',
    'Yaşam Tarzı',
    'Eğlence',
    'Spor',
    'Moda',
    'Eğitim',
  ];
  Future<void> _veriGetir() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _veriGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("bir hata oluştu"),
            );
          } else {
            return Scaffold(
              backgroundColor: CustomColor.background,
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 260,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: listImage.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    listImage[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 100,
                                      width: double.infinity,
                                      color: Colors.black38,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          "Çok Yakında ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.category,
                                              size: 10.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              listCategory[index],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: listImage.length,
                      effect: ScrollingDotsEffect(
                          activeStrokeWidth: 2.6,
                          activeDotScale: 1.3,
                          maxVisibleDots: 5,
                          radius: 8,
                          spacing: 10,
                          dotHeight: 12,
                          dotWidth: 12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _categoryTitle("İlginizi Çekebilecek Blog Yazıları"),
                    SizedBox(
                      height: 20,
                    ),
                    _buildIcerik(),
                    SizedBox(
                      height: 20,
                    ),
                    _categoryTitle("En Son Eklenen Blog Yazıları"),
                    SizedBox(
                      height: 20,
                    ),
                    _buildIcerik_2()
                  ],
                ),
              )),
            );
          }
        });
  }

  _buildIcerik() {
    return SizedBox(
      height: 300.0,
      child: StreamBuilder<QuerySnapshot>(
          stream: authService.getBlogs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("Henüz blog eklenmedi."));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
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
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    width: 230.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height: 150.0,
                            width: 230.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    blogData['title'],
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    blogData['content'].length > 50
                                        ? blogData['content'].substring(0, 50) +
                                            '...'
                                        : blogData['content'],
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
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
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: blogData['imageUrl'] != null
                                    ? Image.network(blogData['imageUrl'],
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover)
                                    : Icon(Icons.image_not_supported),
                              ),
                              Positioned(
                                left: 10.0,
                                bottom: 10.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.category,
                                          size: 10.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          blogData['category'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  _buildIcerik_2() {
    return StreamBuilder<QuerySnapshot>(
      stream: authService.getAllBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("Henüz blog yok."));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
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
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  blogData['category'] ?? 'Uncategorized',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                      (blogData['publishDate'] as Timestamp)
                                          .toDate()),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
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
    );
  }

  Widget _categoryTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title = title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
