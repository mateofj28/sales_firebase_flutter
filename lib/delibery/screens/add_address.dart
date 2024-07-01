import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';

class AddAddressScreen extends StatelessWidget {

  final List<String> items = [
    'Calle 15 # 13-11, Armenia, Quindío',
    'Carrera 14 # 22-31, Armenia, Quindío',
    'Avenida Centenario # 19-35, Armenia, Quindío',
    'Calle 19 # 14-62, Armenia, Quindío'
  ];


  AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar direccion"), centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: context.watch<UserServices>().address,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Direccion',
                    prefixIcon: const Icon(Icons.directions),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
      
              Container(
                width: double.infinity,
                height: 450,
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: context.watch<UserServices>().userInfo['direcciones'].length,
                  itemBuilder: (context, i){
                    return ListTile(
                      leading: Icon(Icons.location_on_outlined),
                      title: Text(context.watch<UserServices>().userInfo['direcciones'][i]),
                      onTap: (){
                        context.read<UserServices>().selectAddress(context.read<UserServices>().userInfo['direcciones'][i]);
                      },
                    );
                  }
                ),
              )
              
      
              
      
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<UserServices>().addAddress(context);
        },
        child: Icon(Icons.add_location_alt_outlined),
      ),
    );
  }

}

