part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoggingSuccess extends LoginState {
  final user;

  LoggingSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

// =====================================



// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class LoginInprogress extends AuthState {}

// class LoggedIn extends AuthState {}

// class LoggedOut extends AuthState {}

// class AuthFailed extends AuthState {
//   final String errorMsg;

//   AuthFailed({required this.errorMsg});
// }
