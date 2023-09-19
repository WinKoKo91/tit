import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/modules/home/controllers/home_controller.dart';
import 'package:tit/app/widgets/image/my_image_widget.dart';

import '../../../core/utils/image_cropper_util.dart';
import '../../../core/utils/image_picker_util.dart';
import '../../../data/entities/user_entity.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import '../../../widgets/image/image_picker_content_widget.dart';

class EditProfileController extends GetxController {
  late UserEntity userEntity;
  UserRepository userRepository = Get.find<UserRepository>();

  final emailTEC = TextEditingController();
  final nameTEC = TextEditingController();

  final _imageType = Rxn<ImageFileType>();

  ImageFileType? get imageType => _imageType.value;

  set imageType(value) {
    _imageType.value = value;
  }

  @override
  void onInit() {
    userEntity = Get.arguments;
    emailTEC.text = userEntity.email!;
    nameTEC.text = userEntity.displayName!;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameTEC.dispose();
    emailTEC.dispose();
    super.onClose();
  }

  void editProfile() async {
    final storage = FirebaseStorage.instance.ref();
    final profileImageRef = storage.child('image').child("profile");
    final profileImage = profileImageRef.child(userEntity.id!);
    final file = File(userEntity.photoUrl!);

    profileImage.putFile(file).then((task) async {
      print(task);
      userEntity.displayName = nameTEC.text;
      userEntity.photoUrl = await task.ref.getDownloadURL();
      imageType = ImageFileType.network;
      await userRepository
          .editUserInfo(UserModel.convertEntityToUserModel(userEntity))
          .then((value) {
        userEntity = value!;
        Get.find<HomeController>().userEntity = userEntity;
      }).onError((error, stackTrace) {
        print(error.toString());
        print(stackTrace);
      });
    });
  }

  // Upload Image
  onPickImage({
    required ImageSource source,
  }) async {
    Get.back();
    try {
      File? displayImage =
          await ImagePickerUtils.pickImage(source: source).then(
        (value) async {
          File file = File(value!.path);
          CroppedFile? croppedFile = await ImageCropperUtils.cropImage(file);
          return File(croppedFile!.path);
        },
      );

      if (displayImage != null) {
        imageType = ImageFileType.file;
        userEntity.photoUrl = displayImage.path;
      }
    } catch (e) {
      print(e);
    }
  }

  void onEditProfileImage() {
    CustomModalBottomSheet.showBottomSheet(
      Get.context,
      Text(
        "Edit Profile Photo",
        style: Get.textTheme.titleMedium,
      ),
      ImagePickerContentWidget(
        onTakePhoto: () => onPickImage(source: ImageSource.camera),
        onUploadImage: () => onPickImage(source: ImageSource.gallery),
      ),
    );
  }
}
