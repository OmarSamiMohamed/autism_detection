import 'package:bloc/bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../features/auth/domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
  }) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'فشل تسجيل الدخول. تحقق من البيانات.'));
      }
    } on Failure catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ أثناء تسجيل الدخول'));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await registerUseCase(name, email, password);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'فشل التسجيل. حاول مرة أخرى.'));
      }
    } on Failure catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ أثناء التسجيل'));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await logoutUseCase();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ أثناء تسجيل الخروج'));
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      final isLoggedIn = await isLoggedInUseCase();
      if (isLoggedIn) {
        // Get user from storage or navigate to home
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }
}
