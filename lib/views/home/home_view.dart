import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/lanugage_cubit/language_cubit.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/views/home/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<LanguageCubit>().changeLanguage('en');
                },
                child: const Text("en")),
            ElevatedButton(
                onPressed: () {
                  context.read<LanguageCubit>().changeLanguage('ar');
                },
                child: const Text("ar")),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginView();
                }));
              },
              child: Text("Go to login page"),
            ),
          ],
        ),
      ),
    );
  }
}
