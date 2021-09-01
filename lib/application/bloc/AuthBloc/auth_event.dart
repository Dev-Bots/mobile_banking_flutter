part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetMyAccount extends AuthEvent {
  @override
  List<Object> get props => [];
}

class GetAccount extends AuthEvent {
  final accountNumber;

  GetAccount({required this.accountNumber});

  @override
  List<Object> get props => [accountNumber];
}

class RegisterAgent extends AuthEvent {
  final Agent agent;

  RegisterAgent({required this.agent});

  @override
  List<Object> get props => [agent];
}

class RegisterClient extends AuthEvent {
  final Client client;

  RegisterClient({required this.client});

  @override
  List<Object> get props => [client];
}

class ChangePassword extends AuthEvent {
  final String password;

  ChangePassword({required this.password});

  @override
  List<Object> get props => [password];
}

class SaveAccount extends AuthEvent {
  final accountNumber;

  SaveAccount({required this.accountNumber});

  @override
  List<Object> get props => [accountNumber];
}

class RemoveFromSaved extends AuthEvent {
  final accountNumber;

  RemoveFromSaved({required this.accountNumber});

  @override
  List<Object> get props => [accountNumber];
}

class BlockUnblock extends AuthEvent {
  final accountNumber;

  BlockUnblock({required this.accountNumber});

  @override
  List<Object> get props => [accountNumber];
}

class ChangeAccountType extends AuthEvent {
  final int accountType;
  final accountNumber;

  ChangeAccountType({required this.accountNumber, required this.accountType});

  @override
  List<Object> get props => [accountNumber, accountType];
}

class GetGeneralReport extends AuthEvent {}
