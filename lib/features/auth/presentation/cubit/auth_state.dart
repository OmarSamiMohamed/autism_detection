import 'package:autism_detection/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading() : super();
}

class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess({required this.user}) : super();

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut() : super();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated() : super();
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated() : super();
}
