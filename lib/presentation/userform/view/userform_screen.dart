import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/long_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class UserformScreen extends ConsumerStatefulWidget {
  const UserformScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => NameformScreenState();
}

class NameformScreenState extends ConsumerState<UserformScreen> {
  final _nameController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser?.uid;
  bool _isLoading = false;

  // Add a cancellation token
  bool _cancelled = false;

  @override
  void dispose() {
    // Mark as cancelled when disposed
    _cancelled = true;
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
      // Show loading indicator
      if (!_cancelled && mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      // First update Firestore through UserViewModel
      await ref
          .read(getUserViewModelProvider.notifier)
          .updateUserProfile(userId!, name);
      debugPrint("User profile updated through proper architecture");

      // Check cancellation
      if (_cancelled) return;

      // Then update Firebase Auth
      await ref
          .read(authViewModelProvider.notifier)
          .updateUserProfile(name, null);
      debugPrint("Auth profile updated through proper architecture");

      // Force refresh of auth state to ensure router sees the correct state
      ref.refresh(authViewModelProvider);

      // IMPORTANT: Use a longer delay to ensure state propagation
      await Future.delayed(const Duration(seconds: 2));

      // Check cancellation before continuing
      if (_cancelled) return;

      // Navigate with special parameter to bypass redirect
      if (mounted && context.mounted) {
        context.go('/home?fromProfile=true');
      }
    } catch (e) {
      // Only try to update state if not cancelled
      if (!_cancelled && mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
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
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onPrimaryContainer,
                              ),
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
