import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuAdminScreen extends StatelessWidget {
  MenuAdminScreen({super.key});


  List<Map> menus = [
    {
      "title":"Información Personal",
      "icon":Icons.person,
    },
    {
      "title":"Crear Repartidor",
      "icon":Icons.person_add_rounded,
    },
    {
      "title":"Crear Pizza",
      "icon": Icons.local_pizza_rounded,
    },
    {
      "title":"Cerrar Sesión",
      "icon":Icons.logout,
    }
  ];

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
                backgroundColor: Colors.blue,
                child: Icon(Icons.person_3_rounded, size: 40, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Hola Jaime", 
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

                      if (menuSeleted == "Crear Repartidor") {
                        Navigator.pushNamed(context, '/createRepartidor');
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