import 'package:flutter_bloc/flutter_bloc.dart';

class StoreFilterCubit extends Cubit<String?> {
  StoreFilterCubit() : super(null);

  void selectCategory(String category) {
    emit(category);
  }
}
