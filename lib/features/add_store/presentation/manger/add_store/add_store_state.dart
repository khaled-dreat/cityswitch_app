// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_store_cubit.dart';

abstract class AddStoreState extends Equatable {
  const AddStoreState();

  @override
  List<Object> get props => [];
}

class AddMarketInitial extends AddStoreState {}

class AddCategoryValidator extends AddStoreState {
  final String msg;

  const AddCategoryValidator({required this.msg});
}

class AddSubCategoryValidator extends AddStoreState {
  final String msg;

  const AddSubCategoryValidator({required this.msg});
}

class AddImagesValidator extends AddStoreState {
  final String msg;

  const AddImagesValidator(this.msg);
}

class AddTagsValidator extends AddStoreState {
  final String msg;

  const AddTagsValidator(this.msg);
}

class SearchAddressesSuccess extends AddStoreState {
  final List<SearchAddressesModel> searchAddressesModel;
  const SearchAddressesSuccess({required this.searchAddressesModel});
}

class SearchAddressesFailure extends AddStoreState {
  final String errMessage;
  const SearchAddressesFailure({required this.errMessage});
}

class SearchAddressesLoading extends AddStoreState {}

class AddStoreSuccess extends AddStoreState {
  final AddStoreModel store;
  const AddStoreSuccess({required this.store});
}

class AddStoreFailure extends AddStoreState {
  final String errMessage;
  const AddStoreFailure({required this.errMessage});
}

class AddStoreLoading extends AddStoreState {}
