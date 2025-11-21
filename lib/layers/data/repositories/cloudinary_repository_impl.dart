import 'package:image_picker/image_picker.dart';
import '../../domain/repositories/cloudinary_repository.dart';
import '../datasources/cloudinary_datasource.dart';

class CloudinaryRepositoryImpl implements CloudinaryRepository {
  final CloudinaryDataSource _dataSource;

  CloudinaryRepositoryImpl(this._dataSource);

  @override
  Future<String?> uploadImage(XFile image) async {
    return await _dataSource.uploadToCloud(image);
  }
}
