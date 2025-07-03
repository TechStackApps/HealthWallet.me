import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String photoUrl,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isDarkMode,
  }) = _User;
}
