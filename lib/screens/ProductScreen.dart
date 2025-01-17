import 'package:flutter/material.dart';
import 'package:flutter_small_milk_shop/models/Variant.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Product.dart';
import '../utils/Constants.dart';

class ProductScreen extends StatefulWidget {

  final String title;

  const ProductScreen({super.key, required this.title});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const String apiUrl = Constants.BASE_URL + Constants.PRODUCT_ROUTE; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          products = (jsonData['data'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        showError('Failed to load products');
      }
    } catch (e) {
      showError('An error occurred: $e');
      print(e);
    }
  }

  void showError(String message) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchProducts,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              child: ListTile(
                leading: product.image_path.isNotEmpty
                    ? Image.network(
                  product.image_path,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image_not_supported),
                title: Text(product.name),
                subtitle: Text(
                  product.variants.isNotEmpty
                      ? 'Variants: ${product.variants.length}'
                      : 'No variants available',
                ),
                onTap: () {
                  // Add navigation to ProductDetailScreen if required
                },
              ),
            );
          },
        ),
      ),
    );
  }
}