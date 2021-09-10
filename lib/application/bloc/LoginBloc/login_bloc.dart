import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:mobile_banking/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_home.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository accountRepository;
  // final AuthBloc authBloc;

  LoginBloc({required this.accountRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      final email = event.email;
      final password = event.password;

      // reaching to the backend
      yield LoginLoading();

      try {
        var login = await accountRepository.login(email, password);
        print('$email and $password');
        print(login);

        if (login != null) {
          yield LoggingSuccess(user: login);
        } else {
          yield LoginFailure(error: "Login Failed");
        }
        // authBloc.add(LoggedIn());
        // print('what do I do now?');
      } catch (error) {
        // authBloc.add();
        yield LoginFailure(error: error.toString());
      }
    }
  }
}

// if (email == "a") {
      //   if (password == "s") {
      //     // login successfuly
      //     yield LoggedIn();
      //   } else {
      //     // wrong password
      //     yield AuthFailed(errorMsg: 'Wrong password');
      //   }
      // } else {
      //   // account doesn't exists
      //   yield AuthFailed(errorMsg: 'Account does not exist');
      // }
