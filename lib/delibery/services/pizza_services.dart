import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PizzaServices extends ChangeNotifier {


  final _nameController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _ingredienteController = TextEditingController();
  final _precioController = TextEditingController();
  int _elementosCarrito = 0;
  String _valorTotal = "\$0";
  String _metodoPago = "efectivo";
  double _valorTotalInNumber = 0.0;
  final CollectionReference firePizzas = FirebaseFirestore.instance.collection('pizzas');
  final CollectionReference fireVentas = FirebaseFirestore.instance.collection('ventas');

  TextEditingController get name => _nameController;
  int get elementosCarrito => _elementosCarrito;
  TextEditingController get categoria => _categoriaController;
  TextEditingController get ingrediente => _ingredienteController;
  TextEditingController get precio => _precioController;
  String get valorTotal => _valorTotal;
  String get metodoPago => _metodoPago;
  double get valorTotalInNumber => _valorTotalInNumber;


  List<String> ingredientes = [];
  List<Map> pizzasCarrito = [];

  clearData(){
    _nameController.text = "";
    _categoriaController.text = "";
    _ingredienteController.text = "";
    _precioController.text = "";
    ingredientes = [];
    notifyListeners();
  }

  agregarPizzaCarrito(Map pizza){

    int index = pizzasCarrito.indexWhere((item) => item['nombre'] == pizza['nombre']);

    if (index != -1){
      // el elemento si existe
      pizzasCarrito[index]['cantidad']++;
    }else {

      pizza['cantidad'] = 1;

    pizzasCarrito.add(pizza);
    _elementosCarrito++;
    notifyListeners();

    }
  }

  clearCarrito(BuildContext context){
    pizzasCarrito = [];
    Navigator.pushNamed(context, '/homeClient');
    notifyListeners();
  }

  addQtyCarrito(int i){

    if (pizzasCarrito[i]['cantidad'] <= 15){
      pizzasCarrito[i]['cantidad']++;
      formatearPrecioTotal();
      notifyListeners();
    }

    
  }

  createVenta(BuildContext context){

    final venta = {
      "productos": pizzasCarrito,
      "estado": "no adquirido",
      "fecha": DateTime.now(),
      "metodoPago": metodoPago,
      "precioTotal": valorTotalInNumber    
    };

    try {
      fireVentas.add(venta);
      Navigator.pushNamed(context, '/confirmSale');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Hubo un problema en el servicio crear venta'),
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

  }

  void formatearPrecioTotal() {
    double total = 0.0;
    for (int i = 0; i < pizzasCarrito.length; i++) {
      total += pizzasCarrito[i]['cantidad'] * pizzasCarrito[i]['precio'];
    }

    _valorTotalInNumber = total;
    
    // Formatear el precio total con separador de miles y dos decimales
    String formattedTotal = total.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},',
    );
    
    _valorTotal = '\$' + formattedTotal;
}


  removeQtyCarrito(int i){
    if (pizzasCarrito[i]['cantidad'] > 1){
      pizzasCarrito[i]['cantidad']--;
      formatearPrecioTotal();
      notifyListeners();
    } 
  }

  createPizza(BuildContext context){

    var name = _nameController.text;
    var categoria = _nameController.text;
    var ingrediente = _nameController.text;
    var precio = _precioController.text;

    if (ingrediente.isEmpty || name.isEmpty || categoria.isEmpty || precio.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Advertencia'),
          content: const Text('Por favor complete todos los campos'),
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
      return;
    }

    var pizza = {
      "nombre":name,
      "categoria":name,
      "ingredientes": ingredientes,
      "precio":precio,
    };

    try {
      firePizzas.add(pizza);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Info'),
          content: const Text('Pizza creada'),
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
      clearData();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Hubo un problema en el servicio crear pizza,'),
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



    return 9;
  }

  addIngrediente(BuildContext context){
    var ingrediente = _ingredienteController.text;

    if (ingrediente.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Advertencia'),
          content: const Text('Por favor agrega un ingrediente'),
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
      return;
    }

    print("hay data");
    _ingredienteController.text = "";
    ingredientes.add(ingrediente);
    notifyListeners();
  }


}