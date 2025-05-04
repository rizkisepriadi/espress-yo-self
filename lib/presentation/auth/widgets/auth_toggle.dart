import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AuthMode { login, register }

final authModeProvider = StateProvider<AuthMode>((ref) => AuthMode.login);

class AuthToggle extends ConsumerWidget {
  const AuthToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final authMode = ref.watch(authModeProvider);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              ref.read(authModeProvider.notifier).state = AuthMode.login;
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 13.w, bottom: 13.w),
                backgroundColor: authMode == AuthMode.login
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerLow,
                foregroundColor: authMode == AuthMode.login
                    ? colorScheme.onPrimary
                    : colorScheme.onPrimaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.r))),
            child: Text(
              "Login",
              style: textTheme.titleMedium?.copyWith(
                  color: authMode == AuthMode.login
                      ? colorScheme.onPrimary
                      : colorScheme.onPrimaryContainer),
            ),
          )),
          SizedBox(width: 8.w),
          Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    ref.read(authModeProvider.notifier).state =
                        AuthMode.register;
                  },
                  child: Text("Regiter",
                      style: textTheme.titleMedium?.copyWith(
                          color: authMode == AuthMode.register
                              ? colorScheme.onPrimary
                              : colorScheme.onPrimaryContainer)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 13.w, bottom: 13.w),
                    backgroundColor: authMode == AuthMode.register
                        ? colorScheme.primary
                        : colorScheme.surfaceContainer,
                    foregroundColor: authMode == AuthMode.register
                        ? colorScheme.onPrimary
                        : colorScheme.onPrimaryContainer,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.r),
                    ),
                  )))
        ],
      ),
    );
  }
}
