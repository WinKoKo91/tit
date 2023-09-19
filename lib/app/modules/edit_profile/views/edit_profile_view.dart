import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/src/app_spacing.dart';
import '../../../core/utils/image_picker_util.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import '../../../widgets/image/image_picker_content_widget.dart';
import '../../../widgets/image/my_image_widget.dart';
import '../../../widgets/profile_image_widget.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.editProfile();
                    }
                  },
                  child: const Text("Confirm"))),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Obx(
                      ()=> ProfileImageWidget(
                            type: controller.imageType ?? ImageFileType.network,
                            url: controller.userEntity.photoUrl ?? ""),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  backgroundColor: Colors.white),
                              onPressed: controller.onEditProfileImage,
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              )))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.nameTEC,
                  decoration: const InputDecoration(
                    hintText: "User Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  enabled: false,
                  controller: controller.emailTEC,
                  textInputAction: TextInputAction.next,
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  enableInteractiveSelection: false,
                  validator: (value) {
                    if (!GetUtils.isEmail(value!)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSelectedPhoto() {
    CustomModalBottomSheet.showBottomSheet(
      Get.context,
      Text("Hello World"),
      ImagePickerContentWidget(
        onTakePhoto: () => controller.onPickImage(source: ImageSource.camera),
        onUploadImage: () =>
            controller.onPickImage(source: ImageSource.gallery),
      ),
    );
  }
}
