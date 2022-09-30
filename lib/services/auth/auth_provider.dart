import 'package:mynotes2/services/auth/auth_user.dart';

//SECOND STEP

//create another class with the first class in it PLUS some empty properties and empty methods.
abstract class AuthProvider {
  //first class.
  AuthUser? get currentUser;

  //empty methods
  Future<void> initialize();

  //empty methods with required empty paramaters inside AND WILL RETURN AuthUser TYPE.
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  //empty methods with required empty paramaters inside AND WILL RETURN AuthUser TYPE.
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  //both of these are empty methods.
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
