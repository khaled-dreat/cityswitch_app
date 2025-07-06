// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_my_store_cubit.dart';

abstract class EditMyStoreState extends Equatable {
  const EditMyStoreState();

  @override
  List<Object> get props => [];
}

class AddMarketInitial extends EditMyStoreState {}

class AddCategoryValidator extends EditMyStoreState {
  final String msg;

  const AddCategoryValidator({required this.msg});
}

class AddSubCategoryValidator extends EditMyStoreState {
  final String msg;

  const AddSubCategoryValidator({required this.msg});
}

class AddImagesValidator extends EditMyStoreState {
  final String msg;

  const AddImagesValidator(this.msg);
}

class AddTagsValidator extends EditMyStoreState {
  final String msg;

  const AddTagsValidator(this.msg);
}

class SearchAddressesSuccess extends EditMyStoreState {
  final List<SearchAddressesModel> searchAddressesModel;
  const SearchAddressesSuccess({required this.searchAddressesModel});
}

class SearchAddressesFailure extends EditMyStoreState {
  final String errMessage;
  const SearchAddressesFailure({required this.errMessage});
}

class SearchAddressesLoading extends EditMyStoreState {}

class AddStoreSuccess extends EditMyStoreState {
  final AddStoreModel store;
  const AddStoreSuccess({required this.store});
}

class AddStoreFailure extends EditMyStoreState {
  final String errMessage;
  const AddStoreFailure({required this.errMessage});
}

class AddStoreLoading extends EditMyStoreState {}
