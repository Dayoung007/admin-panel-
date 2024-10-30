import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({super.key});
  final Stream<QuerySnapshot> _banners =
      FirebaseFirestore.instance.collection('banners').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _banners,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }

        return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              final bannerData = snapshot.data!.docs[index];
              return Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      bannerData['image'],
                    ),
                  ),
                  // Text(categoryData['categoryName'])
                ],
              );
            });
      },
    );
  }
}
