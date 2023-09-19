import 'package:image_picker/image_picker.dart';
import 'package:tit/app/core/utils/permission_handler.dart';



class ImagePickerUtils {
  static Future<XFile?> pickImage({
    required ImageSource source,
  }) async {
    XFile? pickedFile;
    try {

      pickedFile = await ImagePicker().pickImage(
        source: source,
        requestFullMetadata: false,
      );
      return pickedFile;
    } catch (e) {
      print(e);

      bool canProceed =
          await PermissionHandler().handleImageUploadPermissions(source);

      if (canProceed) {
        pickImage(source: source);
      }
    }
  }
}
