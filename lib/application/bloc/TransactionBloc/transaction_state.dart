part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

// +++++++++++++++++++++++ Client States ++++++++++++++++++++++++++++++++

// ==================Client Transfer States=================

class ClientTransferProcessing extends TransactionState {}

class ClientTransferSuccess extends TransactionState {
  final String transferMessage;

  ClientTransferSuccess({required this.transferMessage});
  @override
  List<Object> get props => [transferMessage];
}

class ClientTransferFailure extends TransactionState {
  final String error;

  const ClientTransferFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'ClientTransferFailure { error: $error }';
}

// ==================Client Withdraw States======================

class ClientWithdrawProcessing extends TransactionState {}

class ClientWithdrawSuccess extends TransactionState {
  final withdrawMessage;

  ClientWithdrawSuccess({required this.withdrawMessage});
  @override
  List<Object> get props => [withdrawMessage];
}

class ClientWithdrawFailure extends TransactionState {
  final String error;

  const ClientWithdrawFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'ClientWithdrawFailure { error: $error }';
}

// +++++++++++++++++++++++ Agent States ++++++++++++++++++++++++++++++++

// ==================Agent Deposit States======================

class AgentDepositProcessing extends TransactionState {}

class AgentDepositSuccess extends TransactionState {
  final String depositMessage;

  AgentDepositSuccess({required this.depositMessage});
  @override
  List<Object> get props => [depositMessage];
}

class AgentDepositFailure extends TransactionState {
  final String error;

  const AgentDepositFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'AgentDepositFailure { error: $error }';
}

// ==================Agent Withdraw States======================

class AgentWithdrawProcessing extends TransactionState {}

class AgentWithdrawSuccess extends TransactionState {
  final withdrawMessage;

  AgentWithdrawSuccess({required this.withdrawMessage});
  @override
  List<Object> get props => [withdrawMessage];
}

class AgentWithdrawFailure extends TransactionState {
  final String error;

  const AgentWithdrawFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'ClientWithdrawFailure { error: $error }';
}

// +++++++++++++++++++++++ Admin States ++++++++++++++++++++++++++++++++

// ==================Admin Deposit States======================

class AdminDepositProcessing extends TransactionState {}

class AdminDepositSuccess extends TransactionState {
  final String depositMessage;

  AdminDepositSuccess({required this.depositMessage});
  @override
  List<Object> get props => [depositMessage];
}

class AdminDepositFailure extends TransactionState {
  final String error;

  const AdminDepositFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'AdminDepositFailure { error: $error }';
}
