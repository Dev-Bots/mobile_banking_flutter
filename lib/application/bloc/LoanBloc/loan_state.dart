part of 'loan_bloc.dart';

abstract class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

class LoanInitial extends LoanState {}

// ================== Client Loan ==========================

class LoanInfoLoading extends LoanState {}

class NoActiveLoans extends LoanState {}

class LoanInfoLoaded extends LoanState {
  final info;

  LoanInfoLoaded({required this.info});
  @override
  List<Object> get props => [info];
}

class LoanInfoLoadingFailed extends LoanState {
  final String errorMsg;

  LoanInfoLoadingFailed({required this.errorMsg});
}

//Request

class LoanRequestProcessing extends LoanState {}

class LoanRequestGranted extends LoanState {
  final message;

  LoanRequestGranted({required this.message});
  @override
  List<Object> get props => [message];
}

class LoanRequestFailed extends LoanState {
  final String errorMsg;

  LoanRequestFailed({required this.errorMsg});
}

// TopUp

class TopUpLoanSuccess extends LoanState {
  final message;

  TopUpLoanSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class TopUpLoanProcessing extends LoanState {}

class TopUpLoanFailed extends LoanState {
  final String errorMsg;

  TopUpLoanFailed({required this.errorMsg});
}

//In full

class LoanInFullPaid extends LoanState {
  final message;

  LoanInFullPaid({required this.message});
  @override
  List<Object> get props => [message];
}

class LoanInFullPayProcessing extends LoanState {}

class LoanInFullPayFailed extends LoanState {
  final String errorMsg;

  LoanInFullPayFailed({required this.errorMsg});
}


//=====================Admin Loan State==================

// We need an endpoint for Admin to show list of active

