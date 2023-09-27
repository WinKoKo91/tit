import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tit/app/widgets/profile_image_widget.dart';

import '../controllers/chat_controller.dart';
import '../widgets/messageBubble.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ProfileImageWidget(
              url: controller.personModel?.photoUrl ?? "",
              size: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(controller.personModel?.displayName ?? "")
          ],
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info))],
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) {
            Message message = controller.data[index];
            return MessageBubble(message: message, child: Text(message.text));
          },
          itemCount: controller.data.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 4,
            );
          },
        ),
      ),
    );
  }
}
