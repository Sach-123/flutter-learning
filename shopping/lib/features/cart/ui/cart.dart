import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/cart/bloc/cart_bloc.dart';
import 'package:shopping/features/cart/ui/cart_tile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {
        if (state is RemoveFromCart) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product removed from Cart")));
        }
      },
      builder: (context, state) {
        if (state is CartLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartSuccessState) {
          final cartProducts = state.product;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              backgroundColor: Colors.teal,
            ),
            body: cartProducts.isEmpty
                ? const Center(
                    child: Text("No Items in cart"),
                  )
                : ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) => CartTile(
                        cartBloc: cartBloc, cartProduct: cartProducts[index])),
          );
        } else if (state is CartFailureState) {
          return const Center(child: Text("Failed to load cart"));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
