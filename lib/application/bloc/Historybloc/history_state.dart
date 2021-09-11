part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final transactionHistorys;

  HistoryLoaded([this.transactionHistorys = const []]);

  @override
  List<Object> get props => [transactionHistorys];
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object> get props => [message];
}
