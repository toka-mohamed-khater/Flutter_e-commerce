import 'package:ecommerce/Model/product.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:provider/provider.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

@override
void initState() {
  super.initState();
  Future.microtask(() =>
    Provider.of<ProductProvider>(context, listen: false).loaddata()
  );
}



  int count=0;
  @override
  Widget build(BuildContext context) {

                 final provider = Provider.of<ProductProvider>(context);



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
 Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'hello',)),
    );          
             
        },),
          title: const Text(
    "My Cart",
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),

        ),
        body: ListView.builder(
        
          itemCount: provider.cartlist.length,
          itemBuilder: (context, index) {
                         var quantity =provider.quantity[index];
              bool isFav = provider.favid.contains(provider.cartlist[index].id);


            return Card(
                color: Colors.white,   
  elevation: 0,                

              child: Column(
                
                children: [
                  Row(
                    children: [
                     
                      Container(
                       decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.grey[200]!,
      Colors.grey[400]!, 
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(12), 
),
 child: Image.network('${provider.cartlist[index].image}',height: 100,
 width: MediaQuery.of(context).size.width*0.2,
                        
                        
                        
                                            
                        
                        ),
                        
                      ),
                      SizedBox(width: 30,),
    Expanded( 
      child: Text(
provider.cartlist[index].title,
        maxLines: 2,           
        overflow: TextOverflow.ellipsis, 
        style: TextStyle(fontSize: 16),
      ),
    ),

   Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  bool isFav =
                      provider.favid.contains(provider.cartlist[index].id.toString());
                  return IconButton(
                    onPressed: () {
                      provider.addToFav(provider.cartlist[index].id.toString());
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


                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(

                    children: [
                                                                  SizedBox(width: 30,),

                      Container(
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                                                 color: Colors.grey[400],

                        ),
                        width: 30,
                        height: 30,
                        
                      
                        child: 
                        Center(child: 
                        InkWell(
                          onTap: (){
                            provider.decreasequantity(index,provider.cartlist[index].id.toString());



                          
                          },
                          child: 
                          Center(child: Icon(Icons.minimize,))))),
                                            SizedBox(width: 10,),

                    Text('${quantity}'),
                                        SizedBox(width: 10,),

 Container(
   decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                        color: Colors.blue[200],

                        ),
                       
                        width: 30,
                        height: 30,
                        child:
                         InkWell(
                          onTap: (){

                            provider.increasequantity(index,provider.cartlist[index].id.toString());
                          },
                          child: 
                          Center(child: Icon(Icons.add)))),

                        SizedBox(width: MediaQuery.of(context).size.width*0.4,),

                        Text('${provider.cartlist[index].price} \$ ',style: TextStyle(color:Colors.black,fontSize: 23,fontWeight: FontWeight.bold),)
                                         ],
                  )
                  ,SizedBox(height: 10,),
                ],
              ),
            );
            
          }

        ),
    );
  }

}