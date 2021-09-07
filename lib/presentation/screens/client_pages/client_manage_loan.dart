import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/application/bloc/LoanBloc/loan_bloc.dart';
import 'package:mobile_banking/insfrastructure/insfrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_banking/presentation/screens/client_pages/client_pages_frame.dart';

class ManageLoan extends StatelessWidget {
  ManageLoan({Key? key}) : super(key: key);

  final repo =
      LoanRepository(dataProvider: LoanDataProvider(httpClient: http.Client()));

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

  final amountTextController = TextEditingController();

  final LoanRepository repo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoanBloc>(
      create: (context) =>
          LoanBloc(loanRepository: this.repo)..add(GetLoanInfo()),
      child: BlocConsumer<LoanBloc, LoanState>(listener: (context, state) {
        if (state is LoanInfoLoading) {
          CircularProgressIndicator();
        }

        if (state is TopUpLoanProcessing) {
          SnackBar(content: Text('Loan topup is processing...'));
        }
        if (state is TopUpLoanSuccess) {
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
            MaterialPageRoute(builder: (context) => ClientDashboard()),
          );

          // final snackBar = SnackBar(
          //   content: Text(state.message),
          //   duration: Duration(seconds: 1),
          // );

          // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // amountTextController.clear();
        }
      }, builder: (context, state) {
        if (state is LoanInfoLoadingFailed) {
          print('Thissssssssssssssssssssssssssssssssssssss');
          return Center(child: Text('No Active Loans.'));

          // return Center(child: Text(state.errorMsg));
        }
        if (state is LoanInfoLoaded) {
          var info = state.info;
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
                      LoanInfoCard('${info.dueDate}', '${info.amountRemaining}',
                          '${info.amountTaken}'),
                      PasswordField(amountTextController: amountTextController),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TopUpButton(
                            amountTextController: amountTextController,
                          ),
                          PayInFull(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return ClientDashboard();
        }
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

class TopUpButton extends StatelessWidget {
  const TopUpButton({
    Key? key,
    required this.amountTextController,
  }) : super(key: key);

  final TextEditingController amountTextController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final loanBloc = BlocProvider.of<LoanBloc>(context);

        loanBloc
            .add(TopUpLoan(amount: double.parse(amountTextController.text)));
      },
      child: Text("Top Up Loan"),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.amountTextController,
  }) : super(key: key);

  final TextEditingController amountTextController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: amountTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.attach_money),
        hintText: "Amount",
      ),
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
          final authBloc = BlocProvider.of<LoanBloc>(context);

          authBloc.add(PayLoanInfull());
        },
        child: Text("Pay Loan In Full"),
      ),
    );
  }
}

class LoanInfoCard extends StatelessWidget {
  final String accNum;
  final String email;
  final String fullName;

  const LoanInfoCard(
    this.accNum,
    this.email,
    this.fullName,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          height: 250,
          child: Card(
            color: Colors.blue,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Amount Taken: ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.fullName,
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Amount Remaining ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.email,
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Due date: ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.accNum,
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 14,
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
      },
    );
  }
}
