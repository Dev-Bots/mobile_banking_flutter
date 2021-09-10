import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/domain/models/TransactionHistory.dart';
import 'package:mobile_banking/infrastructure/data_provider/loan/loanProvider.dart';

class LoanRepository {
  final LoanDataProvider dataProvider;

  LoanRepository({required this.dataProvider});

  Future getLoanInfo() async {
    return await dataProvider.getLoanInfo();
  }

  Future takeLoan(double amount) async {
    return await dataProvider.takeLoan(amount);
  }

  Future loanTopUp(double amount) async {
    return await dataProvider.loanTopUp(amount);
  }

  Future loanPayInFull() async {
    return await dataProvider.loanPayInFull();
  }
}

// class NetworkError extends Error {}
