import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository({FirebaseAuth firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String> attemptAutoLogin() async {
    if (await isSignedIn()) {
      return getUser();
    } else
      throw Exception('not signed in');

    // await Future.delayed(Duration(seconds: 3));
  }

  Future<String> login(
      {@required String userName, @required String password}) async {
    print("Attempting to login...");
    await Future.delayed(Duration(seconds: 3));
    return 'Login status';
  }

  Future<String> signUp(
      {@required String email, @required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential.user.refreshToken;
  }

  Future<String> signWithCredentials(
      {@required String email, @required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user.refreshToken;
  }

  Future<bool> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return firebaseAuth.currentUser.refreshToken;
  }

  Future<String> confirmSignUp({
    @required String userName,
    @required String confirmationCode,
  }) async {
    await Future.delayed(Duration(seconds: 3));
    return 'confirm';
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
    // await Future.delayed(Duration(seconds: 2));
    // return Future.wait([
    //   _firebaseAuth.signOut(),
    //   _googleSignIn.signOut(),
    // ]);
  }
}
