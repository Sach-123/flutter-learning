part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final Product clickedProduct;

  RemoveFromCart({required this.clickedProduct});

}
