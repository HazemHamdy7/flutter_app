import 'package:flutter_app/features/Quran/book_mark/model/book_mark_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<List<Bookmark>> {
  BookmarkCubit() : super([]);

  void addBookmark(Bookmark bookmark) {
    final updatedBookmarks = List<Bookmark>.from(state)..add(bookmark);
    emit(updatedBookmarks);
  }

  void removeBookmark(Bookmark bookmark) {
    final updatedList = List<Bookmark>.from(state);
    updatedList.remove(bookmark);
    emit(updatedList);
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    return state
        .any((b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber);
  }
}
