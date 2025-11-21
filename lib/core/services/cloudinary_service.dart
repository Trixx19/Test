import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

class CloudinaryService {
  // Credenciais
  static const String cloudName = "dt27zchmx";
  static const String uploadPreset = "chf_preset";

  static final Cloudinary cld = Cloudinary.fromCloudName(cloudName: cloudName);

  Future<String?> uploadImage(XFile imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    if (kDebugMode) {
      print('🚀 [Cloudinary] Iniciando upload: ${imageFile.path}');
    }

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final publicId = jsonMap['public_id'];

        if (kDebugMode) {
          debugPrint('✅ Upload Sucesso! ID: $publicId');
        }
        return publicId;
      } else {
        if (kDebugMode) {
          debugPrint('❌ Erro: ${response.body}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('🔥 Exception: $e');
      return null;
    }
  }
}
