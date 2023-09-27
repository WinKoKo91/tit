import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/person_model.dart';

abstract class PersonRepository {
  Future<PersonModel?> checkPerson(String id);
  Future<void> addPerson( String id, PersonModel personModel);
  Future<Stream<QuerySnapshot>> getPersons();
}