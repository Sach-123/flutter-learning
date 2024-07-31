part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class RemoveFromWishlist extends WishlistEvent {
  final Product clickedProduct;

  RemoveFromWishlist({required this.clickedProduct});

}
