import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping/features/wishlist/ui/wishlist_tile.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      listenWhen: (previous, current) => current is WishlistActionState,
      buildWhen: (previous, current) => current is! WishlistActionState,
      listener: (context, state) {
        if (state is RemoveFromWishlist) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product removed from Wishlist")));
        }
      },
      builder: (context, state) {
        if (state is WishlistLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WishlistSuccessState) {
          final wishlistProducts = state.product;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Wishlist"),
              backgroundColor: Colors.teal,
            ),
            body: wishlistProducts.isEmpty
                ? const Center(
                    child: Text("No Items in wishlist"),
                  )
                : ListView.builder(
                    itemCount: wishlistProducts.length,
                    itemBuilder: (context, index) => WishlistTile(
                        wishlistBloc: wishlistBloc, wishlistProduct: wishlistProducts[index])),
          );
        } else if (state is WishlistFailureState) {
          return const Center(child: Text("Failed to load wishlist"));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
