import 'package:ecommerce/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class buildcategorylist extends StatefulWidget {
  const buildcategorylist({super.key});

  @override
  State<buildcategorylist> createState() => _buildcategorylistState();
}

class _buildcategorylistState extends State<buildcategorylist> {
  String selectedCategory = 'all'; 

  @override
  Widget build(BuildContext context) {
    final categories = [
      'all',
      'electronics',
      'jewelery',
      "men's clothing",
      "women's clothing"
    ];
    final provider = Provider.of<ProductProvider>(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              provider.filteredbycategory(category);
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selectedCategory == category
                    ? Colors.blue
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    color: selectedCategory == category
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
