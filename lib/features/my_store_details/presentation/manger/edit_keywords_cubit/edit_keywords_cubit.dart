import 'package:flutter_bloc/flutter_bloc.dart';

class EditKeywordsCubit extends Cubit<List<String>> {
  EditKeywordsCubit() : super([]);

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
