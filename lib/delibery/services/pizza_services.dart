import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PizzaServices extends ChangeNotifier {
  final _nameController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _ingredienteController = TextEditingController();
  final _precioController = TextEditingController();
  final _codeSegurityController = TextEditingController();
  int _elementosCarrito = 0;
  String _valorTotal = "\$0";
  String _metodoPago = "efectivo";
  String _salesId = "wwww";
  int _index = Random().nextInt(10);
  List<Map<String, dynamic>> _salesFiltered = [];
  double _valorTotalInNumber = 0.0;
  final CollectionReference firePizzas =
      FirebaseFirestore.instance.collection('pizzas');
  final CollectionReference fireVentas =
      FirebaseFirestore.instance.collection('ventas');
  final CollectionReference fireSegurity =
      FirebaseFirestore.instance.collection('segurity');

  TextEditingController get name => _nameController;
  List<Map<String, dynamic>> get salesFiltered => _salesFiltered;
  String get salesId => _salesId;

  int get elementosCarrito => _elementosCarrito;
  int get index => _index;
  TextEditingController get categoria => _categoriaController;
  TextEditingController get codeSegurity => _codeSegurityController;
  TextEditingController get ingrediente => _ingredienteController;
  TextEditingController get precio => _precioController;
  String get valorTotal => _valorTotal;
  String get metodoPago => _metodoPago;
  double get valorTotalInNumber => _valorTotalInNumber;

  List<String> ingredientes = [];
  List<Map> pizzasCarrito = [];

  segurity(BuildContext context) async {
    // DocumentSnapshot documentSnapshot = await fireSegurity.doc("GdMD966T26sp47swkbNf").get();
    // var segurityData = documentSnapshot.data() as Map<String, dynamic>;

    List<String> tokens = [
      "ABCDEF", //0
      "GCDHG", //1
      "CBFDBA", //2
      "FEABCA", //3
      'BGCFHD', //4
      "ABHFCD", //5
      "HGFDBA", //6
      "FEADGB", //7
      "DBFAGH", //8
      'ABFCHD' //9
    ];

    // Obtener el token seleccionado
    String selectedToken = tokens[_index];

    // Mostrar el token seleccionado y el índice
    print('Token seleccionado: $selectedToken');
    print('Índice del token: $_index');

    if (codeSegurity.text == selectedToken) {
      _index = Random().nextInt(tokens.length);
      notifyListeners();
      print("segurity code updated successfully!");
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    } else {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Codigo invalido actualiza la app'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ));
    }
  }

  setSaleId(String id) {
    _salesId = id;
    notifyListeners();
  }

  clearData() {
    _nameController.text = "";
    _categoriaController.text = "";
    _ingredienteController.text = "";
    _precioController.text = "";
    ingredientes = [];
    notifyListeners();
  }

  agregarPizzaCarrito(Map pizza) {
    int index =
        pizzasCarrito.indexWhere((item) => item['nombre'] == pizza['nombre']);

    if (index != -1) {
      // el elemento si existe
      pizzasCarrito[index]['cantidad']++;
    } else {
      pizza['cantidad'] = 1;

      pizzasCarrito.add(pizza);
      _elementosCarrito++;
      notifyListeners();
    }
  }

  clearCarrito(BuildContext context) {
    pizzasCarrito = [];
    Navigator.pushNamed(context, '/homeClient');
    notifyListeners();
  }

  addQtyCarrito(int i) {
    if (pizzasCarrito[i]['cantidad'] <= 15) {
      pizzasCarrito[i]['cantidad']++;
      formatearPrecioTotal();
      notifyListeners();
    }
  }

  void showPaymentMethodModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Seleccionar Método de Pago'),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Efectivo'),
                onTap: () {
                  _metodoPago = 'efectivo';
                  notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Tarjeta Débito'),
                onTap: () {
                  _metodoPago = 'tarjeta débito';
                  notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Tarjeta Crédito'),
                onTap: () {
                  _metodoPago = 'tarjeta crédito';
                  notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  createVenta(BuildContext context, var client) async {
    final venta = {
      "productos": pizzasCarrito,
      "cliente": client,
      "estado": "no adquirido",
      "fecha": DateTime.now(),
      "metodoPago": metodoPago,
      "precioTotal": valorTotalInNumber
    };

    try {
      DocumentReference ventaRef = await fireVentas.add(venta);
      setSaleId(ventaRef.id);
      Navigator.pushNamed(context, '/confirmSale');
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content:
                    const Text('Hubo un problema en el servicio crear venta'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ));
    }
  }

  void formatearPrecioTotal() {
    double total = 0.0;
    for (int i = 0; i < pizzasCarrito.length; i++) {
      total +=
          pizzasCarrito[i]['cantidad'] * int.parse(pizzasCarrito[i]['precio']);
    }

    _valorTotalInNumber = total;

    // Formatear el precio total con separador de miles y dos decimales
    String formattedTotal = total.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    _valorTotal = '\$' + formattedTotal;
  }

  getVentaClient(String name) async {
    QuerySnapshot querySnapshot = await fireVentas.get();
    List<Map<String, dynamic>> sales = [];
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      sales.add(data);
    }

    // Filtrar las ventas donde el nombre del cliente sea "sebas"
    List<Map<String, dynamic>> ventasFiltradas =
        sales.where((venta) => venta['cliente']['nombre'] == name).toList();
    _salesFiltered = ventasFiltradas;
    notifyListeners();
  }

  removeQtyCarrito(int i) {
    if (pizzasCarrito[i]['cantidad'] > 1) {
      pizzasCarrito[i]['cantidad']--;
      formatearPrecioTotal();
      notifyListeners();
    }
  }

  createPizza(BuildContext context) {
    var name = _nameController.text;
    var categoria = _nameController.text;
    var ingrediente = _nameController.text;
    var precio = _precioController.text;

    if (ingrediente.isEmpty ||
        name.isEmpty ||
        categoria.isEmpty ||
        precio.isEmpty) {
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
              ));
      return;
    }

    var pizza = {
      "nombre": name,
      "categoria": categoria,
      "ingredientes": ingredientes,
      "precio": precio,
    };

    print(pizza);

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
              ));
      clearData();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content:
                    const Text('Hubo un problema en el servicio crear pizza,'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ));
    }

    return 9;
  }

  addIngrediente(BuildContext context) {
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
              ));
      return;
    }

    print("hay data");
    _ingredienteController.text = "";
    ingredientes.add(ingrediente);
    notifyListeners();
  }
}
