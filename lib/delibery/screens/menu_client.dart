import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';
import 'package:sales_firebase_flutter/services/auth_services.dart';

class MenuClientScreen extends StatelessWidget {
  MenuClientScreen({super.key});


  List<Map> menus = [
    {
      "title":"Información Personal",
      "icon":Icons.person,
    },
    {
      "title":"Mis pedidos",
      "icon":Icons.format_list_numbered_sharp,
    },
    {
      "title":"Cerrar Sesión",
      "icon":Icons.logout,
    }
  ];

  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: 20),

            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.purple,
                child: Icon(Icons.person_3_rounded, size: 40, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Hola ${ context.read<UserServices>().getNameClient() }', 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 400,
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: (){

                      var menuSeleted = menus[i]["title"];

                      if (menuSeleted == "Información Personal") {
                        context.read<UserServices>().defineData();
                        Navigator.pushNamed(context, '/updateClient');
                      }

                      if ( menuSeleted == "Mis pedidos"){
                        context.read<PizzaServices>().getVentaClient(context.read<UserServices>().userInfo['nombre']);
                        Navigator.pushNamed(context, "/myOrders");
                      }

                      if ( menuSeleted == "Cerrar Sesión"){
                        Navigator.pushNamed(context, "/login");
                      }

                    },
                    child: ListTile(
                      leading: Icon(menus[i]["icon"]),
                      title: Text(menus[i]["title"]),
                    ),
                  );
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}