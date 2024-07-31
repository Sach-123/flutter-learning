import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/wishlist_cart.dart';
import 'package:shopping/features/home/model/product.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);

    on<RemoveFromWishlist>(removeFromWishlist);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistLoadingState());
    try {
      final List<Product> wishlistProducts = wishlist;
      emit(WishlistSuccessState(product: wishlistProducts));
    } catch (e) {
      emit(WishlistFailureState());
    }
  }

  FutureOr<void> removeFromWishlist(RemoveFromWishlist event, Emitter<WishlistState> emit) {
    wishlist.remove(event.clickedProduct);
    emit(WishlistSuccessState(product: wishlist));
  }
}
