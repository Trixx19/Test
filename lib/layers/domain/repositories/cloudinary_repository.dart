import 'package:image_picker/image_picker.dart';

abstract class CloudinaryRepository {
  Future<String?> uploadImage(XFile image);
}
