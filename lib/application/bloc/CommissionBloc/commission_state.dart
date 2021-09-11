part of 'commission_bloc.dart';

abstract class CommissionState extends Equatable {
  const CommissionState();

  @override
  List<Object> get props => [];
}

class CommissionInitial extends CommissionState {}

// getCurrentUser GetMyAccount
class CommissionLoading extends CommissionState {}

class CommissionLoaded extends CommissionState {
  final agent;

  CommissionLoaded({required this.agent});
  @override
  List<Object> get props => [agent];
}

class CommissionLoadFailed extends CommissionState {
  final String error;

  const CommissionLoadFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CommissionLoadFailed { error: $error }';
}

// ================= Pay Pressed States=============================

class CommissionPayProcessing extends CommissionState {}

class CommissionPaySuccess extends CommissionState {
  final message;

  CommissionPaySuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class CommissionPayFailure extends CommissionState {
  final String error;

  const CommissionPayFailure({required this.error});

  @override
  List<Object> get props => [error];
//
  @override
  String toString() => 'CommissionFailure { error: $error }';
}
