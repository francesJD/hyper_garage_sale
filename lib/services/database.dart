import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyper_garage_sale/models/posts.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('jingmin-posts');

  Future updateUserData(String title, int price, String description,
      List<String> imageUrls) async {
    return await itemCollection.doc(uid).set({
      'title': title,
      'price': price,
      'description': description,
      'imageUrls': imageUrls
    });
  }

  //posts list from snapshot
  List<Post> _postListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc) {
        return Post(
          title: doc['title'] ?? '',
          price: doc['price'] ?? 0,
          description: doc['description'] ?? '',
          images: doc['imageUrls'].cast<String>() ?? [],
        );
      },
    ).toList();
  }

  // get posts stream
  Stream<List<Post>> get posts {
    return itemCollection.snapshots().map(_postListFormSnapshot);
  }
}
