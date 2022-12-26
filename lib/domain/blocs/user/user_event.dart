part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoginEvent extends UserEvent {
  final String mail;
  final String nickname;

  LoginEvent({required this.mail, required this.nickname});
}
