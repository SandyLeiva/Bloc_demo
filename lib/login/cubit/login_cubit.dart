import 'package:bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login(String username, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(const Duration(seconds: 1)); // Simula retraso de red

    if (username == 'admin' && password == '1234') {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: 'Credenciales incorrectas'));
    }
  }
}