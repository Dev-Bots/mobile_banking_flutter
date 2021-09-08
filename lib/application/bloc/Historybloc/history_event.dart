part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsList extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class DeleteTransaction extends HistoryEvent {
  final int transactionId;

  DeleteTransaction({required this.transactionId});

  @override
  List<Object> get props => [transactionId];

  @override
  String toString() => 'DeleteTransaction {transactionId: $transactionId }';
}
