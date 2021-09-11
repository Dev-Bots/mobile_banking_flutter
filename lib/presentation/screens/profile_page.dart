import 'dart:io';

import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/infrastructure/data_provider/auth/accountProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_banking/main.dart';
import 'package:mobile_banking/presentation/screens/auth_page/login.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

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

  final passwordTextController = TextEditingController();

  final AccountRepository repo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) =>
          AuthBloc(accountRepository: this.repo)..add(GetMyAccount()),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AccountLoaded) {
          var user = state.user;

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
                      ProfileCard('${user.accountNumber}', '${user.email}',
                          '${user.fullName}'),
                      PasswordChangingSection(),
                      SizedBox(height: 30),
                      LogoutButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center();
        }
      }),
    );
  }
}

class PasswordChangingSection extends StatelessWidget {
  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(accountRepository: repo),
      child: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
        return Column(children: [
          PasswordField(amountTextController: passwordTextController),
          SizedBox(
            height: 20,
          ),
          ChangePasswordButton(
            passwordTextController: passwordTextController,
          )
        ]);
      }, listener: (context, state) {
        if (state is Proccessing) {
          final snackBar = SnackBar(
            content: Text(state.message),
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          sleep(Duration(seconds: 1));
        } else if (state is ProccessFinished) {
          final snackBar = SnackBar(
            content: Text(state.message),
            duration: Duration(seconds: 1),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          passwordTextController.clear();
        }
      }),
    );
  }
}

// class StateCheckBloc extends StatelessWidget {
//   const StateCheckBloc({
//     Key? key,
//     required this.amountTextController,
//     required this.accountTextController,
//   }) : super(key: key);

//   final TextEditingController accountTextController;
//   final TextEditingController amountTextController;

//   @override
//   Widget build(BuildContext context) {
//     // BlocProvider.of<AuthBloc>(context).state;

//     return BlocProvider(
//       create: (context) => AuthBloc(),
//       child: BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, authState) {
//             if (AuthState is AccountLoading) {
//               // final snackBar = SnackBar(content: Text("Login in progress"));

//               CircularProgressIndicator();
//             }

//             if (authState is AccountLoaded) {
//                 var user = state.user;
//             }

//             if (transactionState is ClientTransferFailure) {
//               // buttonChild = Text(authState.errorMsg);

//               final snackBar = SnackBar(content: Text(transactionState.error));

//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             }
//           },
//           builder: (ctx, authState) {
//             Widget buttonChild = Text("Transfer");

//             return TransferButton(
//                 amountTextController: amountTextController,
//                 accountTextController: accountTextController,
//                 buttonChild: buttonChild);
//           },
//         ),
//     );
//   }
// }

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

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({
    Key? key,
    required this.passwordTextController,
  }) : super(key: key);

  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);

        authBloc.add(ChangePassword(password: passwordTextController.text));
      },
      child: Text("Change Password"),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BankingApp(
                  accountRepository: AccountRepository(
                      dataProvider:
                          AccountDataProvider(httpClient: http.Client())))),
        );
      },
      child: Text("Logout"),
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
        icon: Icon(Icons.password),
        hintText: "New Password",
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String accNum;
  final String email;
  final String fullName;

  const ProfileCard(
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
            color: Colors.lightBlue,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Name: ',
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
                          'Email ',
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
                          'Account Number ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.accNum,
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
      },
    );
  }
}
