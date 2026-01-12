part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String email,
    required String passwordHash,
  }) = _Login;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.register({
    required String username,
    required String email,
    required String passwordHash,
  }) = _Register;
  const factory AuthEvent.loadUser() = _LoadUser;
}
