import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> get user async => await _firebaseAuth.currentUser();

  Future<String> login(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = result.user;
    return user.uid;
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }
}
