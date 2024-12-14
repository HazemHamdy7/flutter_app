import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/book_mark/cubit/book_mark_cubit.dart';
import 'package:flutter_app/features/Quran/book_mark/model/book_mark_model.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'surah_detail_screen.dart';

class BookmarkListScreen extends StatelessWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).Bookmark)),
      body: BlocBuilder<BookmarkCubit, List<Bookmark>>(
        builder: (context, bookmarks) {
          if (bookmarks.isEmpty) {
            return const Center(child: Text('No bookmarks added.'));
          }

          final reversedBookmarks = List<Bookmark>.from(bookmarks.reversed);

          return ListView.builder(
            itemCount: reversedBookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = reversedBookmarks[index];
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      '${bookmark.surahName} - ${S.of(context).ayah} ${bookmark.ayahNumber.toArabicNumbers}',
                    ),
                    subtitle: Text(
                      bookmark.ayahText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () {
                      // final bookmarkCubit = context.read<BookmarkCubit>();
                      // bookmarkCubit.addBookmark(bookmark);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahDetailScreen(
                            surahNumber: bookmark.surahNumber,
                            initialAyahNumber: bookmark.ayahNumber,
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        context.read<BookmarkCubit>().removeBookmark(bookmark);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(S.of(context).Bookmark_removed)),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
