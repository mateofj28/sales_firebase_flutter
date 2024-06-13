import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';

class CreatePizzaScreen extends StatelessWidget {
  const CreatePizzaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear pizza"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            SizedBox(height: 40),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: context.watch<PizzaServices>().name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Nombre',
                  prefixIcon: const Icon(Icons.local_pizza),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: context.watch<PizzaServices>().categoria,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Categoria',
                  prefixIcon: const Icon(Icons.local_pizza_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: context.watch<PizzaServices>().ingrediente,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Ingrediente',
                  prefixIcon: const Icon(Icons.fact_check_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 10),
        
            ElevatedButton(
              onPressed: () {
                // Acción del botón
                // handleLogin();
                context.read<PizzaServices>().addIngrediente(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF008000)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Icon(Icons.add, color: Colors.white,)
            ),
        
            SizedBox(height: 10),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: context.watch<PizzaServices>().precio,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Precio',
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            ElevatedButton(
              onPressed: () {
                // Acción del botón
                // handleLogin();
                context.read<PizzaServices>().createPizza(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF008000)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text("GUARDAR", style: TextStyle(color: Colors.white),)
            ),
        
            SizedBox(height: 30),
        
            Text(
              "Ingredientes agregados: ${context.watch<PizzaServices>().ingredientes.length}",
              style: TextStyle(fontSize: 15),
            )
        
        
          ],
        ),
      ),
    );
  }
}