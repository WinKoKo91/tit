import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tit/app/widgets/profile_image_widget.dart';

import '../controllers/chat_controller.dart';
import '../widgets/messageBubble.dart';

class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.listScrollController = scrollController;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => SafeArea(
            child: Container(
                color: Get.theme.colorScheme.surface,
                padding: const EdgeInsets.only(left: 20, right: 8, top: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.messageController,
                    )),
                    IconButton(
                        onPressed: controller.enableSend
                            ? controller.sendMessage
                            : null,
                        icon: Icon(
                          Icons.send,
                          color: controller.enableSend
                              ? Get.theme.colorScheme.primary
                              : Colors.grey,
                        ))
                  ],
                ))),
      ),
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
      body: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            final position = scrollController.position.maxScrollExtent;
            scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            Message message = controller.data[index];

            return MessageBubble(
                message: message,
                child: Text(
                  message.text,
                ));
          },
          itemCount: controller.data.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 4,
            );
          },
        );
      }),
    );
  }
}
