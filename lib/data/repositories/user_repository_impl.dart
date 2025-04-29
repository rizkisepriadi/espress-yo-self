import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';

import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  final AuthService authService;

  UserRepositoryImpl({required this.firestore, required this.authService});

  @override
  Future<UserEntity> getCurrentUser() async {
    final user = authService.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!).toEntity();
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> updateUserPoints(String userId, int newPoints) async {
    await firestore
        .collection('users')
        .doc(userId)
        .update({'total_points': newPoints});
  }
}
