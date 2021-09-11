part of 'loan_bloc.dart';

abstract class LoanEvent extends Equatable {
  const LoanEvent();

  @override
  List<Object> get props => [];
}

// ===============Getting Info==============================

class GetLoanInfo extends LoanEvent {}

// ================Request=============================

class LoanRequest extends LoanEvent {
  final double amount;

  LoanRequest({required this.amount});
}

// class ViewLoanInfo extends LoanEvent {}

// ===================Payment============================

class TopUpLoan extends LoanEvent {
  final double amount;

  TopUpLoan({required this.amount});
}

class PayLoanInfull extends LoanEvent {}
