import 'package:bloc_pattern/bloc/auth/auth_event.dart';
import 'package:bloc_pattern/bloc/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        print("EMAIL: ${event.email}");
        print("PASSWORD: ${event.password}");
        final response = await authRepository.loginApi(
          body: {
            "email": event.email,
            "password": event.password,
          },
        );
        if (response != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthError(response?.message ?? ''));
        }
      } catch (e) {
        emit(AuthError("Something went wrong"));
      }
    });
  }
}
