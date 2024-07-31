import 'package:flutter/material.dart';
import 'package:shopping/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping/features/home/model/product.dart';

class WishlistTile extends StatelessWidget {
  final Product wishlistProduct;
  final WishlistBloc wishlistBloc;
  const WishlistTile(
      {super.key, required this.wishlistProduct, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.network(
                wishlistProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              Text(
                wishlistProduct.category,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            wishlistProduct.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            wishlistProduct.brand,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${wishlistProduct.price}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  wishlistBloc
                      .add(RemoveFromWishlist(clickedProduct: wishlistProduct));
                },
                icon: const Icon(
                  Icons.favorite,
                  size: 30,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
