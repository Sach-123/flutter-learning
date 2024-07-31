part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class ProductAddedToWishlist extends HomeEvent {
  final Product clickedProduct;

  ProductAddedToWishlist({required this.clickedProduct});
}

class ProductAddedToCart extends HomeEvent {
  final Product clickedProduct;

  ProductAddedToCart({required this.clickedProduct});

}

class NavigateToWishlistPage extends HomeEvent {}

class NavigateToCartPage extends HomeEvent {}