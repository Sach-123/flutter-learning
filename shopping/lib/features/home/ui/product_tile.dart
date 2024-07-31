import 'package:flutter/material.dart';
import 'package:shopping/features/home/bloc/home_bloc.dart';
import 'package:shopping/features/home/model/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final HomeBloc homeBloc;
  const ProductTile({super.key, required this.product, required this.homeBloc});

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
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              Text(
                product.category,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            product.brand,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        homeBloc.add(ProductAddedToWishlist(clickedProduct: product));
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        homeBloc.add(ProductAddedToCart(clickedProduct: product));
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
