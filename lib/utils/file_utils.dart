import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/models/enums/document_type.dart';
import 'package:tasky/utils/logger.dart';

class FileUtils {
  static const double fileSizeLimited = 10;

  static double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  static String getDocumentName(String document) {
    return document.split('/').last;
  }

  static String getDocumentType(String document) {
    if (AppConfigs.listTextFileType.contains(
      getDocumentName(document).split('.').last,
    )) {
      return DocumentType.text.name;
    } else {
      return DocumentType.image.name;
    }
  }

  static Future<String> uploadFile({
    required File file,
    required String userID,
    required String type,
  }) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('$userID/$type/${path.basename(file.path)}');
    try {
      await storageReference.putFile(file);
    }  on FirebaseException catch (e) {
      logger.log(e);
    }
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }
}
