import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/wishlist_cart.dart';
import 'package:shopping/features/home/model/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);

    on<RemoveFromCart>(removeFromCart);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    try {
      final List<Product> cartProducts = cart;
      emit(CartSuccessState(product: cartProducts));
    } catch (e) {
      emit(CartFailureState());
    }
  }

  FutureOr<void> removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    cart.remove(event.clickedProduct);
    emit(CartSuccessState(product: cart));
  }
}
