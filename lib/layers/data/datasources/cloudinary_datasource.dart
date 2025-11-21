import 'package:image_picker/image_picker.dart';

abstract class CloudinaryDataSource {
  Future<String?> uploadToCloud(XFile imageFile);
}
