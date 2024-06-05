



import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {


  final _auth = FirebaseAuth.instance;

  Future<dynamic> createUser(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<dynamic> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

}