import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/long_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import '../../home/view/home_screen.dart';

class UserformScreen extends ConsumerStatefulWidget {
  const UserformScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => NameformScreenState();
}

class NameformScreenState extends ConsumerState<UserformScreen> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    final name = _nameController.text.trim();
    debugPrint("Save pressed with name: $name");

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name")),
      );
      return;
    }

    try {
      // Show loading indicator using a stateful approach instead of dialog
      setState(() {
        _isLoading = true;
      });

      // Get UID first
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        debugPrint("User not logged in");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Update Firestore directly
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': name,
          'email': FirebaseAuth.instance.currentUser?.email ?? '',
          'total_points': 0,
          'redeemed_rewards': []
        }, SetOptions(merge: true));
        debugPrint("Firestore updated directly.");
      } catch (e) {
        debugPrint("Firestore error: $e");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Update Firebase Auth directly
      try {
        await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
        debugPrint("Firebase Auth updated directly.");

        // IMPORTANT: Also update your local auth state
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Force refresh the AuthViewModel state
          ref.read(authViewModelProvider.notifier).refreshUser(user);
        }
      } catch (e) {
        debugPrint("Firebase Auth error: $e");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Wait for a moment to let changes propagate
      await Future.delayed(const Duration(seconds: 2));

      // Hide loading indicator
      setState(() {
        _isLoading = false;
      });

      // Use GoRouter to navigate
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e) {
      debugPrint("Error: $e");
      
      // Try-catch the setState to prevent crashes if widget is unmounted
      try {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (setStateError) {
        debugPrint("setState error: $setStateError");
      }
      
      // Try-catch the SnackBar to prevent crashes if context is invalid
      try {
        // Only show SnackBar if we're still mounted AND context is valid
        if (mounted && context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred: $e")),
          );
        }
      } catch (snackBarError) {
        debugPrint("SnackBar error: $snackBarError");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.primaryContainer,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/svgs/logo.svg',
                          semanticsLabel: 'Logo',
                          width: 163.w,
                          height: 76.73.h,
                        ),
                      ),
                      SizedBox(height: 55.w),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "What’s your name?",
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Your name can be updated later on profile",
                              style: textTheme.bodyLarge,
                            ),
                          ),
                          Lottie.asset(
                            'assets/lotties/service_animation.json',
                            width: 361.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.h,
                                right: 40.w,
                                left: 40.w,
                                bottom: 30.h),
                            child: TextField(
                              maxLines: 1,
                              maxLength: 20,
                              controller: _nameController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorScheme.primary, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          LongButton(
                            press: _onSavePressed,
                            text: "Save",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
