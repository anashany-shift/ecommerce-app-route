part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsEmpty extends ProductsState {}
final class ProductsLoading extends ProductsState {}
final class ProductsSuccess extends ProductsState {
  final List<Product>product;

  ProductsSuccess(this.product);
}
final class ProductsError extends ProductsState {
  final String errorMessage;

  ProductsError(this.errorMessage);
}
