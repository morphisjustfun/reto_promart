import 'package:flutter/material.dart';
import 'package:reto_promart/data/actions/user_action/user_action.dart';
import 'package:reto_promart/data/actions/user_action/utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _userAction = UserAction();
  final _formKey = GlobalKey<FormState>();
  final _user = LoginFormEntity();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.mail,
                size: 30,
              ),
              labelText: 'Ingrese su correo',
            ),
            validator: _userAction.validateEmail,
            onSaved: (value) => _user.mail = value!
          ),
          const SizedBox(height: 25),
          TextFormField(
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.person,
                size: 30,
              ),
              labelText: 'Ingrese su nickname',
            ),
            validator: _userAction.validateGeneral,
            onSaved: (value) => _user.nickname = value!,
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await _userAction.login(_user, context, mounted);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}

