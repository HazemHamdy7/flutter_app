
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/Quran/book_mark/cubit/book_mark_cubit.dart';
import 'package:flutter_app/features/Quran/book_mark/model/book_mark_model.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void onLongPress(
    BuildContext context, SurahDetail surahDetail, AyahDetail ayah) {
  showModalBottomSheet(
    context: context,
    builder: (bottomSheetContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(S.of(context).Bookmark_added),
            onTap: () {
              final bookmarkCubit = context.read<BookmarkCubit>();

              final bookmark = Bookmark(
                surahNumber: surahDetail.number,
                ayahNumber: ayah.numberInSurah,
                surahName: surahDetail.name,
                ayahText: ayah.text,
              );

              bookmarkCubit.addBookmark(bookmark);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('تمت إضافة الآية إلى الإشارات المرجعية!')),
              );

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('نسخ'),
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: '${ayah.text} (${ayah.numberInSurah})'),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('مشاركة'),
            onTap: () {
              // Share logic
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
