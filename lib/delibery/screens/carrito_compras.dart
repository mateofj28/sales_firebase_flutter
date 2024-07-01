import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';

class CarritoComprasScreen extends StatelessWidget {
  const CarritoComprasScreen({super.key});


  Future<void> _showDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false, // Evita que el usuario cierre el diálogo presionando fuera de él
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Productos'),
          content: Text('¿Estás seguro de que quieres eliminar todos los productos del carrito?, esto te sacara de la ventana actual.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop('cerrar');
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
              ),
              onPressed: () {
                Navigator.of(context).pop('aceptar');
              },
              child: Text('Eliminar', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );

    if (result == 'aceptar') {
      // El usuario hizo clic en "Aceptar"
      context.read<PizzaServices>().clearCarrito(context);
    } 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de compras"),
        actions: [
          IconButton(
            onPressed: (){
              _showDialog(context);
            }, icon: const Icon(Icons.delete_sweep_rounded))
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: 400,
              child: ListView.builder(
                itemCount: context.watch<PizzaServices>().pizzasCarrito.length,
                itemBuilder: (context, i){
                  var pizzaCarrito = context.watch<PizzaServices>().pizzasCarrito[i];
                  return Container(
                    width: 300,
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                          width: 100,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Icon(Icons.local_pizza_rounded, color: Colors.black,),
                          ),
                        ),


                        Container(
                          width: 250,
                          height: double.infinity,
                          // color: Colors.red[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(pizzaCarrito['nombre'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                              Text(pizzaCarrito['precio'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green)),

                              SizedBox(height: 10,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Qty: ${pizzaCarrito['cantidad'].toString()}"),

                                  Row(
                                    children: [
                                      FloatingActionButton(
                                        onPressed: (){
                                          context.read<PizzaServices>().addQtyCarrito(i);
                                        },
                                        mini: true,
                                        backgroundColor: Colors.green[100],
                                        child: Icon(Icons.add),
                                      ),

                                      
                                      FloatingActionButton(
                                        onPressed: (){
                                          context.read<PizzaServices>().removeQtyCarrito(i);
                                        },
                                        mini: true,
                                        backgroundColor: Colors.red[100],
                                        child: Icon(Icons.remove),
                                      )
                                    ],
                                  ),                              
                                ],
                              ),

                              

                              SizedBox(height: 15,),

                              Text("Categoria: ${pizzaCarrito['categoria']}"),

                            ],
                          ),
                        ),

                        

                      ],
                    ),
                  );
                }
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  width: 190,
                  height: 50,
                  // color: Colors.red[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:", style: TextStyle(fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(context.watch<PizzaServices>().valorTotal, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                      )
                    ],
                  ),
                )


              ],
            ),

            Container(
              width: double.infinity,
              height: 230,
              color: Colors.amber[100],
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [

                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white                    
                      ),
                      child: Icon(Icons.location_on, color: Colors.orange)
                    ),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      Navigator.pushNamed(context, "/createAddress");
                    },),
                    title: Text("Casa"),
                    subtitle: Text(context.watch<UserServices>().address.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
                  ),

                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white                    
                      ),
                      child: Icon(Icons.timer, color: Colors.orange)
                    ),
                    title: Text("Tiempo de entrega"),
                    subtitle: Text("30 min", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
                  ),

                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white                    
                      ),
                      child: Icon(Icons.monetization_on_rounded, color: Colors.orange)
                    ),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      context.read<PizzaServices>().showPaymentMethodModal(context);
                    },),
                    title: Text("Metodo de Pago"),
                    subtitle: Text(context.watch<PizzaServices>().metodoPago, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
                  ),

                ],
              ),
            ),

            SizedBox(height: 10,),

            ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  context.read<PizzaServices>().createVenta(context, context.read<UserServices>().userInfo);     
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4CAF50)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal:100.0, vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'Comprar',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            
            
          ],
        )
      ),
    );
  }
}


// final pizza = {
//                                             "categoria": pizzas[i]['categoria'],
//                                             "nombre": pizzas[i]['nombre'],
//                                             "precio": pizzas[i]['precio'],
//                                             "ingredientes": pizzas[i]['ingredientes'],   
//                                           };