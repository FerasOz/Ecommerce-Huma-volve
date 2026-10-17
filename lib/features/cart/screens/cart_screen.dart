import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/cart/presentation/cubit/cart_states.dart';
import 'package:ecommerce_app_huma_volve/features/cart/widgets/cart_item_card.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is CartErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CartInitialState || state is CartLoadingState) {
          return Scaffold(
            backgroundColor: AppTheme.background,
            appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final items = switch (state) {
          CartLoadedState(:final items) => items,
          CartErrorState(:final items) => items,
          _ => const <CartItemEntity>[],
        };

        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
          body: items.isEmpty && state is CartErrorState
              ? _buildCartError(context, state.message)
              : items.isEmpty
              ? _buildEmptyCart()
              : _buildCartContents(context, items),
        );
      },
    );
  }

  Widget _buildEmptyCart() => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 72,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Add products to see them here.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );

  Widget _buildCartError(BuildContext context, String message) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          TextButton(
            onPressed: context.read<CartCubit>().loadCart,
            child: const Text('Try again'),
          ),
        ],
      ),
    ),
  );

  Widget _buildCartContents(BuildContext context, List<CartItemEntity> items) {
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    const taxRate = 0.1;
    final tax = subtotal * taxRate;
    final total = subtotal + tax;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final cartCubit = context.read<CartCubit>();
              return CartItemCard(
                cartItem: item,
                onQuantityChanged: (quantity) =>
                    cartCubit.updateQuantity(item.id, quantity),
                onRemove: () => cartCubit.removeItem(item.id),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow('Subtotal:', subtotal),
                const SizedBox(height: 12),
                _buildSummaryRow('Tax (10%):', tax),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Checkout',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Processing Checkout...'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppTheme.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
      Text(
        '\$${amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ],
  );
}
