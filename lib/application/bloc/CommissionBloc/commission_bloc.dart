import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';

part 'commission_event.dart';
part 'commission_state.dart';

class CommissionBloc extends Bloc<CommissionEvent, CommissionState> {
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  CommissionBloc(
      {required this.transactionRepository, required this.accountRepository})
      : super(CommissionLoading());
  @override
  Stream<CommissionState> mapEventToState(
    CommissionEvent event,
  ) async* {
    if (event is RequestPayment) {
      yield CommissionPayProcessing();

      try {
        var pay = await transactionRepository.agentPayment();

        print(pay);

        if (pay != null) {
          yield CommissionPaySuccess(message: pay);
        } else {
          yield CommissionPayFailure(
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield CommissionPayFailure(error: error.toString());
      }
    }
  }
}
