import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:reto_promart/domain/entities/services/persons/person_response.dart';
import 'package:reto_promart/domain/entities/services/base_service.dart';
import 'package:reto_promart/domain/services/person_service.dart';
import 'package:reto_promart/util/constants.dart';

class PersonService implements PersonsServiceProvider {
  @override
  Future<BaseServiceEntity<List<PersonServiceResponseEntity>>>
      getPersons() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const BaseServiceEntity(
          data: null, message: "No hay conexión a internet", status: 0);
    }

    const url = '${ServiceConstants.endpoint}/users';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return BaseServiceEntity(
          data: null, message: "No encontrado", status: response.statusCode);
    }
    final personsResponseEntity = (jsonDecode(response.body) as List)
        .map((i) => PersonServiceResponseEntity.fromJson(i))
        .toList();
    return BaseServiceEntity(
        data: personsResponseEntity,
        message: "OK",
        status: response.statusCode);
  }
}
