import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/domain/entities/user/user_entity.dart';
import 'package:todo_app/domain/repositories/auth_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<_Login>(_onLogin);
    on<_Register>(_onRegister);
    on<_Logout>(_onLogout);
    on<_LoadUser>(_onLoadUser);
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final result = await _repository.login();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (user) => emit(AuthState.authenticated(user)),
      );
    } catch (e, s) {
      emit(AuthState.error('Login with Google failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onRegister(_Register event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
      final result = await _repository.register(
        username: event.username,
        email: event.email,
        passwordHash: event.passwordHash,
      );
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (_) => emit(const AuthState.success()),
      );
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final result = await _repository.logout();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (_) => emit(const AuthState.success()),
      );
    } catch (e, s) {
      emit(AuthState.error('Logout failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onLoadUser(_LoadUser event, Emitter<AuthState> emit) async {
    // final fbUser = FirebaseAuth.instance.currentUser;
    // if (fbUser != null) {
    //   emit(
    //     AuthState.authenticated(
    //       UserEntity(
    //         id: fbUser.uid,
    //         name: fbUser.displayName ?? "",
    //         email: fbUser.email ?? "",
    //         photoUrl: fbUser.photoURL ?? "",
    //         national: "",
    //       ),
    //     ),
    //   );
    // } else {
    //   emit(const AuthState.loggedOut());
    // }
  }
}
