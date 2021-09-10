import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  // final AccountRepository accountRepository;

  final LoanRepository loanRepository;

  LoanBloc({required this.loanRepository}) : super(LoanInfoLoading());

  @override
  Stream<LoanState> mapEventToState(
    LoanEvent event,
  ) async* {
    // ==================GetLoanInfo===============================
    if (event is GetLoanInfo) {
      yield LoanInfoLoading();

      try {
        var info = await loanRepository.getLoanInfo();

        if (info != null) {
          yield LoanInfoLoaded(info: info);
        } else if (info.toString() == 'No active loans.') {
          print('Its here');
          yield NoActiveLoans();
        } else {
          yield LoanInfoLoadingFailed(errorMsg: "Failed to load.");
        }
      } catch (error) {
        yield LoanInfoLoadingFailed(errorMsg: error.toString());
      }
    }
    // ==================LoanRequest===============================
    if (event is LoanRequest) {
      final amount = event.amount;

      yield LoanRequestProcessing();

      try {
        var loan = await loanRepository.takeLoan(amount);
        print('$amount');
        print(loan);

        if (loan != null) {
          yield LoanRequestGranted(message: loan);
        } else {
          yield LoanRequestFailed(
              errorMsg: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield LoanRequestFailed(errorMsg: error.toString());
      }
    }
    // ==================TopUp loan===============================
    if (event is TopUpLoan) {
      final amount = event.amount;

      yield TopUpLoanProcessing();

      try {
        var loan = await loanRepository.loanTopUp(amount);
        print('$amount');
        print(loan);

        if (loan != null) {
          yield TopUpLoanSuccess(message: loan);
        } else {
          yield TopUpLoanFailed(
              errorMsg: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield TopUpLoanFailed(errorMsg: error.toString());
      }
    }

    // ==================PayLoanInfull===============================

    if (event is PayLoanInfull) {
      yield TopUpLoanProcessing();

      try {
        var loan = await loanRepository.loanPayInFull();

        print(loan);

        if (loan != null) {
          yield LoanInFullPaid(message: loan);
        } else {
          yield LoanInFullPayFailed(
              errorMsg: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield LoanInFullPayFailed(errorMsg: error.toString());
      }
    }
  }
}
