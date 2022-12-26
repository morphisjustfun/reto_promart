import 'package:reto_promart/domain/entities/services/base_service.dart';
import 'package:reto_promart/domain/entities/services/persons/person_response.dart';

abstract class PersonsServiceProvider {
  Future<BaseServiceEntity<List<PersonServiceResponseEntity>>> getPersons();
}
