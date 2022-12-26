class PersonRepositoryEntity {
  final int? id;
  String? name;
  String? username;
  String? email;
  String? address_street;
  String? address_suite;
  String? address_city;
  String? address_zipcode;
  String? address_geo_lat;
  String? address_geo_lng;
  final int? isOnline;

  static const String tablePerson = 'person';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnUsername = 'username';
  static const String columnEmail = 'email';
  static const String columnAddressStreet = 'address_street';
  static const String columnAddressSuite = 'address_suite';
  static const String columnAddressCity = 'address_city';
  static const String columnAddressZipcode = 'address_zipcode';
  static const String columnAddressGeoLat = 'address_geo_lat';
  static const String columnAddressGeoLng = 'address_geo_lng';
  static const String columnIsOnline = 'is_online';

  PersonRepositoryEntity({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address_street,
    required this.address_suite,
    required this.address_city,
    required this.address_zipcode,
    required this.address_geo_lat,
    required this.address_geo_lng,
    required this.isOnline,
  });

  factory PersonRepositoryEntity.fromJson(Map<String, dynamic> json) {
    return PersonRepositoryEntity(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address_street: json['address_street'],
      address_suite: json['address_suite'],
      address_city: json['address_city'],
      address_zipcode: json['address_zipcode'],
      address_geo_lat: json['address_geo_lat'],
      address_geo_lng: json['address_geo_lng'],
      isOnline: json['is_online'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnUsername: username,
      columnEmail: email,
      columnAddressStreet: address_street,
      columnAddressSuite: address_suite,
      columnAddressCity: address_city,
      columnAddressZipcode: address_zipcode,
      columnAddressGeoLat: address_geo_lat,
      columnAddressGeoLng: address_geo_lng,
      columnIsOnline: isOnline,
    };
  }
}
