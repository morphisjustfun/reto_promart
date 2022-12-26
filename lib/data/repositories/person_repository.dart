import 'package:reto_promart/domain/entities/repository/person.dart';
import 'package:reto_promart/domain/repositories/person_repository.dart';
import 'package:reto_promart/util/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class PersonRepository implements PersonRepositoryProvider {
  @override
  void createTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS ${PersonRepositoryEntity.tablePerson}');
    batch.execute('''
CREATE TABLE ${PersonRepositoryEntity.tablePerson} (
  ${PersonRepositoryEntity.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${PersonRepositoryEntity.columnName} TEXT,
  ${PersonRepositoryEntity.columnUsername} TEXT,
  ${PersonRepositoryEntity.columnEmail} TEXT,
  ${PersonRepositoryEntity.columnAddressStreet} TEXT,
  ${PersonRepositoryEntity.columnAddressSuite} TEXT,
  ${PersonRepositoryEntity.columnAddressCity} TEXT,
  ${PersonRepositoryEntity.columnAddressZipcode} TEXT,
  ${PersonRepositoryEntity.columnAddressGeoLat} TEXT,
  ${PersonRepositoryEntity.columnAddressGeoLng} TEXT,
  ${PersonRepositoryEntity.columnIsOnline} INTEGER
)
''');
  }

  @override
  Future<void> insert(PersonRepositoryEntity person) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    await db.insert(PersonRepositoryEntity.tablePerson, person.toMap());
  }

  @override
  Future<List<PersonRepositoryEntity>> getAll() async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    final List<Map<String, Object?>> map =
        await db.query(PersonRepositoryEntity.tablePerson);
    return map.map((e) => PersonRepositoryEntity.fromJson(e)).toList();
  }

  @override
  Future<PersonRepositoryEntity?> getPersonById(int id) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    final List<Map<String, Object?>> map = await db.query(
      PersonRepositoryEntity.tablePerson,
      where: '${PersonRepositoryEntity.columnId} = ?',
      whereArgs: [id],
    );
    if (map.isEmpty) {
      return null;
    }
    return PersonRepositoryEntity.fromJson(map.first);
  }

  @override
  void truncate() async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    await db.delete(PersonRepositoryEntity.tablePerson);
  }

  @override
  void truncateOnline() async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    db.delete(PersonRepositoryEntity.tablePerson,
        where: '${PersonRepositoryEntity.columnIsOnline} = ?', whereArgs: [1]);
  }

  @override
  Future<void> deleteById(int id) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    db.delete(PersonRepositoryEntity.tablePerson,
        where: '${PersonRepositoryEntity.columnId} = ?', whereArgs: [id]);
  }

  @override
  Future<void> update(PersonRepositoryEntity person) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    await db.update(
      PersonRepositoryEntity.tablePerson,
      person.toMap(),
      where: '${PersonRepositoryEntity.columnId} = ?',
      whereArgs: [person.id],
    );
  }
}
