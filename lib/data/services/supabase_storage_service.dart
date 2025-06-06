import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _supabase;
  
  SupabaseStorageService({SupabaseClient? supabase}) 
      : _supabase = supabase ?? Supabase.instance.client;

  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      final fileName = 'profile_${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = 'profiles/$fileName';
      
      await _supabase.storage
          .from('user-images')
          .upload(filePath, imageFile);
      
      final publicUrl = _supabase.storage
          .from('user-images')
          .getPublicUrl(filePath);
      
      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteProfileImage(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final filePath = pathSegments.sublist(pathSegments.indexOf('user-images') + 1).join('/');
      
      await _supabase.storage
          .from('user-images')
          .remove([filePath]);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}