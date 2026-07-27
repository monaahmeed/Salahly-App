//بسم رب البدايات نبدأ
// بسم الله توكلنا على الله 23-7-2026
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:salahly/core/services/app_router.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
