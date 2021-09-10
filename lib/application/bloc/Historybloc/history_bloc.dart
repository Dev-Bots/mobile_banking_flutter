import 'dart:async';
// import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_banking/domain/models/TransactionHistory.dart';
import 'package:mobile_banking/infrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/infrastructure/repository/transaction/TransactionRepository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final TransactionRepository transactionRepository;

  HistoryBloc({required this.transactionRepository}) : super(HistoryLoading());

  // HistoryBloc() : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is GetTransactionsList) {
      try {
        yield HistoryLoading();
        final transactionHistorys =
            await transactionRepository.getTransactions();
        yield HistoryLoaded(transactionHistorys);
      } on NetworkError {
        yield HistoryError("Failed to fetch data. is your device online?");
      }
    }
  }
}
