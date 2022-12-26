class MetaRepositoryEntity {
  final int? id;
  final String? tableName;
  final num? lastUpdated;

  static const String tableMeta = 'meta';
  static const String columnId = 'id';
  static const String columnTableName = 'table_name';
  static const String columnLastUpdated = 'last_updated';

  const MetaRepositoryEntity({
    this.id,
    required this.tableName,
    required this.lastUpdated,
  });

  factory MetaRepositoryEntity.fromJson(Map<String, dynamic> json) {
    return MetaRepositoryEntity(
      id: json['id'],
      tableName: json['table_name'],
      lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTableName: tableName,
      columnLastUpdated: lastUpdated,
    };
  }
}
