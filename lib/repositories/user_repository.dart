import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/network/api_client.dart';

abstract class UserRepository {
  Future<AppUser> getProfile();
}

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<AppUser> getProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    //Mock data
    return AppUser.mockData();
  }
}
