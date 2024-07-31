part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {
  final List<Product> product;
  CartSuccessState({required this.product});
}

final class CartFailureState extends CartState {}
