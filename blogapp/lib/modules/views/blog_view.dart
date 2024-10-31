import 'dart:io';
import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/services/auth_service.dart';
import 'package:blogapp/utils/ui/button/bg_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  XFile? _imageFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final AuthService authService = AuthService();
  final TextEditingController _textEditingController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  final List<String> catagory = [
    'Teknoloji',
    'Sağlık',
    'Yaşam Tarzı',
    'Eğlence',
    'Spor',
    'Moda',
    'Eğitim',
  ];
  String? selectedCatagory;
  final TextEditingController _catagoryController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _textEditingController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: CustomColor.background,
        title: const Text('Fotoğraf Yükleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pickImage(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Blog Başlığınızı Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Blog Yazınını Giriniz...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Tarih Giriniz',
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_month),
                    ),
                  ),
                  readOnly: true,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton<String>(
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                        hint: Text('Kategori Seçiniz'),
                        value: selectedCatagory,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        underline: SizedBox(),
                        items: catagory.map((String fruit) {
                          return DropdownMenuItem<String>(
                            value: fruit,
                            child: Text(fruit),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCatagory = newValue;
                            _catagoryController.text = newValue ?? '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: BgButton(
                  onPressed: () async {
                    if (_imageFile != null) {
                      String? imageUrl =
                          await authService.uploadImage(File(_imageFile!.path));
                
                      if (imageUrl != null) {
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                
                        await authService.saveBlogData(
                          uid,
                          _titleController.text,
                          _descriptionController.text,
                          selectedCatagory ?? 'Kategori Seçilmedi',
                          selectedDate ?? DateTime.now(),
                          imageUrl,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Blog başarıyla yüklendi!')),
                        );
                
                        setState(() {
                          _textEditingController.clear();
                          _titleController.clear();
                          _catagoryController.clear();
                          _descriptionController.clear();
                          _imageFile = null;
                          selectedCatagory = null;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Görsel yüklenemedi!')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lütfen bir görsel seçin!')),
                      );
                    }
                  },
                  buttonTitle: 'Kaydet',
                 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector pickImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: _imageFile != null
            ? Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(_imageFile!.path)),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo,
                      size: 48,
                      color: Colors.black54,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Fotoğraf Seçin',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
