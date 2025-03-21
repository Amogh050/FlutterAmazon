import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/loader.dart';
import 'package:flutter_amazon/features/account/widgets/single_product.dart';
import 'package:flutter_amazon/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon/features/admin/services/admin_services.dart';
import 'package:flutter_amazon/models/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(
      context,
      AddProductScreen.routeName,
    ).then((_) => fetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
          body: GridView.builder(
            itemCount: products!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final productData = products![index];
              return Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleProduct(image: productData.images[0]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteProduct(productData, index),
                        icon: Icon(Icons.delete_outline_outlined),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: navigateToAddProduct,
            tooltip: 'Add a product',
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
  }
}
