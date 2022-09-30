import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

//FIRST STEP

//creating first class
@immutable
class AuthUser {
  final bool isEmailVerified;

  //empty method of a class that takes a boolean as arguments.
  const AuthUser({required this.isEmailVerified});

  //fill in the empty method with the firebase function that tweak something
  //in the user variable and return that variable with the type AuthUser.
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
