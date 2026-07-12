import 'package:autism_detection/features/auth/domain/entities/user.dart';
import 'package:autism_detection/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<User?> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<User?> call(String name, String email, String password) async {
    return await authRepository.register(name, email, password);
  }
}

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> call() async {
    return await authRepository.logout();
  }
}

class IsLoggedInUseCase {
  final AuthRepository authRepository;

  IsLoggedInUseCase(this.authRepository);

  Future<bool> call() async {
    return await authRepository.isLoggedIn();
  }
}
