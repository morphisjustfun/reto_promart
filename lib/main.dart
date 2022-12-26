import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_promart/data/repositories/meta_repository.dart';
import 'package:reto_promart/data/repositories/person_repository.dart';
import 'package:reto_promart/domain/blocs/user/user_bloc.dart';
import 'package:reto_promart/ui/pages/login/login.dart';
import 'package:reto_promart/ui/utils/theme.dart';
import 'package:reto_promart/ui/utils/page_wrapper.dart';
import 'package:reto_promart/util/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'reto_promart.db');
  RepositoryConstants.databasesPath = path;
  await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    final batch = db.batch();
    PersonRepository().createTable(batch);
    MetaRepository().createtable(batch);
    await batch.commit();
  });
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UserBloc>(
        create: (_) => UserBloc(),
      )
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reto Promart',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home:
          const PageWrapper(title: 'Bienvenido challenger 😎', child: Login()),
    );
  }
}
