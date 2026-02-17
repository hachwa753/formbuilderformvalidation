import 'package:flutter/material.dart';
import 'package:flutter_api_fetch/core/extensions/extension.dart';
import 'package:flutter_api_fetch/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_api_fetch/features/products/presentation/screens/detail_page.dart';
import 'package:flutter_api_fetch/features/products/presentation/widgets/shimmer_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final state = context.read<ProductBloc>().state;
    if (!state.isLoading &&
        !state.hasMaxedPosts &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
      context.read<ProductBloc>().add(LoadMoreProduct());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<ProductBloc, ProductState, ProductState>(
          selector: (state) => state,
          builder: (context, state) {
            return Text(
              "Total posts -  ${state.product.length} / ${state.totalPosts}",
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.productStatus == ProductStatus.loading &&
              state.product.isEmpty) {
            return ShimmerContainer();
          }
          if (state.productStatus == ProductStatus.loaded) {
            if (state.product.isEmpty) {
              return Center(child: Text("Empty products"));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(FetchProductEvent());
              },
              child: ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.product.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.product.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final product = state.product[index];
                  return Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: -10,
                        child: IconButton(
                          onPressed: () {
                            context.read<ProductBloc>().add(
                              DeletePost(product.id),
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailPage(product: product),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Text((index + 1).toString()),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 2,
                                          product.title.captitalizeFirst(),
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          product.body.captitalizeFirst(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
