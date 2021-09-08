part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// getCurrentUser GetMyAccount
class AccountLoading extends AuthState {}

class AccountLoaded extends AuthState {
  final user;

  AccountLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class AccountFailed extends AuthState {
  final String error;

  const AccountFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AccountFailure { error: $error }';
}

// ###################################

class Proccessing extends AuthState {
  final message;

  const Proccessing({required this.message});

  @override
  List<Object> get props => [message];
}

class ProccessFinished extends AuthState {
  final message;

  const ProccessFinished({required this.message});

  @override
  List<Object> get props => [message];
}

class ProccessFailed extends AuthState {
  final String error;

  const ProccessFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request failure { error: $error }';
}

class ReportLoaded extends AuthState {
  final report;

  ReportLoaded({required this.report});
  @override
  List<Object> get props => [report];
}
