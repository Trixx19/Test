import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../core/config/cloudinary_config.dart';
import '../cloudinary_datasource.dart';
import 'package:flutter/foundation.dart';

class CloudinaryDataSourceImpl implements CloudinaryDataSource {
  @override
  Future<String?> uploadToCloud(XFile imageFile) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = CloudinaryConfig.uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

        return jsonMap['public_id'];
      } else {
        if (kDebugMode) {
          print('Erro Cloudinary: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception Cloudinary: $e');
      }
      return null;
    }
  }
}
