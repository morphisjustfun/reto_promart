import 'package:reto_promart/domain/entities/repository/person.dart';
import 'package:sqflite/sqflite.dart';

abstract class PersonRepositoryProvider {
  void createTable(Batch batch);
  void truncate();
  void truncateOnline();
  Future<void> insert(PersonRepositoryEntity person);
  Future<void> update(PersonRepositoryEntity person);
  Future<List<PersonRepositoryEntity>> getAll();
  Future<PersonRepositoryEntity?> getPersonById(int id);
  Future<void> deleteById (int id);
}
