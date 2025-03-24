import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/loader.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/features/home/services/home_services.dart';
import 'package:flutter_amazon/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_amazon/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(widget.category, style: TextStyle(color: Colors.black)),
        ),
      ),
      body:
          productList == null
              ? Loader()
              :  Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Keep shopping for ${widget.category}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15),
                      itemCount: productList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 0, right: 15, top: 5),
                                child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
