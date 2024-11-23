import 'package:flutter/material.dart';
import 'package:flutter_app/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_app/features/choose_systom/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/features/choose_systom/view/choose_system.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LanguageCubit()..changeLanguage("ar")),
        BlocProvider(create: (context) => ThemeCubit()..setInintialTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, languageState) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: languageState,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  title: 'Flutter Demo',
                  theme: themeState.themeData,
                  home: const ChooseSystem());
            },
          );
        },
      ),
    );
  }
}
