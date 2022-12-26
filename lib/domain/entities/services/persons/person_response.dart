class PersonServiceResponseEntity {
  final int id;
  final String name;
  final String username;
  final String email;
  final String address_street;
  final String address_suite;
  final String address_city;
  final String address_zipcode;
  final String address_geo_lat;
  final String address_geo_lng;

  const PersonServiceResponseEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address_street,
    required this.address_suite,
    required this.address_city,
    required this.address_zipcode,
    required this.address_geo_lat,
    required this.address_geo_lng,
  });

  factory PersonServiceResponseEntity.fromJson(Map<String, dynamic> json) {
    return PersonServiceResponseEntity(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address_street: json['address']['street'],
      address_suite: json['address']['suite'],
      address_city: json['address']['city'],
      address_zipcode: json['address']['zipcode'],
      address_geo_lat: json['address']['geo']['lat'],
      address_geo_lng: json['address']['geo']['lng'],
    );
  }
}
