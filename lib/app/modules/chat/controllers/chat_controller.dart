import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/person_model.dart';
import '../widgets/messageBubble.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  final _enableSend = false.obs;

  bool get enableSend => _enableSend.value;

  set enableSend(value) {
    _enableSend.value = value;
  }

  TextEditingController messageController = TextEditingController();
  late ScrollController listScrollController;

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

  MessageOwner messageOwner = MessageOwner.other;

  @override
  void onInit() {
    personModel = Get.arguments;
    data = MessageGenerator.generate(60, 1337);

    messageController = TextEditingController();
    messageController.addListener(() {
      enableSend = messageController.text.isNotEmpty;
    });

    super.onInit();
  }

  @override
  void onReady() {
    listScrollController.animateTo(
      listScrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 800),
    );
    super.onReady();
  }

  @override
  void onClose() {
    listScrollController.dispose();
    messageController.dispose();
    super.onClose();
  }

  sendMessage() {
    Message message =
        Message(owner: messageOwner, text: messageController.text);
    data = [...data, message];
    messageController.clear();
  }
}
