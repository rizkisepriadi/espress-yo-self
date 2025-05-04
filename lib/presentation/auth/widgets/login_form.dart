import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/long_button.dart';
import 'package:espress_yo_self/presentation/common/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    try {
      await ref.read(authViewModelProvider.notifier).signInWithEmail(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    } on FirebaseAuthException catch (e) {
      final message = _mapFirebaseAuthError(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error occurred")),
      );
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email tidak valid.';
      case 'user-disabled':
        return 'Akun ini telah dinonaktifkan.';
      case 'user-not-found':
        return 'Email tidak ditemukan.';
      case 'wrong-password':
        return 'Password salah.';
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }

  void _onGoogleLoginPressed() async {
    await ref.read(authViewModelProvider.notifier).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        TextFieldWidget(
          placeholder: "Email",
          controller: _emailController,
          icon: Icon(Icons.email_outlined),
        ),
        SizedBox(height: 26.h),
        TextFieldWidget(
          placeholder: "Password",
          controller: _passwordController,
          icon: Icon(Icons.lock_outlined),
          isPassword: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
        SizedBox(height: 10.h),
        LongButton(press: () => _onLoginPressed(), text: "Login"),
        SizedBox(height: 31.h),
        Text(
          "Or Login With",
          style: textTheme.titleSmall,
        ),
        SizedBox(height: 21.h),
        LongButton(
          press: () => _onGoogleLoginPressed(),
          image: "assets/svgs/google_logo.svg",
          color: Color(0xFFEAEEF2),
        )
      ],
    );
  }
}
