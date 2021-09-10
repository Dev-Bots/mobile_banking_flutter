import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/domain/models/TransactionHistory.dart';
import 'package:mobile_banking/infrastructure/data_provider/transaction/transactionProvider.dart';

class TransactionRepository {
  final TransactionDataProvider dataProvider;

  TransactionRepository({required this.dataProvider});

  Future getTransactions() async {
    return await dataProvider.getTransactions();
  }

  Future transfer(String recieverAccountNumber, double amount) async {
    return await dataProvider.transfer(recieverAccountNumber, amount);
  }

  Future withdraw(String recieverAccountNumber, double amount) async {
    return await dataProvider.withdraw(recieverAccountNumber, amount);
  }

  Future depositToClient(String recieverAccountNumber, double amount) async {
    return await dataProvider.depositToClient(recieverAccountNumber, amount);
  }

  Future depositToAgent(String recieverAccountNumber, double amount) async {
    return await dataProvider.depositToAgent(recieverAccountNumber, amount);
  }

  Future agentWithdraw(String recieverAccountNumber, double amount) async {
    return await dataProvider.agentWithdraw(recieverAccountNumber, amount);
  }

  Future agentPayment() async {
    return await dataProvider.agentPayment();
  }

  Future transactionDelete(int transactionId) async {
    return await dataProvider.transactionDelete(transactionId);
  }
}

// class NetworkError extends Error {}
