import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addtoSaved(
      {User? user, required QueryDocumentSnapshot data}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('Saved')
        .doc(data.id)
        .set({
      'newsHeadline': data.get('newsHeadline'),
      'newsUploadTime': data.get('newsUploadTime'),
      'timestamp': data.get('timestamp'),
      'saved': true,
      'thumbnail': data.get('thumbnail'),
      'category': data.get('category'),
      'docName': data.get('docName'),
      'headline Category': data.get('headline Category'),
      'linkURL': data.get('linkURL'),
      'bodyImage 1': data.get('bodyImage 1'),
      'bodyImage 2': data.get('bodyImage 2'),
      'newsBody 1': data.get('newsBody 1'),
      'newsBody 2': data.get('newsBody 2'),
      'newsBody 3': data.get('newsBody 3'),
      'newsBody 4': data.get('newsBody 4'),
      'newsBody 5': data.get('newsBody 5'),
      'newsBody 6': data.get('newsBody 6'),
    });
  }

  Future<void> addtoFavorites(
      {User? user, required QueryDocumentSnapshot data}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(data.id)
        .set({
      'newsHeadline': data.get('newsHeadline'),
      'newsUploadTime': data.get('newsUploadTime'),
      'timestamp': data.get('timestamp'),
      'favorite': true,
      'thumbnail': data.get('thumbnail'),
      'category': data.get('category'),
      'docName': data.get('docName'),
      'headline Category': data.get('headline Category'),
      'linkURL': data.get('linkURL'),
      'bodyImage 1': data.get('bodyImage 1'),
      'bodyImage 2': data.get('bodyImage 2'),
      'newsBody 1': data.get('newsBody 1'),
      'newsBody 2': data.get('newsBody 2'),
      'newsBody 3': data.get('newsBody 3'),
      'newsBody 4': data.get('newsBody 4'),
      'newsBody 5': data.get('newsBody 5'),
      'newsBody 6': data.get('newsBody 6'),
    });
  }

  Future<void> removeFromSaved({User? user, String? docID}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('Saved')
        .doc(docID)
        .delete();
  }

  Future<void> removeFromFavorites({User? user, String? docID}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(docID)
        .delete();
  }

  Future<void> addtoHistory(
      {User? user, required QueryDocumentSnapshot data}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('History')
        .doc(data.id)
        .set({
      'newsHeadline': data.get('newsHeadline'),
      'newsUploadTime': data.get('newsUploadTime'),
      'timestamp': data.get('timestamp'),
      'saved': true,
      'thumbnail': data.get('thumbnail'),
      'category': data.get('category'),
      'docName': data.get('docName'),
      'headline Category': data.get('headline Category'),
      'linkURL': data.get('linkURL'),
      'bodyImage 1': data.get('bodyImage 1'),
      'bodyImage 2': data.get('bodyImage 2'),
      'newsBody 1': data.get('newsBody 1'),
      'newsBody 2': data.get('newsBody 2'),
      'newsBody 3': data.get('newsBody 3'),
      'newsBody 4': data.get('newsBody 4'),
      'newsBody 5': data.get('newsBody 5'),
      'newsBody 6': data.get('newsBody 6'),
    });
  }

  Future<void> clearHistory({User? user}) async {
    await _db
        .collection('Users')
        .doc(user!.uid)
        .collection('History')
        .get()
        .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        });
  }
}
