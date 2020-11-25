
import 'dart:async';
import 'package:flutter_app/model/bloc_1/validator.dart';
import 'package:mobx/mobx.dart';

class Bloc extends Object with Validators implements BaseBloc{
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordlValidator);

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}

abstract class BaseBloc {
  void dispose();
}