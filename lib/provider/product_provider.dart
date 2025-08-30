
import 'package:ecommerce/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class ProductProvider extends ChangeNotifier {

    final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Product> _allProducts = [];
  List<Product> _originalFilteredList = []; 
  List<Product> filteredlist = [];
 late final  Product product;
 List<Product> cartlist=[];
 List<int> quantity=[];
  bool _isloading = false;
  bool get isloading => _isloading;
List <String> favid=[];
  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => filteredlist;
    List<Product> favs=[];


void increasequantity(int index, String productId) async {
  quantity[index]++; 

  final uid = FirebaseAuth.instance.currentUser?.uid;

  final cartRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('cart')
      .doc(productId);  

  final snapshot = await cartRef.get();

  if (snapshot.exists) {
    await cartRef.update({
      "quantity": FieldValue.increment(1),
      
    });
  }
  notifyListeners();
}

void decreasequantity(int index, String productId) async {
  if (quantity[index] > 1) {
    quantity[index]--; 

    final uid = FirebaseAuth.instance.currentUser?.uid;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId);

    final snapshot = await cartRef.get();

    if (snapshot.exists) {
      await cartRef.update({
        "quantity": FieldValue.increment(-1),
      });
    }
    notifyListeners();
  }
}


int getQuantityById(String productId) {
  int index = cartlist.indexWhere((p) => p.id.toString() == productId);
  if (index != -1 && index < quantity.length) {
    return quantity[index];
  }
  return 0;
}



Future<void> addToCart(String itemId) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;



  if (uid == null) {
    throw Exception("User not logged in");
  }

  final cartRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('cart')
      .doc(itemId);

  final snapshot = await cartRef.get();

    await cartRef.set({
      "quantity": 1,
      "addedAt": FieldValue.serverTimestamp(),
    });
  
}

Future<void> addToFav(String itemId) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;



  if (uid == null) {
    throw Exception("User not logged in");
  }

  final favRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('Fav')
      .doc(itemId);

  final snapshot = await favRef.get();
  if(snapshot.exists){
    await favRef.delete();
    favid.remove(itemId);
  }
   else{
    await favRef.set({
      "favourite":true,

    },
);
        favid.add(itemId);

   }

   notifyListeners();
  
}






Future<List< Map<String,dynamic>>> fetchid() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;

  final cart=await FirebaseFirestore.instance.collection('users').doc(uid).collection('cart').get();
  final items=cart.docs.map((doc) {
    final data=doc.data();

    return{
    "id":doc.id,

    "quantity":data["quantity"],

    };


     

  } ).toList();

  return items;

}

Future<void> fetchFav() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final favDocs = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('Fav')
      .get();

  favid = favDocs.docs.map((doc) => doc.id).toList();

  favs = allProducts
      .where((prod) => favid.contains(prod.id.toString()))
      .toList();

  notifyListeners();
}



void loaddata()async{
  try{
    final cartdata=await fetchid();
    cartlist.clear();
    quantity.clear();
    for(var item in cartdata){
      print("id${item['id']}  quantity ${item["quantity"]}",);
      for(var prod in allProducts ){
        if(prod.id.toString()==item['id']){
          cartlist.add(prod);
          quantity.add(item['quantity']);
          print(item['quantity']);
        }
      }
    }
    notifyListeners();
  }catch(e){
    print("eeeeeeeeeeeeeeeeeeeerrror${e}");
  }
}




  Future<void> fetchdata() async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsondata = jsonDecode(response.body);
        _allProducts = jsondata.map((e) => Product.fromJson(e)).toList();
        _originalFilteredList = _allProducts; // 🆕
        filteredlist = _allProducts;
      }
    } catch (e) {
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrror,$e");
    }
    _isloading = false;
    notifyListeners();
  }

  void filteredbycategory(String category) {
    if (category.toLowerCase() == 'all') {
      _originalFilteredList = _allProducts;
    } else {
      _originalFilteredList = _allProducts
          .where((product) => product.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    filteredlist = _originalFilteredList; 
    notifyListeners();
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredlist = _originalFilteredList;
    } else {
      filteredlist = _originalFilteredList
          .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
