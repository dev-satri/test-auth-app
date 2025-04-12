import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/di.dart';
import 'package:frontend/src/core/extensions/build_context.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_bloc.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_event.dart';
import 'package:frontend/src/features/product/presentation/blocs/product_state.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>()..add(FetchAllProductEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Page'),
          actions: [
            BlocBuilder<ProductBloc, ProductState>(
              buildWhen:
                  (previous, current) =>
                      previous.isFetching != current.isFetching,
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(FetchAllProductEvent());
                  },
                  icon: Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listenWhen: (p, c) => p.failure != c.failure,
          listener: (context, state) {
            if (state.failure != null) {
              context.showSnackbar(state.failure!.message, isError: true);
            }
          },
          builder: (context, state) {
            if (state.isFetching) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.productModel == null || state.productModel!.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            if (state.failure != null) {
              ///Error UI
              return Center(child: Text(state.failure!.message));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(FetchAllProductEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.productModel!.length,
                itemBuilder: (context, index) {
                  final product = state.productModel![index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productTitle ?? 'No Title',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product.productDesc ?? 'No Description',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.inventory, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Available: ${product.availableStock}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: InkWell(
                            onTap: () {
                              //TODO(Sangam): Add Deletion Logic
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
