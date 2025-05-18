import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'app_exception.dart';


Future<T> safeCall<T>(Future<T> Function() block, {String label = ''}) async {
  try {
    return await block();
  } on FirebaseException catch (e) {
    developer.log('Firestore error in $label: ${e.message}', error: e);
    throw AppException(e.message ?? 'Terjadi kesalahan Firebase', code: e.code);
  } catch (e, stack) {
    developer.log('Unknown error in $label', error: e, stackTrace: stack);
    rethrow;
  }
}
