import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = Provider.autoDispose(
  (ref) => AuthController(ref),
);

class AuthController {
  final Ref ref;
  AuthController(this.ref);

  Future<void> login(String email, String password) async {
    // TODO: Replace with actual Firebase Auth logic
    print("Logging in with: $email & $password");
  }

  Future<void> loginWithGoogle() async {
    // TODO: Replace with Google Sign-In logic
    print("Google Sign-In initiated");
  }
}
