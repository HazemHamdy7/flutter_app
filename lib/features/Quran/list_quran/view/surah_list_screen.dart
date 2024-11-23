import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/custom_appbar.dart';
import 'package:flutter_app/widgets/custom_text_field_search.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/list_view_of_quran.dart';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/features/Quran/list_quran/cubit/surah_list_cubit.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  List<dynamic> _filteredSurahs = [];
  List<dynamic> _allSurahs = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(context),
        body: BlocProvider(
          create: (context) => SurahCubit()..fetchSurahs(),
          child: BlocBuilder<SurahCubit, List<Surah>>(
            builder: (context, surahs) {
              if (surahs.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (_allSurahs.isEmpty) {
                  _allSurahs = surahs;
                  _filteredSurahs = surahs; //
                }

                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFieldtoSearch(
                          onChanged: (query) =>
                              context.read<SurahCubit>()..filterSurahs(query),
                        )),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListViewOfQuran(
                              surahs: _filteredSurahs
                                  .where((surah) => surah.name != null)
                                  .toList()),
                          ListViewOfQuran(
                              surahs: _filteredSurahs
                                  .where((surah) => surah.number != null)
                                  .toList()),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
