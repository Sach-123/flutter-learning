import 'package:flutter/material.dart';
import 'package:shopping/features/cart/bloc/cart_bloc.dart';
import 'package:shopping/features/home/model/product.dart';

class CartTile extends StatelessWidget {
  final Product cartProduct;
  final CartBloc cartBloc;
  const CartTile(
      {super.key, required this.cartProduct, required this.cartBloc});

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
                cartProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              Text(
                cartProduct.category,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            cartProduct.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            cartProduct.brand,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${cartProduct.price}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  cartBloc.add(RemoveFromCart(clickedProduct: cartProduct));
                },
                icon: const Icon(
                  Icons.shopping_bag,
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
