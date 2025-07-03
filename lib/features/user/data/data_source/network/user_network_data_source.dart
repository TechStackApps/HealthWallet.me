import 'package:health_wallet/core/services/network/rest_api_service.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';

abstract class UserNetworkDataSource {
  Future<UserDto> fetchUser();
  Future<UserDto> updateUser(UserDto userDto);
  Future<void> deleteUser();
  Future<void> updateProfilePicture(String photoUrl);
  Future<void> verifyEmail();
}

@Injectable(as: UserNetworkDataSource)
class UserNetworkDataSourceImpl implements UserNetworkDataSource {
  UserNetworkDataSourceImpl(this._apiService);

  final RestApiService _apiService;

  @override
  Future<UserDto> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const UserDto(
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      photoUrl: 'https://picsum.photos/200',
      isEmailVerified: false,
    );
  }

  @override
  Future<UserDto> updateUser(UserDto user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return user;
  }

  @override
  Future<void> deleteUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateProfilePicture(String photoUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> verifyEmail() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
