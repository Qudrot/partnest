import 'package:partnest/features/auth/data/models/user_model.dart';

class MockAuthRepository {
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    //Mock success or failure
    if (email == "testing.com" && password == "1234") {
      return UserModel(
        id: "R123",
        email: "testing.com",
        name: "Kudirat",
        role: UserRole.admin,
        profilePicture: "",
      );
    } else {
      throw Exception("Password and email did not match"); //Mock error
    }
  }
}
