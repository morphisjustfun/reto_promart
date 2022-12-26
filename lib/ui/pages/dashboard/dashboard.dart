import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reto_promart/data/actions/user_action/user_action.dart';
import 'package:reto_promart/data/repositories/person_repository.dart';
import 'package:reto_promart/domain/blocs/user/user_bloc.dart';
import 'package:reto_promart/domain/entities/repository/person.dart';
import 'package:reto_promart/ui/pages/add_person/add_person.dart';
import 'package:reto_promart/ui/pages/edit_person/edit_person.dart';
import 'package:reto_promart/ui/utils/page_wrapper.dart';
import 'package:reto_promart/ui/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _personsStream = StreamController<List<PersonRepositoryEntity>>();
  final _userActions = UserAction();

  @override
  void initState() {
    super.initState();
    _userActions.getDashboardPersons(_personsStream, context, mounted);
  }

  @override
  Widget build(BuildContext context) {
    final nickname = BlocProvider.of<UserBloc>(context).state.nickname;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const PageWrapper(
                  title: 'Añadir persona 🤗', child: AddPerson());
            }));
            if (!mounted) return;
            _userActions.getDashboardPersons(_personsStream, context, mounted);
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: Text('Bienvenido $nickname 🫡'),
      ),
      body: StreamBuilder<List<PersonRepositoryEntity>>(
          stream: _personsStream.stream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: () => _userActions.getDashboardPersons(
                        _personsStream, context, true),
                    child: snapshot.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data!.length) {
                                return FutureBuilder<DateTime>(
                                    future: _userActions.getLastTimeSync(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const ListTile(
                                          subtitle: Text(
                                            'Última actualización: -',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }
                                      return ListTile(
                                        subtitle: Text(
                                          'Última actualización: ${snapshot.data!.day}/${snapshot.data!.month}/${snapshot.data!.year} ${snapshot.data!.hour}:${snapshot.data!.minute}:${snapshot.data!.second}',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    });
                              }

                              final person = snapshot.data![index];
                              return Slidable(
                                key: ValueKey('person - $index'),
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (context) async {
                                          await Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PageWrapper(
                                                title: 'Editar persona 🤗',
                                                child: EditPerson(
                                                  person: person,
                                                ));
                                          }));
                                          if (!mounted) return;
                                          _userActions.getDashboardPersons(
                                              _personsStream, context, mounted);
                                        },
                                        backgroundColor: ThemeColors.editColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (context) async {
                                          await _userActions.deletePerson(
                                              context, person, mounted);
                                          if (!mounted) return;
                                          _userActions.getDashboardPersons(
                                              _personsStream, context, mounted);
                                        },
                                        backgroundColor:
                                            ThemeColors.deleteColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                      ),
                                    ]),
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (context) async {
                                          launchUrl(
                                              Uri.parse('tel://${person.address_zipcode}'));
                                        },
                                        backgroundColor: ThemeColors.phoneColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.phone,
                                      ),
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (context) => _userActions.checkMap(context, person),
                                        backgroundColor: ThemeColors.mapColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.map,
                                      ),
                                    ]),
                                child: ListTile(
                                  title: Text(person.name ?? '-'),
                                  subtitle: Text(person.email ?? '-'),
                                  trailing: person.isOnline == 1
                                      ? Icon(
                                          Icons.circle,
                                          color: ThemeColors.onlineColor,
                                        )
                                      : Icon(
                                          Icons.circle,
                                          color: ThemeColors.offlineColor,
                                        ),
                                ),
                              );
                            },
                          )
                        : Stack(children: [
                            ListView(),
                            const Center(
                                child: Text('No hay personas registradas'))
                          ]))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
