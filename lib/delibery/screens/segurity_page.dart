import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';


class SegurityScreen extends StatelessWidget {

  


  SegurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              SizedBox(height: 30),
          
              CircleAvatar(
                radius: 45,
                child: Icon(Icons.password, size: 50),
              ),
          
              SizedBox(height: 30),
          
              Text("Delivery bloqueado", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
          
              Text("Debes de ingresar el codigo para ingresar a la app"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("No estas al dia con el pago, una vez lo hagas desapareceza esta ventana", textAlign: TextAlign.center,),
              ),

              Text(context.watch<PizzaServices>().index.toString(), style: TextStyle(color: Colors.grey[200], fontSize: 30)),


          
              SizedBox(height: 200),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: context.watch<PizzaServices>().codeSegurity,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Codigo de segurida',
                    prefixIcon: const Icon(Icons.fact_check_outlined),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),
          
              SizedBox(height: 30),
          
              ElevatedButton(
                  onPressed: () {
                    context.read<PizzaServices>().segurity(context);
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
                  child: Text('validar codigo', style: TextStyle(color: Colors.white),)
                ),
          
            ],
          ),
        ),
      )
    );
  }

}

