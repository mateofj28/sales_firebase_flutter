


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthServices {


  final _auth = FirebaseAuth.instance;
  final CollectionReference fireUsuarios = FirebaseFirestore.instance.collection('usuarios');
  late Map<String, dynamic>? _currentUser = {"nombre": "(...)"};

  Map<String, dynamic>? get currentUser => _currentUser;

  Future<dynamic> createUser(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    String userId = credential.user!.uid;

    await fireUsuarios.doc(userId).set({
      "nombre":"",
      "apellido":"",
      "telefono":"",
      "direccion": "",
      "direcciones": [],
      "tipoUsuario":"cliente",
    });
  }

  Future<dynamic> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> getUserInfo(String userId) async {
    DocumentSnapshot documentSnapshot = await fireUsuarios.doc(userId).get();
    
    if (documentSnapshot.exists){
      _currentUser = documentSnapshot.data() as Map<String, dynamic>;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
    } else {
      _currentUser = null;
    }
  }

}