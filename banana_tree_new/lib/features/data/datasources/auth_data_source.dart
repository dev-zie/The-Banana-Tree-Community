import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthDataSource> authDataSource = ValueNotifier(AuthDataSource());

class AuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required String username,
  }) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = firebaseAuth.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'username': username,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<String?> getUsername() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null; // kullanıcı login değilse
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      return doc['username'] as String;
    }
    return null;
  }

  
}
