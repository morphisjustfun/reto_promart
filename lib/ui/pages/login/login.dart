import 'package:flutter/material.dart';
import 'package:reto_promart/ui/pages/login/widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
           LoginForm(),
        ],
      )),
    );
  }
}
