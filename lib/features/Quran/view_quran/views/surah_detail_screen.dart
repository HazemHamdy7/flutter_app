// import 'package:flutter/material.dart';
// import 'package:flutter_app/features/Quran/view_quran/model/quran_model.dart';

// class SurahDetailScreen extends StatelessWidget {
//   final Surah surah;

//   const SurahDetailScreen({
//     Key? key,
//     required this.surah,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Use `surah` to display the Surah details and Ayahs
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(surah.name),
//       ),
//       body: ListView.builder(
//         itemCount: surah.ayahs.length,
//         itemBuilder: (context, index) {
//           final ayah = surah.ayahs[index];
//           return ListTile(
//             title: Text(ayah.text),
//             subtitle: Text("Ayah ${ayah.number}"),
//             onTap: () {
//               // Handle modal bottom sheet or any other action
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  final dynamic surah; // Ensure this matches your model type (e.g., Surah)

  const SurahDetailScreen({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.name), // Ensure `surah.name` is valid
      ),
      body: Center(
        child: Text("Surah ID: ${surah.number}"),
      ),
    );
  }
}
