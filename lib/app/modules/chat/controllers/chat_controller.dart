import 'package:get/get.dart';

import '../../../data/models/person_model.dart';
import '../widgets/messageBubble.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  final _data = RxList<Message>([]);

  List<Message> get data => _data.value;

  set data(value) {
    _data.value = value;
  }

  final _personModel = Rxn<PersonModel>();

  PersonModel? get personModel => _personModel.value;

  set personModel(value) {
    _personModel.value = value;
  }

  @override
  void onInit() {
    personModel = Get.arguments;
    data = MessageGenerator.generate(60, 1337);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
