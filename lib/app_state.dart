import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  User? _user;
  User? get user => _user;

  void init() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get loggedIn => _user != null;

  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut(); 
  }

}
