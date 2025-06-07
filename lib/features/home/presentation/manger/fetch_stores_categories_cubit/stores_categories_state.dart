// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stores_categories_cubit.dart';

abstract class StoresCategoriesState extends Equatable {
  const StoresCategoriesState();

  @override
  List<Object> get props => [];
}

class StoresCategoriesInitial extends StoresCategoriesState {}

class StoresCategoriesLoading extends StoresCategoriesState {}

class StoresCategoriesFailure extends StoresCategoriesState {
  final String errMessage;
  const StoresCategoriesFailure({required this.errMessage});
}

class StoresCategoriesSuccess extends StoresCategoriesState {
  final List<StoresCategoriesEntites> storesCategories;
  const StoresCategoriesSuccess({required this.storesCategories});
}
