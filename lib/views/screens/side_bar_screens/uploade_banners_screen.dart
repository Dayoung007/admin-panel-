import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/widget/banner_widget.dart';

class UploadBannersScreen extends StatefulWidget {
  const UploadBannersScreen({super.key});
  static const String routeName = '/uploadBannersScreen';

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;

  String? fileName;

  Future<void> uploadToFireStore() async {
    EasyLoading.show(status: 'loading...');
    if (_image != null) {
      String imageUrl = await _uploadBannersToStorage(_image);

      await _firestore
          .collection('banners')
          .doc(fileName)
          .set({'image': imageUrl}).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
    }
  }

  Future<String> _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  pickImage() async {
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
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'banners',
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
                        borderRadius: BorderRadius.circular(24)),
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                        ),
                        child: const Text('Upload image'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          uploadToFireStore();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Banners',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
          ),
          BannerWidget()
        ],
      ),
    );
  }
}
