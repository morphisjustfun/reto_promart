import 'package:reto_promart/domain/entities/repository/meta.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class MetaRepositoryProvider {
  void createtable(Batch batch);
  void truncate();
  void insert(MetaRepositoryEntity person);
  Future<MetaRepositoryEntity?> getByTableName(String tableName);
}