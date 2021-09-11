import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/application/bloc/CommissionBloc/commission_bloc.dart';
import 'package:mobile_banking/application/bloc/LoanBloc/loan_bloc.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_banking/presentation/screens/agent_pages/agent_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_pages_frame.dart';

class RequestPay extends StatelessWidget {
  RequestPay({Key? key}) : super(key: key);

  final repo = TransactionRepository(
      dataProvider: TransactionDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: this.repo, child: ControlBloc(repo: repo));
  }
}

class ControlBloc extends StatelessWidget {
  ControlBloc({
    Key? key,
    required this.repo,
  }) : super(key: key);

  final TransactionRepository repo;
  final repoB = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommissionBloc>(
      create: (context) => CommissionBloc(
          transactionRepository: repo, accountRepository: this.repoB),
      child: BlocConsumer<CommissionBloc, CommissionState>(
          listener: (context, state) {
        if (state is CommissionPayProcessing) {
          SnackBar(content: Text('Loan topup is processing...'));
        }
        if (state is CommissionPaySuccess) {
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgentDashboard()),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          // backgroundColor: AppColors.primaryWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                //Top Container
                // color: AppColors.primaryWhite,
                child: Column(
                  children: [
                    BankImage(),
                    PaymentCard(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PayInFull(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class BankImage extends StatelessWidget {
  const BankImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: MediaQuery.of(context).size.height / 3,

      // decoration: BoxDecoration(color: Colors.black),
      child: Image.asset('assets/images/transfer.jpg'),
    );
  }
}

class PayInFull extends StatelessWidget {
  const PayInFull({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          final commissionBloc = BlocProvider.of<CommissionBloc>(context);

          commissionBloc.add(RequestPayment());
        },
        child: Text('Get Paid'),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final repoA = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(accountRepository: this.repoA)..add(GetMyAccount()),
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AccountLoading) {
          //  SnackBar(content: Text("Payment info Loading"));
          CircularProgressIndicator();
        }
      }, builder: (context, state) {
        if (state is AccountLoaded) {
          var user = state.user;
          return Container(
            height: 120,
            child: Card(
              color: Colors.lightBlue,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Commission: ',
                            style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            '${user.commission}',
                            style: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            ),
          );
        } else {
          return Center(
            child: Text("Something went wrong."),
          );
        }
      }),
    );
  }
}
