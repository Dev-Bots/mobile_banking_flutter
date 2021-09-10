import 'package:mobile_banking/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';

import 'package:mobile_banking/insfrastructure/data_provider/auth/accountProvider.dart';
import 'package:mobile_banking/insfrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/presentation/config/route_generator.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_home.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/history_page.dart';

class ClientRegister extends StatelessWidget {
  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final balanceTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    // final loginBloc = BlocProvider.of<LoginBloc>(context).state;
    final inputFieldStyle = InputDecoration(
      border: OutlineInputBorder(),
    );

    return BlocProvider<AuthBloc>(
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
                      SizedBox(height: 20.0),
                      BankImage(),
                      SizedBox(height: 20.0),
                      FirstName(
                          firstNameTextController: firstNameTextController),
                      LastName(
                          lastNameTextController: lastNameTextController,
                          inputFieldStyle: inputFieldStyle),
                      DOB(
                          dobTextController: dobTextController,
                          inputFieldStyle: inputFieldStyle),
                      Address(
                          addressTextController: addressTextController,
                          inputFieldStyle: inputFieldStyle),
                      Email(
                        emailTextController: emailTextController,
                        inputFieldStyle: inputFieldStyle,
                      ),
                      PhoneNumber(
                          phoneNumberTextController: phoneNumberTextController,
                          inputFieldStyle: inputFieldStyle),
                      Balance(
                          balanceTextController: balanceTextController,
                          inputFieldStyle: inputFieldStyle),
                      SizedBox(height: 30.0),
                      StateCheckBloc(
                        firstNAmeTextController: firstNameTextController,
                        lastNameTextController: lastNameTextController,
                        dobTextController: dobTextController,
                        addressTextController: addressTextController,
                        passwordTextController: passwordTextController,
                        emailTextController: emailTextController,
                        phoneNumberTextController: phoneNumberTextController,
                        balanceTextController: balanceTextController,
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
    required this.firstNAmeTextController,
    required this.lastNameTextController,
    required this.dobTextController,
    required this.addressTextController,
    required this.passwordTextController,
    required this.emailTextController,
    required this.phoneNumberTextController,
    required this.balanceTextController,
  }) : super(key: key);

  final TextEditingController firstNAmeTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController dobTextController;
  final TextEditingController addressTextController;
  final TextEditingController passwordTextController;
  final TextEditingController emailTextController;
  final TextEditingController phoneNumberTextController;
  final TextEditingController balanceTextController;

  @override
  Widget build(BuildContext context) {
    final repo = AccountRepository(
        dataProvider: AccountDataProvider(httpClient: http.Client()));
    return BlocProvider(
      create: (context) => AuthBloc(accountRepository: repo),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          // if (loginState is ) {
          //   Navigator.of(context).pushNamed('/userhome');
          // }
          if (authState is Proccessing) {
            final snackBar = SnackBar(content: Text(authState.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // CircularProgressIndicator();
          }

          if (authState is ProccessFinished) {
            // final snackBar = SnackBar(
            //   content: Text(authState.message),
            //   duration: Duration(seconds: 5),
            // );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            firstNAmeTextController.clear();
            lastNameTextController.clear();
            dobTextController.clear();
            addressTextController.clear();
            passwordTextController.clear();
            emailTextController.clear();
            phoneNumberTextController.clear();
            balanceTextController.clear();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OTP(tempPassword: authState.message)));

            // buttonChild = Text(authState.errorMsg);
            // String role = authState.user.role;
            // Navigator.of(context)
            //     .pushNamed(RouteGenerator.HomePage, arguments: role);
          }

          if (authState is ProccessFailed) {
            // buttonChild = Text(authState.errorMsg);

            final snackBar = SnackBar(content: Text(authState.error));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (ctx, authState) {
          return RegisterButton(
            firstNAmeTextController: firstNAmeTextController,
            lastNameTextController: lastNameTextController,
            dobTextController: dobTextController,
            addressTextController: addressTextController,
            passwordTextController: passwordTextController,
            emailTextController: emailTextController,
            phoneNumberTextController: phoneNumberTextController,
            balanceTextController: balanceTextController,
          );
        },
      ),
    );
  }
}

class OTP extends StatelessWidget {
  final tempPassword;

  OTP({required this.tempPassword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text('Client password is ${this.tempPassword},'),
              Text('Client is advised to change this immediately.')
            ],
          ),
        ),
      ),
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
      child: Image.asset('assets/images/bankingforLogin.jpg'),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.firstNAmeTextController,
    required this.lastNameTextController,
    required this.dobTextController,
    required this.addressTextController,
    required this.passwordTextController,
    required this.emailTextController,
    required this.phoneNumberTextController,
    required this.balanceTextController,
  }) : super(key: key);

  final TextEditingController firstNAmeTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController dobTextController;
  final TextEditingController addressTextController;
  final TextEditingController passwordTextController;
  final TextEditingController emailTextController;
  final TextEditingController phoneNumberTextController;
  final TextEditingController balanceTextController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        Client client = Client(
            firstName: firstNAmeTextController.text,
            lastName: lastNameTextController.text,
            dob: dobTextController.text,
            email: emailTextController.text,
            phoneNumber: phoneNumberTextController.text,
            address: addressTextController.text,
            balance: double.parse(balanceTextController.text));
        authBloc.add(RegisterClient(client: client));
      },
      child: Text("Register"),
    );
  }
}

//===================Fields============================

class FirstName extends StatelessWidget {
  const FirstName({
    Key? key,
    required this.firstNameTextController,
  }) : super(key: key);

  final TextEditingController firstNameTextController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstNameTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.person_outlined),
        hintText: "First Name",
      ),
    );
  }
}

class LastName extends StatelessWidget {
  const LastName({
    Key? key,
    required this.lastNameTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController lastNameTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: lastNameTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.person_outlined),
        hintText: "Last Name",
      ),
    );
  }
}

class DOB extends StatelessWidget {
  const DOB({
    Key? key,
    required this.dobTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController dobTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dobTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.date_range),
        hintText: "Date of Birth",
      ),
    );
  }
}

class Address extends StatelessWidget {
  const Address({
    Key? key,
    required this.addressTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController addressTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: addressTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.home),
        hintText: "Address",
      ),
    );
  }
}

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({
    Key? key,
    required this.phoneNumberTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController phoneNumberTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumberTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        hintText: "Phone Number",
      ),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    Key? key,
    required this.emailTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController emailTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        hintText: "Email",
      ),
    );
  }
}

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.balanceTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController balanceTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: balanceTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.attach_money),
        hintText: "Initial Deposit",
      ),
    );
  }
}
