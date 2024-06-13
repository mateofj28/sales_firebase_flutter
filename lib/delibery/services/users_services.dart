import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserServices extends ChangeNotifier {


  final _nameController = TextEditingController();
  final _placaController = TextEditingController();
  final _telefonoController = TextEditingController();
  

  final CollectionReference fireUsuarios = FirebaseFirestore.instance.collection('usuarios');

  TextEditingController get name => _nameController;
  TextEditingController get placa => _placaController;
  TextEditingController get telefono => _telefonoController;
  


  

  clearData(){
    _nameController.text = "";
    _placaController.text = "";
    _telefonoController.text = "";
    notifyListeners();
  }



  createUser(BuildContext context){

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
        )
      );
      return;
    }

    
    var user = {
      "nombre":name,
      "placa":placa,
      "telefono": telefono,
      "tipoUsuario": "repartidor"
    };

    print(user);

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
        )
      );
      clearData();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Hubo un problema en el servicio crear repartidor,'),
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

  


}