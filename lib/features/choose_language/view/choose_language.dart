import 'package:flutter/material.dart';
import 'package:flutter_app/features/choose_language/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_app/features/choose_system/view/choose_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit()..changeLanguage('ar'),
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ChooseLanguage'),
              ElevatedButton(
                  onPressed: () {
                    context.read<LanguageCubit>().changeLanguage('ar');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChooseSystem()));
                  },
                  child: const Text('Arabic')),
              ElevatedButton(
                  onPressed: () {
                    context.read<LanguageCubit>().changeLanguage('en');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChooseSystem()));
                  },
                  child: const Text('English')),
            ],
          ),
        ),
      ),
    );
  }
}
