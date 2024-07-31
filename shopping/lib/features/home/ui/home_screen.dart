import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/cart/ui/cart.dart';
import 'package:shopping/features/home/bloc/home_bloc.dart';
import 'package:shopping/features/home/ui/product_tile.dart';
import 'package:shopping/features/wishlist/ui/wishlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCart) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlist) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductAddedToWishlistState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to wishlist")));
        } else if (state is HomeProductAddedToCartState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Product added to cart")));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeSuccessState) {
          final products = state.products;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              backgroundColor: Colors.teal,
              actions: [
                IconButton(
                    onPressed: () {
                      homeBloc.add(NavigateToWishlistPage());
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      homeBloc.add(NavigateToCartPage());
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ))
              ],
            ),
            body: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    ProductTile(homeBloc: homeBloc, product: products[index])),
          );
        } else if (state is HomeFailureState) {
          return const Center(
            child: Text("Error Occured"),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
