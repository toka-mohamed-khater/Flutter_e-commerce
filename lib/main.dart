import 'package:ecommerce/payment_ways/Stripe_key.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/view/cart.dart';
import 'package:ecommerce/view/favourite.dart';
import 'package:ecommerce/view/login.dart';
import 'package:flutter/material.dart';
import './view/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import './provider/auth_provider.dart';
import 'provider/product_provider.dart';
import './widgets/categorylist.dart';
import './widgets/productcard.dart';

void main() async {
//  Stripe.publishableKey=Apikeys.Publishablekey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), 
       ChangeNotifierProvider(create: (_) => ProductProvider()..fetchdata()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
  theme: ThemeData(
    scaffoldBackgroundColor: Colors.white, 
  ),

      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).filteredProducts;
        final provider = Provider.of<ProductProvider>(context);
                final providerauth = Provider.of<AuthProvider>(context);



return Scaffold(
  backgroundColor: Colors.white,
  appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.jpg'),
          radius: 18,
        ),
        const SizedBox(width: 10),
        FutureBuilder<String?>(
          future: providerauth.getUserName(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Hello...',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Text(
                'Hello 👋',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            }
            return Text(
              'Hello, ${snapshot.data} 👋',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.logout, color: Colors.black),
        onPressed: () {
     providerauth.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
        },
      ),
      const SizedBox(width: 5),
    ],
  ),
  body: Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      children: [
        TextField(
          controller: provider.searchController,
          decoration: InputDecoration(
            fillColor: Colors.grey[100],
            hintText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.menu_open),
          ),
          onChanged: (value) {
            Provider.of<ProductProvider>(context, listen: false)
                .searchProduct(value);
          },
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Featured Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length > 5 ? 5 : products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 160, 
                margin: const EdgeInsets.only(right: 10),
                child: buildProductCard(product, index, context),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const buildcategorylist(),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return buildProductCard(products[index], index, context);
            },
          ),
        ),
      ],
    ),
  ),
);
  }
}
