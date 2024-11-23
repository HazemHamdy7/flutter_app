import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/view/surah_list_screen.dart';
import 'package:flutter_app/features/choose_systom/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseSystem extends StatefulWidget {
  const ChooseSystem({super.key});

  @override
  State<ChooseSystem> createState() => _ChooseSystemState();
}

class _ChooseSystemState extends State<ChooseSystem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeData == ThemeData.dark();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isDark ? 'Dark Mode' : 'Light Mode',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      context
                          .read<ThemeCubit>()
                          .toggleTheme(value); // Toggle theme
                    },
                    activeColor: isDark ? Colors.black : Colors.black,
                    inactiveThumbColor: isDark ? Colors.white : Colors.black,
                    inactiveTrackColor: Colors.white,
                    activeTrackColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Change Language',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SurahListPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Go to Quran',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
