import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
              'Hola ${ _auth.currentUser!['nombre'] }', 
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
                        Navigator.pushNamed(context, '/updateClient');
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