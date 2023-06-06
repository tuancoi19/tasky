import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/enums/document_type.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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
    } on FirebaseException catch (e) {
      logger.log(e);
    }
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }

  static String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    final decodedPath = Uri.decodeComponent(path);
    final segments = decodedPath.split('/');
    final fileName = segments.last;
    return fileName;
  }

  static Future<void> openFile(String documentPath) async {
    if (documentPath.startsWith(AppConfigs.firebaseStoragePrefix)) {
      if (await canLaunchUrl(Uri.parse(documentPath))) {
        await launchUrl(
          Uri.parse(documentPath),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        AppSnackbar.showError(
          title: S.current.document,
          message: S.current.cant_open_document,
        );
      }
    } else {
      final result = await OpenFile.open(documentPath);
      if (result.type == ResultType.noAppToOpen) {
        AppSnackbar.showError(
          title: S.current.document,
          message: S.current.cant_open_document,
        );
      }
    }
  }
}
