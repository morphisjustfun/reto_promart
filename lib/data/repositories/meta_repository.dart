import 'package:reto_promart/domain/entities/repository/meta.dart';
import 'package:reto_promart/domain/repositories/meta_repository.dart';
import 'package:reto_promart/util/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MetaRepository implements MetaRepositoryProvider {
  @override
  void createtable(Batch batch) async {
    batch.execute('DROP TABLE IF EXISTS ${MetaRepositoryEntity.tableMeta}');
    batch.execute('''
CREATE TABLE ${MetaRepositoryEntity.tableMeta} (
  ${MetaRepositoryEntity.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${MetaRepositoryEntity.columnTableName} TEXT,
  ${MetaRepositoryEntity.columnLastUpdated} REAL
)
''');
  }

  @override
  Future<MetaRepositoryEntity?> getByTableName(String tableName) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    final List<Map<String, Object?>> map = await db.query(
      MetaRepositoryEntity.tableMeta,
      where: '${MetaRepositoryEntity.columnTableName} = ?',
      whereArgs: [tableName],
    );

    if (map.isEmpty) {
      return null;
    }
    return MetaRepositoryEntity.fromJson(map.first);
  }

  @override
  void insert(MetaRepositoryEntity person) async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    await db.insert(MetaRepositoryEntity.tableMeta, person.toMap());
  }

  @override
  void truncate() async {
    final db = await openDatabase(RepositoryConstants.databasesPath);
    await db.delete(MetaRepositoryEntity.tableMeta);
  }
}
