
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserServices extends ChangeNotifier {
  final _nameController = TextEditingController();
  final _placaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _addressController = TextEditingController();

  String _currentAddress = "N/A";

  Map<String, dynamic> userInfo = {"nombre": ""};

  final _nameClientController = TextEditingController();
  final _lastnameClientController = TextEditingController();
  final _telefonoClientController = TextEditingController();

  final CollectionReference fireUsuarios =
      FirebaseFirestore.instance.collection('usuarios');

  TextEditingController get name => _nameController;
  TextEditingController get placa => _placaController;
  TextEditingController get telefono => _telefonoController;

  TextEditingController get nameClient => _nameClientController;
  TextEditingController get lastClient => _lastnameClientController;
  TextEditingController get phoneClient => _telefonoClientController;
  TextEditingController get address => _addressController;
  String get currentAddress => _currentAddress;

  clearData() {
    _nameController.text = "";
    _placaController.text = "";
    _telefonoController.text = "";
    _nameClientController.text = "";
    _telefonoClientController.text = "";
    _lastnameClientController.text = "";
    notifyListeners();
  }

  defineData() {
    _nameClientController.text = userInfo['nombre'];
    _telefonoClientController.text = userInfo['telefono'];
    _lastnameClientController.text = userInfo['apellido'];
  }

  addAddress(BuildContext context) async {
    if (_addressController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Advertencia'),
                content: const Text('Agrega una direccion'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ));
    } else {
      userInfo['direccion'] = address.text;

      if (!userInfo['direcciones'].contains(address.text)){
        userInfo['direcciones'].add(address.text);
      }

      // listo para mandar...
      final prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("userId");

      final DocumentReference docRef = fireUsuarios.doc(id);

      try {
        await docRef.update(userInfo);
      } catch (e){
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      }

      DocumentSnapshot documentSnapshot = await fireUsuarios.doc(id).get();
      userInfo = documentSnapshot.data() as Map<String, dynamic>;

      print("usuario traido de la base de datos");
      print(userInfo);

      _currentAddress = userInfo['direccion'];
      notifyListeners();

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Info'),
            content: Text("Nueva direccion de entrega almacenada correctamente."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
    }
  }

  getUser(String id) async {
    print(id);
    DocumentSnapshot documentSnapshot = await fireUsuarios.doc(id).get();
    userInfo = documentSnapshot.data() as Map<String, dynamic>;
    notifyListeners();
  }

  selectAddress(String address){
    _addressController.text = address;
    notifyListeners();
  }

  createUser(BuildContext context) {
    var name = _nameController.text;
    var placa = _placaController.text;
    var telefono = _telefonoController.text;

    if (telefono.isEmpty || name.isEmpty || placa.isEmpty) {
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

    var user = {
      "nombre": name,
      "placa": placa,
      "telefono": telefono,
      "tipoUsuario": "repartidor"
    };

    try {
      fireUsuarios.add(user);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Info'),
                content: const Text('Repartidor creado'),
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
                content: const Text(
                    'Hubo un problema en el servicio crear repartidor,'),
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

  getNameClient() {
    if (userInfo['nombre'] != "") {
      return userInfo['nombre'];
    } else {
      return "?";
    }
  }

  getAddressClient() {
    if (userInfo['direccion'] != "") {
      return userInfo['direccion'];
    } else {
      return "N/A";
    }
  }

  updateClient(BuildContext context) async {
    String name = _nameClientController.text;
    String apellido = _lastnameClientController.text;
    String telefono = _telefonoClientController.text;

    if (telefono.isEmpty || name.isEmpty || apellido.isEmpty) {
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

    var newUser = {
      "nombre": name,
      "apellido": apellido,
      "telefono": telefono,
    };

    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");

    final DocumentReference docRef = fireUsuarios.doc(id);

    try {
      await docRef.update(newUser);

      DocumentSnapshot documentSnapshot = await fireUsuarios.doc(id).get();
      userInfo = documentSnapshot.data() as Map<String, dynamic>;

      notifyListeners();

      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Info'),
          content: const Text('Campos agregados correctamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
      clearData();
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Advertencia'),
          content: const Text('Error al grabar los campos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }
}
