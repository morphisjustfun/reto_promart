import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_promart/data/actions/user_action/utils.dart';
import 'package:reto_promart/data/repositories/meta_repository.dart';
import 'package:reto_promart/data/repositories/person_repository.dart';
import 'package:reto_promart/data/services/person_service.dart';
import 'package:reto_promart/domain/blocs/user/user_bloc.dart';
import 'package:reto_promart/domain/entities/repository/meta.dart';
import 'package:reto_promart/domain/entities/repository/person.dart';
import 'package:reto_promart/ui/pages/dashboard/dashboard.dart';
import 'package:reto_promart/ui/pages/map_person/map_person.dart';
import 'package:reto_promart/ui/utils/confirmation.dart';
import 'package:reto_promart/ui/utils/page_wrapper.dart';
import 'package:reto_promart/ui/utils/spin_loader.dart';
import 'package:reto_promart/util/constants.dart';

class UserAction {
  String? validateEmail(String? value) {
    final reMail = RegExp(ValidatorConstants.mailRegex);
    if (value!.isEmpty) {
      return 'Por favor ingrese su correo';
    }
    if (!reMail.hasMatch(value)) {
      return 'Por favor ingrese un correo válido';
    }
    return null;
  }

  String? validateNickname(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingrese su nickname';
    }
    if (value.length < 3) {
      return 'Su nickname debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingrese su nombre';
    }

    if (value.length < 5) {
      return 'Su nombre debe tener al menos 5 caracteres';
    }

    return null;
  }

  String? validateGeneral(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingrese un valor';
    }

    return null;
  }

  Future login(LoginFormEntity user, BuildContext context, bool mounted) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    BlocProvider.of<UserBloc>(context).add(LoginEvent(
      mail: user.mail,
      nickname: user.nickname,
    ));
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bienvenido'),
        content: Text('Hola ${user.nickname}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Future<Map<String, Object>> syncPersons() async {
    final personService = PersonService();
    final personRepository = PersonRepository();
    final metaRepository = MetaRepository();
    final onlinePersons = await personService.getPersons();

    if (onlinePersons.isFailure) {
      return {'result': false, 'message': onlinePersons.message};
    }

    final onlinePersonsData = onlinePersons.data!;
    personRepository.truncateOnline();
    for (var onlinePerson in onlinePersonsData) {
      personRepository.insert(PersonRepositoryEntity(
          name: onlinePerson.name,
          username: onlinePerson.username,
          email: onlinePerson.email,
          address_street: onlinePerson.address_street,
          address_suite: onlinePerson.address_suite,
          address_city: onlinePerson.address_city,
          address_zipcode: onlinePerson.address_zipcode,
          address_geo_lat: onlinePerson.address_geo_lat,
          address_geo_lng: onlinePerson.address_geo_lng,
          isOnline: 1));
    }

    metaRepository.truncate();
    metaRepository.insert(MetaRepositoryEntity(
        tableName: PersonRepositoryEntity.tablePerson,
        lastUpdated: DateTime.now().millisecondsSinceEpoch));

    return {'result': true, 'message': 'Sincronización exitosa'};
  }

  Future<DateTime> getLastTimeSync() async {
    final metaRepository = MetaRepository();
    final meta =
        await metaRepository.getByTableName(PersonRepositoryEntity.tablePerson);

    if (meta == null) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime.fromMillisecondsSinceEpoch(
        (meta.lastUpdated as double).toInt());
  }

  Future getDashboardPersons(
      StreamController<List<PersonRepositoryEntity>> personsStream,
      BuildContext context,
      bool mounted) async {
    // final syncResult = await withSpinLoader(context, syncPersons, mounted);
    final syncResult = await syncPersons();
    final syncResultBool = syncResult['result'] as bool;
    final syncResultMessage = syncResult['message'] as String;

    if (!syncResultBool) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(syncResultMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cerrar'),
                  ),
                ],
              ));
    }

    final personRepository = PersonRepository();
    final persons = await personRepository.getAll();
    personsStream.add(persons);
  }

  Future<void> addPerson(PersonRepositoryEntity person) async {
    final personRepository = PersonRepository();
    await personRepository.insert(person);
  }

  Future<void> updatePerson(PersonRepositoryEntity person) async {
    final personRepository = PersonRepository();
    await personRepository.update(person);
  }

  Future<void> deletePerson(
      BuildContext context, PersonRepositoryEntity person, bool mounted) async {
    final personRepository = PersonRepository();
    await withConfirmationDialog(
        context,
        'Estás seguro?',
        'Confirma el borrado del usuario ${person.name}',
        () async => await personRepository.deleteById(person.id!),
        mounted);
  }

  Future<void> checkMap(
      BuildContext context, PersonRepositoryEntity person) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageWrapper(
            title: 'Mapa 😱',
            child: MapPerson(
              lat: double.parse(person.address_geo_lat!),
              lng: double.parse(person.address_geo_lng!),
            ))));
  }
}
