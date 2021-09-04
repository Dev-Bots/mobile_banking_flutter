part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

// +++++++++++++++++++++++ Client Events ++++++++++++++++++++++++++++++++

class ClientTransferButtonPressed extends TransactionEvent {
  final String receiverAccount;
  final double amount;

  ClientTransferButtonPressed(
      {required this.amount, required this.receiverAccount});

  @override
  List<Object> get props => [amount, receiverAccount];

  @override
  String toString() =>
      'ClientTransferButtonPressed { amount: $amount, receiverAccount: $receiverAccount }';
}

class ClientWithdrawButtonPressed extends TransactionEvent {
  final String agentAccount;
  final double amount;

  ClientWithdrawButtonPressed(
      {required this.amount, required this.agentAccount});

  @override
  List<Object> get props => [amount, agentAccount];

  @override
  String toString() =>
      'ClientWithdrawButtonPressed { amount: $amount, agentAccount: $agentAccount }';
}

// +++++++++++++++++++++++ Agent Events ++++++++++++++++++++++++++++++++

class AgentDepositButtonPressed extends TransactionEvent {
  final String clientAccount;
  final double amount;

  AgentDepositButtonPressed(
      {required this.amount, required this.clientAccount});

  @override
  List<Object> get props => [amount, clientAccount];

  @override
  String toString() =>
      'DepositButtonPressed { amount: $amount, clientAccount: $clientAccount }';
}

class AgentTransferButtonPressed extends TransactionEvent {
  final String receiverAccount;
  final double amount;

  AgentTransferButtonPressed(
      {required this.amount, required this.receiverAccount});

  @override
  List<Object> get props => [amount, receiverAccount];

  @override
  String toString() =>
      'AgentToClientTransferButtonPressed { amount: $amount, receiverAccount: $receiverAccount }';
}

class AgentWithdrawButtonPressed extends TransactionEvent {
  final String adminAccount;
  final double amount;

  // AgentWithdrawButtonPressed(
  //     {required this.amount, required this.agentAccount});

  AgentWithdrawButtonPressed(
      {required this.amount,
      this.adminAccount = '1001'}); // Since central account is the same

  @override
  List<Object> get props => [amount, adminAccount];

  @override
  String toString() =>
      'AgentWithdrawButtonPressed { amount: $amount, agentAccount: $adminAccount }';
}

// +++++++++++++++++++++++ Admin Events ++++++++++++++++++++++++++++++++

class AdminDepositButtonPressed extends TransactionEvent {
  final String agentAccount;
  final double amount;

  AdminDepositButtonPressed({required this.amount, required this.agentAccount});

  @override
  List<Object> get props => [amount, agentAccount];

  @override
  String toString() =>
      'DepositButtonPressed { amount: $amount, clientAccount: $agentAccount }';
}
