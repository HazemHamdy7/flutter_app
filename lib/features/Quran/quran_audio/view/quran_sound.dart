import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/quran_audio/cubit/quran_audio_cubit.dart';
import 'package:flutter_app/features/Quran/quran_audio/cubit/quran_sound_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranSoundScreen extends StatelessWidget {
  const QuranSoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranAudioCubit()..fetchQuranData(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Quran")),
        body: BlocBuilder<QuranAudioCubit, QuranAudioState>(
          builder: (context, state) {
            if (state is QuranAudioLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuranAudioLoaded) {
              return ListView.builder(
                itemCount: state.quran.data?.surahs?.length,
                itemBuilder: (context, index) {
                  final surah = state.quran.data?.surahs?[index];
                  return ListTile(
                    title: Text(surah?.name ?? ''),
                    onTap: () {
                      // Navigate to Surah detail screen
                    },
                  );
                },
              );
            } else if (state is QuranAudioError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text("Welcome to Quran App"));
          },
        ),
      ),
    );
  }
}
