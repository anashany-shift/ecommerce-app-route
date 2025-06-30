import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/domain/repos/ProductsRepo/products_repo.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manger/products_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/Products_catalog_argument.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  ProductsCatalogArgument? productsCatalogArgument;
  ProductsScreen(this.productsCatalogArgument, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ProductsCubit(getIt<ProductsRepo>())
        ..loadProducts(
            category: productsCatalogArgument?.category,
            subCategory: productsCatalogArgument?.subCategory,
            brand: productsCatalogArgument?.brand),
      child: Scaffold(
        appBar: const HomeScreenAppBar(
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsSuccess) {

                      final product = state.product;
                      return GridView.builder(
                        itemCount: product.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: .65,
                        ),
                        itemBuilder: (context, index) {
                          return CustomProductWidget(
                            product: product[index],
                            height: height,
                            width: width,
                          );
                        },
                        scrollDirection: Axis.vertical,
                      );
                    } else if (state is ProductsError) {

                      return Center(
                        child: Text(state.errorMessage),
                      );
                    } else if (state is ProductsEmpty) {

                      return const Center(
                        child: Text(
                          "No products found",
                          style: TextStyle(fontSize: 30,color: Colors.black),
                        ),
                      );
                    } else {


                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
