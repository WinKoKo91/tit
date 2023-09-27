import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tit/app/data/repositories/person_repository.dart';

class PeopleController extends GetxController {
  PersonRepository repository = Get.find<PersonRepository>();

  late Stream<QuerySnapshot> stream;
  final _isLoading =true.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  @override
  void onInit() async {
    stream = await repository.getPersons();
    isLoading = false;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
