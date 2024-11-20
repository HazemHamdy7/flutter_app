// import 'package:flutter/material.dart';
// import 'package:flutter_app/cubits/language_cubit/language_cubit.dart';
// import 'package:flutter_app/cubits/surah_list_cubit/surah_list_cubit.dart';
// import 'package:flutter_app/cubits/surah_list_cubit/surah_list_state.dart';
// import 'package:flutter_app/generated/l10n.dart';
// import 'package:flutter_app/utils/helper/to_arabic.dart';
// import 'package:flutter_app/views/componant/list_of_quran/list_of_quran.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SurahListScreen extends StatefulWidget {
//   const SurahListScreen({super.key});

//   @override
//   State<SurahListScreen> createState() => _SurahListScreenState();
// }

// class _SurahListScreenState extends State<SurahListScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _filteredSurahs = [];
//   List<dynamic> _allSurahs = [];

//   void _filterSurahs(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredSurahs = _allSurahs;
//       } else {
//         _filteredSurahs = _allSurahs
//             .where((surah) =>
//                 (surah.name?.toLowerCase() ?? '')
//                     .contains(query.toLowerCase()) ||
//                 (surah.englishName?.toLowerCase() ?? '')
//                     .contains(query.toLowerCase()) ||
//                 (surah.englishNameTranslation?.toLowerCase() ?? '')
//                     .contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Two tabs
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(S.of(context).Fuhras),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.language),
//               onPressed: () {
//                 BlocProvider.of<LanguageCubit>(context).changeLanguage("ar");
//               },
//             ),
//           ],
//           bottom: TabBar(
//             indicatorSize: TabBarIndicatorSize.tab,
//             labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//             labelColor: Colors.indigo,
//             unselectedLabelColor: Colors.black54,
//             indicatorColor: Colors.indigo,
//             tabs: [
//               Tab(
//                 text: S.of(context).surah,
//               ), // First Tab
//               Tab(text: S.of(context).Number), // Second Tab
//             ],
//           ),
//         ),
//         body: BlocProvider(
//           create: (context) => SurahCubit()..loadSurahs(),
//           child: BlocBuilder<SurahCubit, SurahState>(
//             builder: (context, state) {
//               if (state is SurahLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is SurahError) {
//                 return Center(child: Text(state.errorMessage));
//               } else if (state is SurahLoaded) {
//                 if (_allSurahs.isEmpty) {
//                   _allSurahs = state.surahs;
//                   _filteredSurahs = _allSurahs;
//                 }

//                 return customTapBar(context);
//               }
//               return const Center(child: Text('No Surah data available'));
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   TabBarView customTapBar(BuildContext context) {
//     return TabBarView(
//       children: [
//         // First Tab: Surah List
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: searchListOfQuran(context),
//             ),
//             Expanded(
//               child: ListOfQuran(filteredSurahs: _filteredSurahs),
//             ),
//           ],
//         ),
//         // Second Tab: Number List
//         ListView.builder(
//           itemCount: _filteredSurahs.length,
//           itemBuilder: (context, index) {
//             final surah = _filteredSurahs[index];
//             final locale = Localizations.localeOf(context);
//             final isArabic = locale.languageCode == 'ar';

//             return ListTile(
//               title: Text(
//                 isArabic ? surah.name : surah.englishName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'me_quran',
//                   fontSize: 16,
//                 ),
//               ),
//               trailing: Text(
//                 isArabic
//                     ? surah.number.toString().toArabicNumbers
//                     : surah.number.toString(),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   TextField searchListOfQuran(BuildContext context) {
//     return TextField(
//       enabled: true,
//       controller: _searchController,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey[200],
//         labelText: S.of(context).search,
//         prefixIcon: const Icon(Icons.search),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       onChanged: _filterSurahs,
//     );
//   }
// }
