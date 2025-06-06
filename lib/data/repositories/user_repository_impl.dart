import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/data/services/supabase_storage_service.dart';
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';
import 'package:espress_yo_self/utils/safe_call.dart';
import 'package:flutter/material.dart';

import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  final AuthService authService;
  final SupabaseStorageService storageService;

  UserRepositoryImpl({
    required this.firestore,
    required this.authService,
    required this.storageService,
  });

  @override
  Future<UserEntity> getCurrentUser() async {
    return await safeCall(() async {
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
    }, label: 'getCurrentUser');
  }

  @override
  Future<void> updateUserPoints(String userId, int newPoints) async {
    return await safeCall(() async {
      await firestore
          .collection('users')
          .doc(userId)
          .update({'total_points': newPoints});
    }, label: 'updateUserPoints');
  }

  @override
  Future<void> updateStampProgress(String userId, int stamps) async {
    return await safeCall(() async {
      final userDoc = firestore.collection('users').doc(userId);
      await userDoc.update({'stamp_progress': stamps});
    }, label: 'updateStampProgress');
  }

  @override
  Future<void> updateUserProfile(String userId, String name,
      {File? profileImage}) async {
    return safeCall(() async {
      final userDocRef = firestore.collection('users').doc(userId);
      final docSnapshot = await userDocRef.get();

      String? profileImageUrl;

      if (profileImage != null) {
        if (docSnapshot.exists) {
          final oldImageUrl =
              docSnapshot.data()?['profile_image_url'] as String?;
          if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
            try {
              await storageService.deleteProfileImage(oldImageUrl);
            } catch (e) {
              debugPrint('Failed to delete old profile image: $e');
            }
          }
        }

        profileImageUrl =
            await storageService.uploadProfileImage(userId, profileImage);

        await authService.updateUserProfile(name, profileImageUrl);
      } else {
        await authService.updateUserProfile(name, null);
      }

      if (!docSnapshot.exists) {
        await userDocRef.set({
          'id': userId,
          'name': name,
          'email': authService.currentUser?.email ?? '',
          'profile_image_url':
              profileImageUrl ?? authService.currentUser?.photoURL ?? '',
          'total_points': 0,
          'redeemed_rewards': []
        });
      } else {
        final updateData = <String, dynamic>{'name': name};
        if (profileImageUrl != null) {
          updateData['profile_image_url'] = profileImageUrl;
        }
        await userDocRef.update(updateData);
      }
    }, label: 'updateUserProfile');
  }

  
}
