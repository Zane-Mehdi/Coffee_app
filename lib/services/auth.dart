import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetut/models/user.dart';
import 'package:firebasetut/services/database.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usern _userFromFirebaseUser(User user){
    return Usern(uid: user.uid);
  }


  Stream<Usern> get user{
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }


  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user?.uid).updateUserData("0", "new crew member", 700);
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}