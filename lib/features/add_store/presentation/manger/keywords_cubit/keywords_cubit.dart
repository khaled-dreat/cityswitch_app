import 'package:flutter_bloc/flutter_bloc.dart';

class KeywordsCubit extends Cubit<List<String>> {
  KeywordsCubit() : super([]);

  void addKeyword(String keyword) {
    if (keyword.trim().isEmpty) return;
    final updatedKeywords = List<String>.from(state)..add(keyword.trim());
    emit(updatedKeywords);
  }

  void removeKeyword(int index) {
    final updatedKeywords = List<String>.from(state)..removeAt(index);
    emit(updatedKeywords);
  }
}
