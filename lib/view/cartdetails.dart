import 'package:ecommerce/Model/product.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Cartdetails extends StatefulWidget {
  final Product product;
  final int index;

  const Cartdetails({super.key, required this.product, required this.index});

  @override
  State<Cartdetails> createState() => _CartdetailsState();
}

class _CartdetailsState extends State<Cartdetails> {
  String limitWords(String text, int wordCount) {
    List<String> words = text.split(' ');
    if (words.length <= wordCount) {
      return text;
    }
    return words.take(wordCount).join(' ') + '...';
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchFav();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: true);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.contain,
                    height: 220,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            ListTile(
              title: Text(
                widget.product.title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  bool isFav =
                      provider.favid.contains(widget.product.id.toString());
                  return IconButton(
                    onPressed: () {
                      provider.addToFav(widget.product.id.toString());
                    },
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey<bool>(isFav),
                        color: isFav ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                limitWords(widget.product.description, 30),
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
Padding(
  padding: const EdgeInsets.all(10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // زرار -
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[400],
        ),
        width: 30,
        height: 30,
        child: Center(
          child: InkWell(
            onTap: () {
              provider.decreasequantity(
                provider.cartlist.indexWhere(
                  (p) => p.id.toString() == widget.product.id.toString(),
                ),
                widget.product.id.toString(),
              );
            },
            child: const Icon(Icons.minimize),
          ),
        ),
      ),
  
      const SizedBox(width: 10),
  
      Text(
        '${provider.getQuantityById(widget.product.id.toString())}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
  
      const SizedBox(width: 10),
  
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue[200],
        ),
        width: 30,
        height: 30,
        child: Center(
          child: InkWell(
            onTap: () {
              provider.increasequantity(
                provider.cartlist.indexWhere(
                  (p) => p.id.toString() == widget.product.id.toString(),
                ),
                widget.product.id.toString(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    ],
  ),
),





            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        provider.addToCart(widget.product.id.toString());
                      },
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                    //    StripeService.makePayment(20, "USD");
                      },
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
