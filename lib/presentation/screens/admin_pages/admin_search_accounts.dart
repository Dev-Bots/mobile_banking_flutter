import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';

import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:mobile_banking/presentation/screens/admin_pages/admin_client_manage_accounts.dart';
import 'package:mobile_banking/presentation/screens/admin_pages/admin_agent_manage_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AdminSearchUser extends StatelessWidget {
  final accountTextController = TextEditingController();
  final amountTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    // final transactionBloc = BlocProvider.of<TransactionBloc>(context).state;
    final inputFieldStyle = InputDecoration(
      border: OutlineInputBorder(),
    );

    return BlocProvider(
      create: (context) => AuthBloc(accountRepository: repo),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BankImage(),
                      SizedBox(height: 20.0),
                      AccountField(
                          accountTextController: accountTextController),
                      SizedBox(height: 20.0),
                      SizedBox(height: 30.0),
                      StateCheckBloc(
                        accountTextController: accountTextController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StateCheckBloc extends StatelessWidget {
  const StateCheckBloc({
    Key? key,
    required this.accountTextController,
  }) : super(key: key);

  final TextEditingController accountTextController;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).state;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AccountLoading) {
          // final snackBar = SnackBar(content: Text("Login in progress"));

          CircularProgressIndicator();
        }

        if (authState is AccountLoaded) {
          if (authState.user.role == 'client') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdminClientManageAccount(user: authState.user)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdminAgentManageAccount(user: authState.user)),
            );
          }
        }

        if (authState is AccountFailed) {
          final snackBar = SnackBar(content: Text(authState.error));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (ctx, authState) {
        Widget buttonChild = Text("Search");

        return SearchButton(
            accountTextController: accountTextController,
            buttonChild: buttonChild);
      },
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

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.accountTextController,
    required this.buttonChild,
  }) : super(key: key);

  final TextEditingController accountTextController;
  final Widget buttonChild;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        // print();
        authBloc.add(GetAccount(accountNumber: accountTextController.text));
      },
      child: buttonChild,
    );
  }
}

class AccountField extends StatelessWidget {
  const AccountField({
    Key? key,
    required this.accountTextController,
  }) : super(key: key);

  final TextEditingController accountTextController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: accountTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.attach_money),
        hintText: "Enter Account Number",
      ),
    );
  }
}
