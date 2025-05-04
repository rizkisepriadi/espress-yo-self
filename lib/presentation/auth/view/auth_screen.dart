import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/auth_toggle.dart';
import '../widgets/register_form.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final authState = ref.watch(authViewModelProvider);
    final authMode = ref.watch(authModeProvider);

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
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (authMode == AuthMode.login)
                                ? "Log in to your account"
                                : "Let’s get you started!",
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 32.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (authMode == AuthMode.login)
                                ? "Sign in and pick up where you left off — your rewards are waiting."
                                : "Create your account and start earning points with every cup.",
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      SizedBox(height: 21.h),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16.h),
                                const AuthToggle(),
                                SizedBox(height: 40.h),
                                if (authMode == AuthMode.login)
                                  const LoginForm()
                                else
                                  const RegisterForm(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (authState.isLoading)
            Container(
              color: Colors.black.withAlpha(30),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
