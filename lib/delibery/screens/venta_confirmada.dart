import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';

class VentaConfirmadaScreen extends StatelessWidget {
  const VentaConfirmadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green
              ),
              child: Icon(Icons.check_circle, size: 80, color: Colors.white,)
            ),

            Text("¡Order confirmada!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Tenemos registro de tu venta ya puedes verla en Mis pedidos, en el menu principal",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 20),

            Text("Order id: ${context.watch<PizzaServices>().salesId}"),

            Text("Entregado: Aprox en 30 min..."),

            ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  context.read<PizzaServices>().clearCarrito(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'CONTINUAR COMPRANDO',
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