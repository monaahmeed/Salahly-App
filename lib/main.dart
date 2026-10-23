//بسم رب البدايات نبدأ
// بسم الله توكلنا على الله 23-7-2026
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/services/service_locator.dart';
import 'package:salahly/firebase_options.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  await setupServiceLocator();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const SalahlyApp(),
    ),
  );
}

class SalahlyApp extends StatelessWidget {
  const SalahlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'app_title'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
    );
  }
}
