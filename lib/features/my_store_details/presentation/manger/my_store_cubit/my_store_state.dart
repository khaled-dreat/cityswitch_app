part of 'my_store_cubit.dart';

sealed class MyStoreState extends Equatable {
  const MyStoreState();

  @override
  List<Object> get props => [];
}

final class MyStoreInitial extends MyStoreState {}

final class MyStoreLoading extends MyStoreState {}

final class MyStoreFailurel extends MyStoreState {
  final String errMessage;

  const MyStoreFailurel({required this.errMessage});
}

final class MyStoreSuccess extends MyStoreState {
  final StorsEntites myStore;

  const MyStoreSuccess({required this.myStore});
}
