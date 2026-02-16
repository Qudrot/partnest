import 'package:partnest/features/auth/data/models/user_model.dart';

abstract class AuthRepository {

  //Login function that returns user model
  Future<UserModel> login({
    required String email,
    required String password,
  });

  //Registration function that 
  Future<UserModel> signup({
    required String email,
    required String password,
    required String name,
  });

  //Session management function, it check if user exist on app start
  Future<UserModel?> getCurrentUser();

  //Clears token from secure storage
  Future<void> logout();
}