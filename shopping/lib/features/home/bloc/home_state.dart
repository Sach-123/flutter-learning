part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<Product> products;

  HomeSuccessState({required this.products});
}

final class HomeFailureState extends HomeState {}

final class HomeNavigateToCart extends HomeActionState {
}

final class HomeNavigateToWishlist extends HomeActionState {
}

final class HomeProductAddedToWishlistState extends HomeActionState {}

final class HomeProductAddedToCartState extends HomeActionState {}
