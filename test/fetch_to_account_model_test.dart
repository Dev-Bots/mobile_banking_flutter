import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_banking/domain/models/Client.dart';
import 'package:mobile_banking/infrastructure/data_provider/auth/auth.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:mobile_banking/infrastructure/repository/auth/auth.dart';
import 'package:mobile_banking/infrastructure/repository/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fetch_to_account_model_test.mocks.dart';

// @GenerateMocks([http.Client])
// void main() {
//   final baseURL = '10.0.2.2:5000';
//   group(
//       'Testing the data returned from login to appropraite Account model(Admin,Agent,Client',
//       () {
//     test('Returns Client model', () async {
//       {
//         final client = MockClient();
//         final repo = AccountRepository(
//             dataProvider: AccountDataProvider(httpClient: client));
//         when(client.get(Uri.http('$baseURL', '/api/login'))).thenAnswer(
//             (_) async => http.Response(
//                 '{"account_number": 1000000003, "DOB": "date","account_type": "gold","address": "jemo","balance": 203,"email": "new",    "first_name": "kevin","fullname": "kevin sh","id": 3,"is_blocked": false,"last_name": "sh","phone_number": "123456789","registered_by": "1000000002","role": "client",}',
//                 200));
//         expect(await repo.login('username', 'password'), isA<Client>());
//       }
//     });
//   });
// }

// mock testing is not correct, in progress

class MockTransaction extends Mock implements TransactionDataProvider {
  @override
  Future<String> transfer(String recieverAccountNumber, double amount) async {
    var message = await Future.value();
    if (message == null) {
      return "Failed";
    } else {
      return "Success";
    }
  }
}

void main() {
  final MockTransaction mockLogin = MockTransaction();
  final TransactionRepository repo =
      TransactionRepository(dataProvider: mockLogin);
  setUp(() {});
  tearDown(() {});
  test("Transfer", () async {
    when(
      repo
          .transfer('recieverAccountNumber', 1)
          .then((value) => value is Client),
    );

    expect(await repo.transfer('recieverAccountNumber', 1), "Failed");
  });
}
