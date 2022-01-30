import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetut/models/brew.dart';
import 'package:firebasetut/models/user.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugar':sugars,
      'name':name,
      "strength":strength
    });
  }

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
          name: doc['name'] ?? "",
          strength: doc['strength']?? 0,
          sugar: doc['sugar']?? 0);
    }).toList();

  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(uid: uid,
        sugars: snapshot['sugar'],
        name: snapshot['name'],
        strength: snapshot['strength']);
  }

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
        .map(_brewListFromSnapShot);
  }

  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}