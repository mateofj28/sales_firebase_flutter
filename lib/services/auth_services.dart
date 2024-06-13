



import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
      
    } else {
      _currentUser = null;
    }
  }

}