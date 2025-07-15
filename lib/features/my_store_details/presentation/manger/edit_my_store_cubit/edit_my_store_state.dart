part of 'edit_my_store_cubit.dart';

sealed class EditMyStoreState extends Equatable {
  const EditMyStoreState();

  @override
  List<Object> get props => [];
}

final class EditMyStoreInitial extends EditMyStoreState {}

final class EditMyStoreLoading extends EditMyStoreState {}

final class EditMyStoreFailurel extends EditMyStoreState {
  final String errMessage;

  const EditMyStoreFailurel({required this.errMessage});
}

final class EditMyStoreSuccess extends EditMyStoreState {
  final EditMyStoreModel editMyStoreModel;
  const EditMyStoreSuccess({required this.editMyStoreModel});
}

class EditCategoryValidator extends EditMyStoreState {
  final String msg;

  const EditCategoryValidator({required this.msg});
}

class EditSubCategoryValidator extends EditMyStoreState {
  final String msg;

  const EditSubCategoryValidator({required this.msg});
}

class EditImagesValidator extends EditMyStoreState {
  final String msg;

  const EditImagesValidator(this.msg);
}

class EditTagsValidator extends EditMyStoreState {
  final String msg;

  const EditTagsValidator(this.msg);
}
