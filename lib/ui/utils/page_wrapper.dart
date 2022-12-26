import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_promart/domain/blocs/user/user_bloc.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper(
      {super.key,
      required this.title,
      required this.child,
      this.floatingActionButton});

  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final nickname = BlocProvider.of<UserBloc>(context).state.nickname;
    // if nickname is different from empty string, then replace all ocurrences of __user__ with nickname
    return Scaffold(
        appBar: AppBar(
          title: nickname != ''
              ? Text(title.replaceAll('__user__', nickname))
              : Text(title),
        ),
        body: child,
        floatingActionButton: floatingActionButton);
  }
}
