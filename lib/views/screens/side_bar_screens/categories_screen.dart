import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/widget/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const String routeName = '/categoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;
  String? fileName;
  late String categoryName;

  Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('categoriesImages').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadCategory() async {
    EasyLoading.show(status: 'loading...');
    if (_formKey.currentState!.validate()) {
      String imageUrl = await _uploadCategoryBannerToStorage(_image);
      await _firestore.collection('categories').doc(fileName!).set({
        'image': imageUrl,
        'categoryName': categoryName,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
          _formKey.currentState!.reset();
        });
      });
    } else {
      print('Bad');
    }
  }

  _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(14),
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        border: Border.all(color: Colors.black12, width: 2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                _image!,
                                fit: BoxFit.cover,
                                height: 140,
                                width: 140,
                              ),
                            )
                          : const Center(child: Text('Banner')),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                      ),
                      child: const Text('Upload image'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'category name must not be empty';
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter categories'), hintText: 'Enter category name'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    uploadCategory();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Categories',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            CategoryWidget()
          ],
        ),
      ),
    );
  }
}
