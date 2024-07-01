import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/menuClient');
          }, 
          icon: const Icon(Icons.menu)
        ),
        title: InkWell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              context.watch<UserServices>().getAddressClient(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, '/createAddress');
          },  
        ),
        centerTitle: true,
        actions: [
          Text(context.watch<PizzaServices>().pizzasCarrito.length.toString()),
          IconButton(
            onPressed: (){

              if (context.read<PizzaServices>().pizzasCarrito.isNotEmpty ){
                context.read<PizzaServices>().formatearPrecioTotal();
                Navigator.pushNamed(context, '/carritoCompras');
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Advertencia'),
                    content: const Text('Por favor seleccione una pizza'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  )
                );
              }
              
            }, 
            icon: const Icon(Icons.shopping_cart_checkout_rounded)
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 750,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("pizzas").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var pizzas = snapshot.data?.docs;

                    return ListView.builder(
                      itemCount: pizzas?.length,
                      itemBuilder: (context, i){
                        return Container(
                          width: 300,
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width:90,
                                height: 160,
                                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.local_pizza_rounded),
                              ),

                              Container(
                                width: 270,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Row( 
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [ 
                                        Text(pizzas?[i]['nombre'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),  
                                        Text(
                                          pizzas![i]['precio'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green
                                          )
                                        )
                                        
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        Text("Categoria: ${pizzas[i]['categoria']}", style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text("Ingredientes: ${pizzas[i]['ingredientes'].length } ",
                                          style: const TextStyle(fontSize: 16) 
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 5),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FloatingActionButton(onPressed: (){

                                          final pizza = {
                                            "categoria": pizzas[i]['categoria'],
                                            "nombre": pizzas[i]['nombre'],
                                            "precio": pizzas[i]['precio'],
                                            "ingredientes": pizzas[i]['ingredientes'],   
                                          };    

                                          context.read<PizzaServices>().agregarPizzaCarrito(pizza);
                                        }, mini: true, child: const Icon(Icons.add)),
                                      ],
                                    )                                    
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                ),
              ),
          ],
        )
      ),
    );
  }
}