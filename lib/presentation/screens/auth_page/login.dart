import 'package:mobile_banking/application/bloc/LoginBloc/login_bloc.dart';
// import 'package:mobile_banking/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:mobile_banking/insfrastructure/data_provider/auth/accountProvider.dart';
import 'package:mobile_banking/insfrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/presentation/config/route_generator.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_home.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    // final loginBloc = BlocProvider.of<LoginBloc>(context).state;
    final inputFieldStyle = InputDecoration(
      border: OutlineInputBorder(),
    );

    return BlocProvider(
      create: (context) => LoginBloc(accountRepository: repo),
      child: Scaffold(
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
                      EmailField(emailTextController: emailTextController),
                      SizedBox(height: 20.0),
                      PasswordField(
                          passwordTextController: passwordTextController,
                          inputFieldStyle: inputFieldStyle),
                      SizedBox(height: 30.0),
                      StateCheckBloc(
                          emailTextController: emailTextController,
                          passwordTextController: passwordTextController),
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
    required this.emailTextController,
    required this.passwordTextController,
  }) : super(key: key);

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).state;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginState) {
        // if (loginState is ) {
        //   Navigator.of(context).pushNamed('/userhome');
        // }
        if (loginState is LoginLoading) {
          final snackBar = SnackBar(content: Text("Login in progress"));

          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          CircularProgressIndicator();
        }

        if (loginState is LoggingSuccess) {
          // buttonChild = Text(authState.errorMsg);
          String role = loginState.user.role;
          Navigator.of(context)
              .pushNamed(RouteGenerator.HomePage, arguments: role);
        }

        if (loginState is LoginFailure) {
          // buttonChild = Text(authState.errorMsg);

          final snackBar = SnackBar(content: Text(loginState.error));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (ctx, authState) {
        Widget buttonChild = Text("Login");

        return LoginButton(
            emailTextController: emailTextController,
            passwordTextController: passwordTextController,
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
      child: Image.asset('assets/images/bankingforLogin.jpg'),
    );
  }
}

// class PasswordField extends StatelessWidget {
//   const PasswordField({
//     Key? key,
//     required this.passwordTextController,
//     required this.inputFieldStyle,
//   }) : super(key: key);

//   final TextEditingController passwordTextController;
//   final InputDecoration inputFieldStyle;

//   @override
//   Widget build(BuildContext context) {
//     return PasswordField(
//         passwordTextController: passwordTextController,
//         inputFieldStyle: inputFieldStyle);
//   }
// }

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.emailTextController,
    required this.passwordTextController,
    required this.buttonChild,
  }) : super(key: key);

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final Widget buttonChild;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final authBloc = BlocProvider.of<LoginBloc>(context);

        authBloc.add(LoginButtonPressed(
            email: emailTextController.text,
            password: passwordTextController.text));
      },
      child: buttonChild,
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailTextController,
  }) : super(key: key);

  final TextEditingController emailTextController;

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

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.passwordTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController passwordTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: passwordTextController,
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        hintText: "Password",
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myapp/auth/bloc/auth_bloc.dart';
// import 'package:myapp/auth/bloc/auth_event.dart';
// import 'package:myapp/auth/bloc/auth_state.dart';
// import 'package:myapp/todo/screens/todo_list.dart';

// class LoginScreen extends StatelessWidget {
//   static const String routeName = '/login';

//   LoginScreen({Key? key}) : super(key: key);

//   final emailTextController = TextEditingController();
//   final passwordTextController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final inputFieldStyle = InputDecoration(
//       border: OutlineInputBorder(),
//     );

//     return Scaffold
//   }
// }

