import 'package:flutter_app/features/Quran/view_quran/model/book_mark_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<List<Bookmark>> {
  BookmarkCubit() : super([]);

 
  void addBookmark(Bookmark bookmark) {
    final updatedBookmarks = List<Bookmark>.from(state)..add(bookmark);
    emit(updatedBookmarks);
  }

  void removeBookmarkByDetails(
      {required int surahNumber, required int ayahNumber}) {
    emit(state
        .where((b) =>
            !(b.surahNumber == surahNumber && b.ayahNumber == ayahNumber))
        .toList());
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    return state
        .any((b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber);
  }
}
