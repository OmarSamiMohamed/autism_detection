import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user?.updateDisplayName(name);
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      final token = await credential.user!.getIdToken();
      return token;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}");
      return null;
    } catch (e) {
      print("Register Error: $e");
      return null;
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await credential.user!.getIdToken();
      return token;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}");
      return null;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    // Google Sign In implementation
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>?> signInWithFacebook() async {
    // Facebook Sign In implementation
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
