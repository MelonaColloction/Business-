import 'package:flutter/material.dart';
import 'localization.dart';
import 'screens.dart';
import 'theme.dart';

class BusinessManagerApp extends StatefulWidget {
  const BusinessManagerApp({super.key});

  @override
  State<BusinessManagerApp> createState() => BusinessManagerAppState();
}

class BusinessManagerAppState extends State<BusinessManagerApp> {
  Locale locale = const Locale('en');
  ThemeMode themeMode = ThemeMode.light;

  void setLocale(String code) => setState(() => locale = Locale(code));
  void toggleTheme() => setState(() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [
        Locale('en'), Locale('fa'), Locale('fr'), Locale('de'), Locale('zh'),
      ],
      builder: (context, child) {
        final rtl = locale.languageCode == 'fa';
        return Directionality(
          textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: HomeScreen(
        locale: locale,
        onLocaleChanged: setLocale,
        onThemeChanged: toggleTheme,
      ),
      localizationsDelegates: const [AppLocalizationsDelegate()],
    );
  }
}
