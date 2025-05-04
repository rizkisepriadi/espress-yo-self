import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/long_button.dart';
import 'package:espress_yo_self/presentation/common/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() async {
    final password = _passwordController.text.trim();
    final retypePassword = _retypePasswordController.text.trim();

    if (password != retypePassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match")));
      return;
    }

    await ref.read(authViewModelProvider.notifier).registerWithEmail(
        _emailController.text.trim(), _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 26.h),
        TextFieldWidget(
          placeholder: "Retype Password",
          controller: _retypePasswordController,
          icon: Icon(Icons.lock_outlined),
          isPassword: true,
        ),
        SizedBox(height: 26.h),
        LongButton(press: () => _onRegisterPressed(), text: "Register"),
      ],
    );
  }
}
