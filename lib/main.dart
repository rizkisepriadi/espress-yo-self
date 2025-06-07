import 'package:espress_yo_self/constants/themes/color_app.dart';
import 'package:espress_yo_self/firebase_options.dart';
import 'package:espress_yo_self/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Supabase.initialize(
      url: 'https://wdbuxjfehqcrnydksdjs.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndkYnV4amZlaHFjcm55ZGtzZGpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzMTE4MzksImV4cCI6MjA2Mzg4NzgzOX0.ctPG2ZTCceOdxhpcR_l0uSm1M2LWtBw-8o79K2Ah_P8',
    );
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Espress Yo Self',
          theme: _appTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          builder: (context, child) {
            ErrorWidget.builder = (details) {
              return CustomErrorWidget(errorDetails: details);
            };
            return child ?? const Scaffold();
          },
        );
      },
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomErrorWidget({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.red,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Something is not right here...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

final ThemeData _appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: colorSchemeLight,
  fontFamily: GoogleFonts.roboto().fontFamily,
);
