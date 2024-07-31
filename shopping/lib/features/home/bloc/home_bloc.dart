import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/electonic_data.dart';
import 'package:shopping/data/wishlist_cart.dart';
import 'package:shopping/features/home/model/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<NavigateToWishlistPage>(navigateToWishlistPage);

    on<NavigateToCartPage>(navigateToCartPage);

    on<ProductAddedToWishlist>(productAddedToWishlist);

    on<ProductAddedToCart>(productAddedToCart);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    final List<Product> products;
    try {
      products = ElectronicData.electronicsProducts
          .map((product) => Product(
              id: product['id'],
              name: product['name'],
              brand: product['brand'],
              price: product['price'],
              category: product['category'],
              imageUrl: product['imageUrl']))
          .toList();
      emit(HomeSuccessState(products: products));
    } catch (e) {
      emit(HomeFailureState());
    }
  }

  FutureOr<void> navigateToWishlistPage(
      NavigateToWishlistPage event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlist());
  }

  FutureOr<void> navigateToCartPage(
      NavigateToCartPage event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCart());
  }

  FutureOr<void> productAddedToWishlist(
      ProductAddedToWishlist event, Emitter<HomeState> emit) {
    wishlist.add(event.clickedProduct);
    emit(HomeProductAddedToWishlistState());
  }

  FutureOr<void> productAddedToCart(
      ProductAddedToCart event, Emitter<HomeState> emit) {
    cart.add(event.clickedProduct);
    emit(HomeProductAddedToCartState());
  }
}
