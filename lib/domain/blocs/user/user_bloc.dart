import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(mail: '', nickname: '')) {
    on<LoginEvent>((event, emit) {
      emit(UserState(
        mail: event.mail,
        nickname: event.nickname,
      ));
    });
  }
}
