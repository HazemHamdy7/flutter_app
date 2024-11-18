// import 'package:flutter/material.dart';
// import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';
// import 'package:flutter_app/generated/l10n.dart';

// class ListOfQuran extends StatelessWidget {
//   const ListOfQuran({
//     super.key,
//     required List filteredSurahs,
//   }) : _filteredSurahs = filteredSurahs;

//   final List _filteredSurahs;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _filteredSurahs.length,
//       itemBuilder: (context, index) {
//         final surah = _filteredSurahs[index];
//         final backgroundColor =
//             index % 2 == 0 ? Colors.grey[200] : Colors.white;

//         return Container(
//           color: backgroundColor,
//           child: ListTile(
//             title: Text(
//               '${surah.number} - ${surah.name}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "me_quran",
//               ),
//             ),
//             subtitle: Text(surah.englishName),
//             trailing: Text(
//               '${S.of(context).ayah} - ${surah.numberOfAyahs}',
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: "me_quran",
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SurahDetailScreen(),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
