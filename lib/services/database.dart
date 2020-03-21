import 'package:boba_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boba_crew/models/boba.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference bobaCollection =
      Firestore.instance.collection('bobas');

  Future updateUserData(String name, int iceLevel, int sweetLevel) async {
    return await bobaCollection.document(uid).setData({
      'iceLevel': iceLevel,
      'name': name,
      'sweetLevel': sweetLevel,
    });
  }

  // Get Boba list from snapshot
  List<Boba> _bobaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Boba(
        name: doc.data['name'] ?? '',
        iceLevel: doc.data['iceLevel'] ?? 100,
        sweetLevel: doc.data['sweetLevel'] ?? 100,
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sweetLevel: snapshot.data['sweetLevel'],
      iceLevel: snapshot.data['iceLevel'],
    );
  }

  // Set up new stream for boba data
  Stream<List<Boba>> get bobas {
    return bobaCollection.snapshots().map(_bobaListFromSnapshot);
  }

  // Get user document stream (used to prepopulate boba data)
  Stream<UserData> get userData {
    return bobaCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
